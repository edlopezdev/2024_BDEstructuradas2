-- Creación de la base de datos de prueba
CREATE DATABASE BD_Prueba;
GO

USE BD_Prueba;

-- Creación de tablas
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Edad INT,
    Correo NVARCHAR(150)
);

CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ID),
    Fecha DATE,
    Monto DECIMAL(10, 2)
);

CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Precio DECIMAL(10, 2)
);

-- Inserción de datos
INSERT INTO Clientes VALUES (1, 'Juan', 'Pérez', 25, 'juan.perez@mail.com');
INSERT INTO Clientes VALUES (2, 'María', 'González', 30, 'maria.gonzalez@mail.com');
INSERT INTO Clientes VALUES (3, 'Carlos', 'Rojas', 20, 'carlos.rojas@mail.com');

INSERT INTO Ventas VALUES (1, 1, '2023-12-01', 5000);
INSERT INTO Ventas VALUES (2, 2, '2023-12-02', 10000);
INSERT INTO Ventas VALUES (3, 1, '2023-12-03', 7000);

INSERT INTO Productos VALUES (1, 'Laptop', 800000);
INSERT INTO Productos VALUES (2, 'Mouse', 20000);
INSERT INTO Productos VALUES (3, 'Teclado', 30000);

-- Ejercicios de Transacciones
-- Ejercicio 1: Crear una transacción que inserte un cliente y una venta, luego haga rollback a un punto de guardado.
-- Ejercicio 2: Configurar un nivel de aislamiento para evitar lecturas sucias y realizar una consulta en transacción.
-- Ejercicio 3: Realizar un rollback completo de una transacción que inserte datos en las tres tablas.

-- Ejercicios de Consultas
-- Ejercicio 4: Usar UNION para combinar los nombres de los clientes y los productos.
-- Ejercicio 5: Crear una consulta que muestre el nombre completo de los clientes y la longitud de sus correos electrónicos.
-- Ejercicio 6: Usar CASE para categorizar las edades de los clientes como 'Menor de edad' o 'Mayor de edad'.

-- Ejercicios de Seguridad y Contexto
-- Ejercicio 7: Crear un procedimiento almacenado con ENCRYPTION que consulte los datos de las ventas.
-- Ejercicio 8: Usar EXECUTE AS para ejecutar una consulta que acceda a la tabla de productos con permisos limitados.
-- Ejercicio 9: Usar WITH (NOLOCK) en una consulta que devuelva los datos de la tabla Ventas.
