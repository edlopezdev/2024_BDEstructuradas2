-- Creación de la base de datos
CREATE DATABASE BD_GestionAcademica;
GO

USE BD_GestionAcademica;

-- Creación de tablas
CREATE TABLE Estudiantes (
    EstudianteID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Correo NVARCHAR(150),
    FechaNacimiento DATE,
    NotaFinalCifrada VARBINARY(MAX)
);

CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY,
    NombreCurso NVARCHAR(100),
    Creditos INT
);

CREATE TABLE Inscripciones (
    InscripcionID INT PRIMARY KEY,
    EstudianteID INT FOREIGN KEY REFERENCES Estudiantes(EstudianteID),
    CursoID INT FOREIGN KEY REFERENCES Cursos(CursoID),
    FechaInscripcion DATE,
    Estado NVARCHAR(50) -- (Ej.: Inscrito, Retirado, Finalizado)
);

-- Inserción de datos ficticios
INSERT INTO Estudiantes VALUES
(1, 'Juan', 'Pérez', 'juan.perez@mail.com', '2000-01-15', EncryptByPassPhrase('ClaveSecreta', '4.5')),
(2, 'María', 'González', 'maria.gonzalez@mail.com', '1999-06-20', EncryptByPassPhrase('ClaveSecreta', '5.0')),
(3, 'Carlos', 'Rojas', 'carlos.rojas@mail.com', '2001-03-10', EncryptByPassPhrase('ClaveSecreta', '3.8'));

INSERT INTO Cursos VALUES
(1, 'Matemáticas', 5),
(2, 'Programación', 6),
(3, 'Redes', 4);

INSERT INTO Inscripciones VALUES
(1, 1, 1, '2023-03-01', 'Finalizado'),
(2, 1, 2, '2023-03-01', 'Inscrito'),
(3, 2, 2, '2023-03-01', 'Finalizado'),
(4, 3, 3, '2023-03-01', 'Retirado');

-- Ejercicios sin resolver

-- 1. Crear un procedimiento almacenado cifrado (`WITH ENCRYPTION`) que permita descifrar las notas finales de los estudiantes.
--    El procedimiento solo debe ser accesible para un rol específico.
--    Usa EXECUTE AS para limitar su uso.

-- 2. Crear una transacción con SAVE TRAN para insertar un nuevo estudiante y su inscripción a un curso.
--    Realiza un rollback parcial usando ROLLBACK TO.

-- 3. Implementar un SELECT que use WITH(NOLOCK) para leer las inscripciones sin bloquear las filas.

-- 4. Crear una consulta que utilice UNION para mostrar los nombres de estudiantes y cursos en una sola lista.

-- 5. Crear una consulta que utilice CASE para clasificar las notas finales de los estudiantes en "Aprobado" o "Reprobado" (descifra las notas dentro de la consulta).

-- 6. Implementar un ciclo WHILE para iterar sobre los cursos y mostrar sus nombres junto con la cantidad de créditos.

-- 7. Usar un nivel de aislamiento SERIALIZABLE para realizar una consulta de las inscripciones y prevenir lecturas fantasma.

-- 8. Crear una subconsulta que muestre el estudiante con la nota más alta (descifrada).

-- 9. Crear un índice en la tabla `Inscripciones` sobre el campo `Estado` para mejorar el rendimiento de las consultas.

-- 10. Usar GOTO para simular una salida temprana si se encuentra un curso con más de 5 créditos (iterando los cursos con WHILE).
