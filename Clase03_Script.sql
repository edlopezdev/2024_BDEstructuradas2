-- Creación de la base de datos
CREATE DATABASE GestionClientes;
GO

-- Uso de la base de datos recién creada
USE GestionClientes;
GO

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Direccion NVARCHAR(250) NULL
);
GO

-- Creación de la tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);
GO

-- Creación de la tabla Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    FechaPedido DATE NOT NULL,
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Pendiente'
);
GO

-- Inserción de datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES ('Juan', 'Pérez', 'juan.perez@example.com', 'Av. Siempre Viva 123');

INSERT INTO Clientes (Nombre, Apellido, Email, Direccion)
VALUES ('Ana', 'Gómez', 'ana.gomez@example.com', 'Calle Falsa 456');

-- Inserción de datos en la tabla Productos
INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Laptop', 599.99, 10);

INSERT INTO Productos (NombreProducto, Precio, Stock)
VALUES ('Mouse', 19.99, 100);

-- Inserción de datos en la tabla Pedidos
INSERT INTO Pedidos (ClienteID, FechaPedido, Estado)
VALUES (1, '2024-08-20', 'Pendiente');

INSERT INTO Pedidos (ClienteID, FechaPedido, Estado)
VALUES (2, '2024-08-21', 'Completado');
GO
