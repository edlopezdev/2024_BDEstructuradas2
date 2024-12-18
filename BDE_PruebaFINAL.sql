-- 1. Creación de la base de datos
CREATE DATABASE BD_PruebaFinal;
GO

USE BD_PruebaFinal;

-- 2. Creación de tablas
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    Correo NVARCHAR(100),
    Telefono NVARCHAR(15),
    SaldoCifrado VARBINARY(MAX)
);

CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    NombreProducto NVARCHAR(50),
    Precio DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    FechaVenta DATE,
    Estado NVARCHAR(20) -- Ej.: Confirmada, Pendiente, Cancelada
);

-- 3. Inserción de datos ficticios
-- Insertar 10 registros en Clientes
INSERT INTO Clientes VALUES 
(1, 'Juan', 'Pérez', 'juan.perez@mail.com', '+56911111111', EncryptByPassPhrase('ClaveSecreta', '5000')),
(2, 'María', 'González', 'maria.gonzalez@mail.com', '+56922222222', EncryptByPassPhrase('ClaveSecreta', '3000')),
(3, 'Carlos', 'Rojas', 'carlos.rojas@mail.com', '+56933333333', EncryptByPassPhrase('ClaveSecreta', '7000')),
(4, 'Ana', 'Martínez', 'ana.martinez@mail.com', '+56944444444', EncryptByPassPhrase('ClaveSecreta', '1000')),
(5, 'Diego', 'López', 'diego.lopez@mail.com', '+56955555555', EncryptByPassPhrase('ClaveSecreta', '2000')),
(6, 'Paula', 'Vargas', 'paula.vargas@mail.com', '+56966666666', EncryptByPassPhrase('ClaveSecreta', '8000')),
(7, 'Luis', 'Torres', 'luis.torres@mail.com', '+56977777777', EncryptByPassPhrase('ClaveSecreta', '6000')),
(8, 'Claudia', 'Hernández', 'claudia.hernandez@mail.com', '+56988888888', EncryptByPassPhrase('ClaveSecreta', '4000')),
(9, 'Elena', 'Ramírez', 'elena.ramirez@mail.com', '+56999999999', EncryptByPassPhrase('ClaveSecreta', '9000')),
(10, 'Miguel', 'Soto', 'miguel.soto@mail.com', '+56900000000', EncryptByPassPhrase('ClaveSecreta', '3500'));

-- Insertar registros en Productos
INSERT INTO Productos VALUES 
(1, 'Laptop', 800000, 15),
(2, 'Mouse', 15000, 50),
(3, 'Teclado', 30000, 20),
(4, 'Monitor', 200000, 10),
(5, 'Impresora', 120000, 5),
(6, 'Parlantes', 50000, 25),
(7, 'Tablet', 250000, 12),
(8, 'Auriculares', 40000, 30),
(9, 'Webcam', 60000, 18),
(10, 'Microfono', 75000, 8);

-- Insertar registros en Ventas
INSERT INTO Ventas VALUES 
(1, 1, 1, '2023-11-01', 'Confirmada'),
(2, 2, 2, '2023-11-02', 'Pendiente'),
(3, 3, 3, '2023-11-03', 'Cancelada'),
(4, 4, 4, '2023-11-04', 'Confirmada'),
(5, 5, 5, '2023-11-05', 'Pendiente'),
(6, 6, 6, '2023-11-06', 'Confirmada'),
(7, 7, 7, '2023-11-07', 'Pendiente'),
(8, 8, 8, '2023-11-08', 'Cancelada'),
(9, 9, 9, '2023-11-09', 'Confirmada'),
(10, 10, 10, '2023-11-10', 'Confirmada');

-- 4. Preguntas=> Elegir 4 y enviar a edgar.lopez@inacapmail.cl

-- 1. Crea una transacción con SAVE TRAN y ROLLBACK TO. Inserta un nuevo cliente y una venta, pero revierte la venta usando ROLLBACK TO.

-- 2. Configura el nivel de aislamiento SERIALIZABLE y realiza una consulta para contar las ventas confirmadas.

-- 3. Usa UNION para combinar los nombres de los clientes y los productos.

-- 4. Usa LEN y CONCAT para mostrar los nombres completos de los clientes concatenados con su número de teléfono y la longitud de los correos electrónicos.

-- 5. Crea un procedimiento almacenado cifrado (`WITH ENCRYPTION`) que descifre y muestre los saldos de los clientes. Usa EXECUTE AS para limitar su ejecución.

-- 6. Clasifica los productos en "Costoso" (precio mayor a 150,000) o "Económico" (precio menor o igual a 150,000) usando la función CASE.

-- 7. Utiliza un ciclo WHILE para mostrar los nombres de los productos y sus stocks, iterando por el ProductoID.

-- 8. Usa GOTO para detener un ciclo WHILE si encuentras un producto con stock menor a 10.

-- 9. Utiliza WITH(NOLOCK) para consultar todas las ventas sin bloquear la tabla.

-- 10. Actualiza el saldo cifrado de un cliente usando EncryptByPassPhrase y verifica que el cambio fue exitoso al descifrarlo con DecryptByPassPhrase.
