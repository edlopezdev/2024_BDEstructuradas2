USE AgenciaViajes;

-- Soluciones de Transacciones
-- 1. Inserta un nuevo cliente y una nueva reserva en una transacción. Usa SAVE TRAN para rollback parcial.
BEGIN TRANSACTION;

INSERT INTO Clientes (ClienteID, Nombre, Apellido, Telefono, Correo, FechaRegistro)
VALUES (10, 'Elena', 'Lopez', '+56998765432', 'elena.lopez@mail.com', '2023-12-04');

SAVE TRANSACTION Punto1;

INSERT INTO Reservas (ReservaID, ClienteID, EmpleadoID, DestinoID, FechaReserva, FechaViaje, Estado)
VALUES (21, 10, 1, 1, '2023-12-04', '2024-01-15', 'Confirmada');

ROLLBACK TRANSACTION Punto1; -- Revertimos la reserva
COMMIT; -- Confirmamos el cliente

-- 2. Actualiza el estado de una reserva a "Cancelada" y deshaz los cambios con ROLLBACK.
BEGIN TRANSACTION;

UPDATE Reservas
SET Estado = 'Cancelada'
WHERE ReservaID = 1;

ROLLBACK; -- Revertimos el cambio

-- 3. Elimina un empleado y todas sus reservas asociadas en una transacción. Haz un rollback completo.
BEGIN TRANSACTION;

DELETE FROM Reservas WHERE EmpleadoID = 1;
DELETE FROM Empleados WHERE EmpleadoID = 1;

ROLLBACK; -- Revertimos todo

-- 4. Configura un nivel de aislamiento SERIALIZABLE y realiza una consulta de prueba.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

SELECT * FROM Reservas WHERE Estado = 'Confirmada';

COMMIT;

-- 5. Inserta un nuevo destino y realiza un rollback.
BEGIN TRANSACTION;

INSERT INTO Destinos (DestinoID, Ciudad, Pais, Costo)
VALUES (10, 'Atenas', 'Grecia', 1800000);

ROLLBACK;

-- Soluciones de Consultas Básicas
-- 6. Encuentra los clientes con más de una reserva confirmada.
SELECT ClienteID, COUNT(*) AS ReservasConfirmadas
FROM Reservas
WHERE Estado = 'Confirmada'
GROUP BY ClienteID
HAVING COUNT(*) > 1;

-- 7. Calcula el ingreso total generado por las reservas confirmadas.
SELECT SUM(d.Costo) AS IngresoTotal
FROM Reservas r
JOIN Destinos d ON r.DestinoID = d.DestinoID
WHERE r.Estado = 'Confirmada';

-- 8. Devuelve los nombres de los destinos ordenados por costo de mayor a menor.
SELECT Ciudad, Pais, Costo
FROM Destinos
ORDER BY Costo DESC;

-- 9. Muestra todos los clientes que no han realizado reservas.
SELECT *
FROM Clientes
WHERE ClienteID NOT IN (SELECT DISTINCT ClienteID FROM Reservas);

-- 10. Encuentra los empleados que han gestionado más reservas.
SELECT EmpleadoID, COUNT(*) AS TotalReservas
FROM Reservas
GROUP BY EmpleadoID
ORDER BY TotalReservas DESC;

-- 11. Muestra las reservas que están programadas para viajes en 2024.
SELECT *
FROM Reservas
WHERE YEAR(FechaViaje) = 2024;

-- 12. Devuelve el cliente con la mayor cantidad de reservas canceladas.
SELECT TOP 1 ClienteID, COUNT(*) AS Canceladas
FROM Reservas
WHERE Estado = 'Cancelada'
GROUP BY ClienteID
ORDER BY Canceladas DESC;

-- 13. Muestra el salario promedio de los empleados por cargo.
SELECT Cargo, AVG(Salario) AS SalarioPromedio
FROM Empleados
GROUP BY Cargo;

-- 14. Encuentra el destino más popular.
SELECT TOP 1 d.Ciudad, d.Pais, COUNT(*) AS Popularidad
FROM Reservas r
JOIN Destinos d ON r.DestinoID = d.DestinoID
GROUP BY d.Ciudad, d.Pais
ORDER BY Popularidad DESC;

-- 15. Calcula la longitud de los correos electrónicos de todos los clientes.
SELECT ClienteID, LEN(Correo) AS LongitudCorreo
FROM Clientes;

-- Soluciones de Consultas Avanzadas
-- 16. Usa UNION para combinar los nombres de los clientes y destinos.
SELECT Nombre FROM Clientes
UNION
SELECT Ciudad FROM Destinos;

-- 17. Encuentra el cliente con la reserva más reciente.
SELECT TOP 1 ClienteID, MAX(FechaReserva) AS UltimaReserva
FROM Reservas
GROUP BY ClienteID
ORDER BY UltimaReserva DESC;

-- 18. Muestra los destinos agrupados por país y calcula el número de destinos por país.
SELECT Pais, COUNT(*) AS NumeroDestinos
FROM Destinos
GROUP BY Pais;

-- 19. Usa CASE para clasificar las reservas como "Cercanas" o "Lejanas".
SELECT ReservaID, 
       CASE 
           WHEN DATEDIFF(DAY, GETDATE(), FechaViaje) <= 90 THEN 'Cercana'
           ELSE 'Lejana'
       END AS Categoria
FROM Reservas;

-- 20. Devuelve los nombres completos de los clientes concatenados con sus teléfonos.
SELECT CONCAT(Nombre, ' ', Apellido, ' - ', Telefono) AS InformacionContacto
FROM Clientes;

-- 21. Encuentra los destinos con un costo mayor al costo promedio de todos los destinos.
SELECT * 
FROM Destinos
WHERE Costo > (SELECT AVG(Costo) FROM Destinos);

-- 22. Muestra el costo total de las reservas por cliente.
SELECT ClienteID, SUM(d.Costo) AS CostoTotal
FROM Reservas r
JOIN Destinos d ON r.DestinoID = d.DestinoID
GROUP BY ClienteID;

-- 23. Usa HAVING para mostrar empleados con más de 2 reservas confirmadas.
SELECT EmpleadoID, COUNT(*) AS TotalReservas
FROM Reservas
WHERE Estado = 'Confirmada'
GROUP BY EmpleadoID
HAVING COUNT(*) > 2;

-- 24. Encuentra las reservas realizadas por empleados contratados en 2021 o después.
SELECT r.*
FROM Reservas r
JOIN Empleados e ON r.EmpleadoID = e.EmpleadoID
WHERE e.FechaContratacion >= '2021-01-01';

-- 25. Devuelve las reservas programadas entre dos fechas específicas.
SELECT *
FROM Reservas
WHERE FechaViaje BETWEEN '2024-01-01' AND '2024-12-31';

-- Soluciones de Seguridad y Contexto
-- 26. Crea un procedimiento almacenado cifrado que devuelva reservas confirmadas.
CREATE PROCEDURE sp_ReservasConfirmadas
WITH ENCRYPTION
AS
BEGIN
    SELECT * FROM Reservas WHERE Estado = 'Confirmada';
END;

-- 27. Usa EXECUTE AS para consultar destinos con permisos limitados.
EXECUTE AS USER = 'dbo';
SELECT * FROM Destinos;
REVERT;

-- 28. Usa WITH (NOLOCK) para consultar reservas sin bloquear filas.
SELECT * FROM Reservas WITH (NOLOCK);

-- 29. Procedimiento almacenado que maneja errores con TRY...CATCH.
CREATE PROCEDURE sp_InsertarReserva
    @ClienteID INT,
    @EmpleadoID INT,
    @DestinoID INT,
    @FechaReserva DATE,
    @FechaViaje DATE,
    @Estado NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Reservas (ClienteID, EmpleadoID, DestinoID, FechaReserva, FechaViaje, Estado)
        VALUES (@ClienteID, @EmpleadoID, @DestinoID, @FechaReserva, @FechaViaje, @Estado);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Error;
    END CATCH
END;

-- 30. Captura un error al insertar un ClienteID duplicado.
BEGIN TRY
    INSERT INTO Clientes (ClienteID, Nombre, Apellido, Telefono, Correo, FechaRegistro)
    VALUES (1, 'Duplicado', 'Error', '+56912345678', 'error@mail.com', '2023-12-04');
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS Error;
END CATCH;
