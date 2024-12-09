-- Creación de la base de datos
CREATE DATABASE AgenciaViajes;
GO

USE AgenciaViajes;

-- Creación de tablas
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Telefono NVARCHAR(15),
    Correo NVARCHAR(100),
    FechaRegistro DATE
);

CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Cargo NVARCHAR(50),
    FechaContratacion DATE,
    Salario DECIMAL(10, 2)
);

CREATE TABLE Destinos (
    DestinoID INT PRIMARY KEY,
    Ciudad NVARCHAR(100),
    Pais NVARCHAR(100),
    Costo DECIMAL(10, 2)
);

CREATE TABLE Reservas (
    ReservaID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    EmpleadoID INT FOREIGN KEY REFERENCES Empleados(EmpleadoID),
    DestinoID INT FOREIGN KEY REFERENCES Destinos(DestinoID),
    FechaReserva DATE,
    FechaViaje DATE,
    Estado NVARCHAR(50) -- (Ej.: Confirmada, Cancelada, Pendiente)
);

-- Inserción de datos ficticios
INSERT INTO Clientes VALUES
(1, 'Juan', 'Pérez', '+56912345678', 'juan.perez@mail.com', '2023-01-15'),
(2, 'María', 'González', '+56987654321', 'maria.gonzalez@mail.com', '2023-02-20'),
(3, 'Carlos', 'Rojas', '+56922334455', 'carlos.rojas@mail.com', '2023-03-10');
(4, 'Laura', 'Ramírez', '+56933445566', 'laura.ramirez@mail.com', '2023-04-12'),
(5, 'Pedro', 'Soto', '+56999887766', 'pedro.soto@mail.com', '2023-05-18'),
(6, 'Sofía', 'Martínez', '+56988776655', 'sofia.martinez@mail.com', '2023-06-10'),
(7, 'Diego', 'Cruz', '+56977665544', 'diego.cruz@mail.com', '2023-07-22'),
(8, 'Valeria', 'Vargas', '+56966554433', 'valeria.vargas@mail.com', '2023-08-30'),
(9, 'Ricardo', 'Flores', '+56955443322', 'ricardo.flores@mail.com', '2023-09-15');

INSERT INTO Empleados VALUES
(1, 'Ana', 'Torres', 'Agente de Viajes', '2021-06-01', 850000),
(2, 'Luis', 'Soto', 'Agente de Ventas', '2020-09-15', 900000),
(3, 'Paula', 'Martínez', 'Supervisor', '2019-11-25', 1200000);
(4, 'Jorge', 'Fernández', 'Asistente de Ventas', '2022-01-05', 750000),
(5, 'Claudia', 'Mendoza', 'Agente de Viajes', '2021-03-18', 850000),
(6, 'Fernando', 'Espinoza', 'Supervisor', '2020-11-22', 1300000),
(7, 'Natalia', 'Cárdenas', 'Agente de Ventas', '2021-08-10', 950000);

INSERT INTO Destinos VALUES
(1, 'París', 'Francia', 1500000),
(2, 'Nueva York', 'Estados Unidos', 1800000),
(3, 'Tokio', 'Japón', 2200000);
(4, 'Sídney', 'Australia', 2500000),
(5, 'Londres', 'Reino Unido', 2000000),
(6, 'Roma', 'Italia', 1800000),
(7, 'Cancún', 'México', 1200000),
(8, 'Río de Janeiro', 'Brasil', 1100000),
(9, 'El Cairo', 'Egipto', 1700000);

INSERT INTO Reservas VALUES
(1, 1, 1, 1, '2023-11-01', '2024-01-10', 'Confirmada'),
(2, 2, 2, 2, '2023-11-05', '2024-02-15', 'Pendiente'),
(3, 3, 1, 3, '2023-11-10', '2024-03-20', 'Cancelada');
(4, 4, 4, 4, '2023-10-01', '2024-01-15', 'Confirmada'),
(5, 5, 5, 5, '2023-10-10', '2024-02-20', 'Pendiente'),
(6, 6, 6, 6, '2023-10-20', '2024-03-10', 'Confirmada'),
(7, 7, 7, 7, '2023-11-01', '2024-04-05', 'Confirmada'),
(8, 8, 1, 8, '2023-11-10', '2024-05-15', 'Pendiente'),
(9, 9, 2, 9, '2023-11-20', '2024-06-10', 'Cancelada'),
(10, 1, 3, 4, '2023-12-01', '2024-07-20', 'Confirmada'),
(11, 2, 4, 5, '2023-12-15', '2024-08-05', 'Pendiente'),
(12, 3, 5, 6, '2023-12-25', '2024-09-10', 'Confirmada'),
(13, 4, 6, 7, '2024-01-05', '2024-10-15', 'Cancelada'),
(14, 5, 7, 8, '2024-01-15', '2024-11-05', 'Confirmada'),
(15, 6, 1, 9, '2024-01-20', '2024-12-25', 'Pendiente');
(16, 1, 2, 5, '2023-09-10', '2024-01-20', 'Confirmada'),
(17, 1, 3, 6, '2023-09-25', '2024-02-25', 'Confirmada'),
(18, 2, 4, 7, '2023-10-05', '2024-03-15', 'Pendiente'),
(19, 2, 5, 8, '2023-10-20', '2024-04-10', 'Cancelada'),
(20, 3, 6, 9, '2023-11-10', '2024-05-20', 'Confirmada');
