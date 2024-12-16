USE BD_TiendaVirtual;

-- 1. Transacción con SAVE TRAN y ROLLBACK TO
BEGIN TRANSACTION;

INSERT INTO Clientes (ClienteID, Nombre, Apellido, Correo, Telefono, SaldoCifrado)
VALUES (4, 'Sofía', 'Martínez', 'sofia.martinez@mail.com', '+56987651234', EncryptByPassPhrase('ClaveSecreta', '6000'));

SAVE TRAN Punto1;

INSERT INTO Ventas (VentaID, ClienteID, ProductoID, FechaVenta, Estado)
VALUES (4, 4, 2, '2023-12-01', 'Pendiente');

-- Rollback parcial
ROLLBACK TRANSACTION Punto1;

-- Confirmar la transacción
COMMIT;

-- 2. Transacción con rollback completo
BEGIN TRANSACTION;

INSERT INTO Productos (ProductoID, NombreProducto, Precio, Stock)
VALUES (4, 'Monitor', 250000, 5);

-- Rollback completo
ROLLBACK;

-- 3. Configurar nivel de aislamiento SERIALIZABLE y consultar ventas
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

SELECT * FROM Ventas;

COMMIT;

-- 4. Configurar nivel de aislamiento READ COMMITTED y consultar clientes
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

SELECT * FROM Clientes;

COMMIT;

-- 5. UNION para combinar nombres de clientes y productos
SELECT Nombre AS NombreEntidad FROM Clientes
UNION
SELECT NombreProducto AS NombreEntidad FROM Productos;

-- 6. UNION ALL para combinar correos y estados de ventas
SELECT Correo AS Informacion FROM Clientes
UNION ALL
SELECT Estado AS Informacion FROM Ventas;

-- 7. CONCAT para mostrar nombres completos de clientes
SELECT CONCAT(Nombre, ' ', Apellido) AS NombreCompleto
FROM Clientes;

-- 8. LEN para mostrar la longitud de nombres de productos
SELECT NombreProducto, LEN(NombreProducto) AS LongitudNombre
FROM Productos;

-- 9. WITH(NOLOCK) para consultar ventas sin bloqueos
SELECT * 
FROM Ventas WITH (NOLOCK);

-- 10. Procedimiento almacenado con EXECUTE AS para descifrar saldos
CREATE PROCEDURE sp_VerSaldos
WITH ENCRYPTION
WITH EXECUTE AS 'dbo'
AS
BEGIN
    SELECT 
        ClienteID,
        Nombre,
        Apellido,
        CONVERT(NVARCHAR(10), DecryptByPassPhrase('ClaveSecreta', SaldoCifrado)) AS SaldoDescifrado
    FROM Clientes;
END;

-- Ejecutar el procedimiento
EXEC sp_VerSaldos;

-- 11. Intentar ejecutar el procedimiento con un usuario no autorizado
-- (Este generará un error si el usuario no tiene permisos)

-- 12. CASE para clasificar ventas según el precio del producto
SELECT 
    v.VentaID,
    p.NombreProducto,
    CASE 
        WHEN p.Precio > 100000 THEN 'Alta'
        ELSE 'Baja'
    END AS CategoriaPrecio
FROM Ventas v
JOIN Productos p ON v.ProductoID = p.ProductoID;

-- 13. CASE para clasificar stock de productos
SELECT 
    NombreProducto,
    Stock,
    CASE 
        WHEN Stock <= 10 THEN 'Bajo'
        WHEN Stock BETWEEN 11 AND 30 THEN 'Medio'
        ELSE 'Alto'
    END AS CategoriaStock
FROM Productos;

-- 14. WHILE para iterar productos y mostrar nombres
DECLARE @ProductoID INT = 1;

WHILE @ProductoID <= (SELECT MAX(ProductoID) FROM Productos)
BEGIN
    SELECT NombreProducto FROM Productos WHERE ProductoID = @ProductoID;
    SET @ProductoID = @ProductoID + 1;
END;

-- 15. WHILE para calcular suma acumulativa del stock
DECLARE @TotalStock INT = 0;
DECLARE @ActualProductoID INT = 1;

WHILE @ActualProductoID <= (SELECT MAX(ProductoID) FROM Productos)
BEGIN
    SET @TotalStock = @TotalStock + (SELECT Stock FROM Productos WHERE ProductoID = @ActualProductoID);
    PRINT CONCAT('Stock acumulado hasta ProductoID ', @ActualProductoID, ': ', @TotalStock);
    SET @ActualProductoID = @ActualProductoID + 1;
END;

-- 16. WHILE con GOTO para salir si se encuentra un producto con stock menor a 5
DECLARE @IDProducto INT = 1;
DECLARE @Stock INT;

WHILE @IDProducto <= (SELECT MAX(ProductoID) FROM Productos)
BEGIN
    SET @Stock = (SELECT Stock FROM Productos WHERE ProductoID = @IDProducto);

    IF @Stock < 5
    BEGIN
        PRINT CONCAT('Producto con bajo stock encontrado: ProductoID ', @IDProducto);
        GOTO Salida;
    END;

    SET @IDProducto = @IDProducto + 1;
END;

Salida:
PRINT 'Fin del proceso WHILE';

-- 17. Descifrar y mostrar saldos de los clientes
SELECT 
    ClienteID,
    Nombre,
    CONVERT(NVARCHAR(10), DecryptByPassPhrase('ClaveSecreta', SaldoCifrado)) AS SaldoDescifrado
FROM Clientes;

-- 18. Actualizar saldo cifrado de un cliente
UPDATE Clientes
SET SaldoCifrado = EncryptByPassPhrase('ClaveSecreta', '8000')
WHERE ClienteID = 1;

-- 19. Procedimiento almacenado cifrado para actualizar saldo
CREATE PROCEDURE sp_ActualizarSaldo
    @ClienteID INT,
    @NuevoSaldo NVARCHAR(10)
WITH ENCRYPTION
AS
BEGIN
    UPDATE Clientes
    SET SaldoCifrado = EncryptByPassPhrase('ClaveSecreta', @NuevoSaldo)
    WHERE ClienteID = @ClienteID;
END;

-- Ejecutar el procedimiento para actualizar saldo
EXEC sp_ActualizarSaldo @ClienteID = 1, @NuevoSaldo = '9000';

-- 20. Ejercicio integrador
BEGIN TRANSACTION;

-- Insertar un nuevo cliente
INSERT INTO Clientes (ClienteID, Nombre, Apellido, Correo, Telefono, SaldoCifrado)
VALUES (5, 'Ana', 'López', 'ana.lopez@mail.com', '+56955443322', EncryptByPassPhrase('ClaveSecreta', '4000'));

SAVE TRAN Punto1;

-- Insertar un nuevo producto
INSERT INTO Productos (ProductoID, NombreProducto, Precio, Stock)
VALUES (5, 'Tablet', 150000, 20);

-- Clasificar stock de productos con CASE
SELECT 
    NombreProducto,
    Stock,
    CASE 
        WHEN Stock <= 10 THEN 'Bajo'
        WHEN Stock BETWEEN 11 AND 30 THEN 'Medio'
        ELSE 'Alto'
    END AS CategoriaStock
FROM Productos;

-- Descifrar saldo de un cliente
SELECT 
    Nombre,
    CONVERT(NVARCHAR(10), DecryptByPassPhrase('ClaveSecreta', SaldoCifrado)) AS SaldoDescifrado
FROM Clientes
WHERE ClienteID = 5;

-- Confirmar la transacción
COMMIT;
