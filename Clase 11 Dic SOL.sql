USE BD_GestionAcademica;

-- 1. Procedimiento almacenado cifrado (`WITH ENCRYPTION`) que descifra las notas finales.
CREATE PROCEDURE sp_DescifrarNotas
WITH ENCRYPTION
AS
BEGIN
    SELECT 
        EstudianteID,
        Nombre,
        Apellido,
        CONVERT(NVARCHAR(10), DecryptByPassPhrase('ClaveSecreta', NotaFinalCifrada)) AS NotaDescifrada
    FROM Estudiantes;
END;

-- Crear un rol para limitar el acceso al procedimiento
CREATE ROLE RolAutorizado;

-- Otorgar permisos de ejecución del procedimiento al rol
GRANT EXECUTE ON sp_DescifrarNotas TO RolAutorizado;

-- Asignar un usuario al rol (reemplaza 'UsuarioSQL' con un nombre real)
EXEC sp_addrolemember 'RolAutorizado', 'UsuarioSQL';


WITH ENCRYPTION
WITH EXECUTE AS 'UsuarioAutorizado'


-- 2. Transacción con SAVE TRAN y ROLLBACK TO
BEGIN TRANSACTION;

INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, Correo, FechaNacimiento, NotaFinalCifrada)
VALUES (4, 'Sofía', 'Martínez', 'sofia.martinez@mail.com', '2000-12-15', EncryptByPassPhrase('ClaveSecreta', '4.2'));

SAVE TRAN Punto1;

INSERT INTO Inscripciones (InscripcionID, EstudianteID, CursoID, FechaInscripcion, Estado)
VALUES (5, 4, 1, '2023-12-01', 'Inscrito');

-- Realizamos un rollback parcial al punto de guardado
ROLLBACK TRANSACTION Punto1;

-- Confirmamos la transacción (solo se mantiene el estudiante)
COMMIT;

-- 3. SELECT con WITH(NOLOCK)
SELECT *
FROM Inscripciones WITH (NOLOCK);

-- 4. Consulta que utiliza UNION para combinar nombres de estudiantes y cursos
SELECT Nombre AS NombreEntidad FROM Estudiantes
UNION
SELECT NombreCurso AS NombreEntidad FROM Cursos;

-- 5. Consulta con CASE para clasificar las notas finales como "Aprobado" o "Reprobado"
SELECT 
    Nombre,
    Apellido,
    CASE 
        WHEN CONVERT(FLOAT, DecryptByPassPhrase('ClaveSecreta', NotaFinalCifrada)) >= 4.0 THEN 'Aprobado'
        ELSE 'Reprobado'
    END AS Resultado
FROM Estudiantes;

-- 6. Ciclo WHILE para iterar sobre los cursos y mostrar nombres y créditos
DECLARE @CursoID INT = 1;
DECLARE @TotalCursos INT = (SELECT COUNT(*) FROM Cursos);

WHILE @CursoID <= @TotalCursos
BEGIN
    SELECT NombreCurso, Creditos
    FROM Cursos
    WHERE CursoID = @CursoID;
    
    SET @CursoID = @CursoID + 1;
END;

-- 7. Consulta con nivel de aislamiento SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

SELECT * FROM Inscripciones WHERE Estado = 'Inscrito';

COMMIT;

-- 8. Subconsulta para mostrar el estudiante con la nota más alta
SELECT TOP 1 
    EstudianteID,
    Nombre,
    Apellido,
    CONVERT(FLOAT, DecryptByPassPhrase('ClaveSecreta', NotaFinalCifrada)) AS NotaDescifrada
FROM Estudiantes
ORDER BY NotaDescifrada DESC;

-- 9. Crear un índice en la tabla `Inscripciones` sobre el campo `Estado`
CREATE INDEX idx_Estado ON Inscripciones(Estado);

-- 10. Usar GOTO para simular una salida temprana si se encuentra un curso con más de 5 créditos
DECLARE @CursoID_GOTO INT = 1;
DECLARE @NombreCurso NVARCHAR(100);
DECLARE @Creditos INT;

WHILE @CursoID_GOTO <= (SELECT COUNT(*) FROM Cursos)
BEGIN
    SELECT 
        @NombreCurso = NombreCurso, 
        @Creditos = Creditos
    FROM Cursos
    WHERE CursoID = @CursoID_GOTO;

    IF @Creditos > 5
    BEGIN
        PRINT CONCAT('Curso con más de 5 créditos encontrado: ', @NombreCurso);
        GOTO Fin;
    END

    SET @CursoID_GOTO = @CursoID_GOTO + 1;
END;

Fin:
PRINT 'Fin del proceso.';
