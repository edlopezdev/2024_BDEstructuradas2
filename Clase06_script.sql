-- Creación de la base de datos
CREATE DATABASE HospitalDB;
GO

USE HospitalDB;
GO

-- Creación de tablas
CREATE TABLE Pacientes (
    PacienteID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    FechaNacimiento DATE,
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(15),
    Email NVARCHAR(100)
);

CREATE TABLE Medicos (
    MedicoID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Especialidad NVARCHAR(100),
    Telefono NVARCHAR(15)
);

CREATE TABLE Citas (
    CitaID INT PRIMARY KEY IDENTITY,
    PacienteID INT,
    MedicoID INT,
    FechaCita DATETIME,
    Motivo NVARCHAR(200),
    Estado NVARCHAR(20) CHECK (Estado IN ('Pendiente', 'Completada', 'Cancelada')),
    FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID),
    FOREIGN KEY (MedicoID) REFERENCES Medicos(MedicoID)
);

CREATE TABLE Tratamientos (
    TratamientoID INT PRIMARY KEY IDENTITY,
    CitaID INT,
    Descripcion NVARCHAR(200),
    Costo DECIMAL(10, 2),
    FOREIGN KEY (CitaID) REFERENCES Citas(CitaID)
);

-- Insertar datos ficticios
INSERT INTO Pacientes (Nombre, FechaNacimiento, Direccion, Telefono, Email) VALUES
('Luis González', '1985-02-15', 'Calle Salud 123', '123456789', 'luisg@gmail.com'),
('Ana Torres', '1990-07-22', 'Avenida Médico 456', '987654321', 'ana.torres@yahoo.com');

INSERT INTO Medicos (Nombre, Especialidad, Telefono) VALUES
('Dr. Pérez', 'Cardiología', '111222333'),
('Dra. López', 'Dermatología', '444555666');

INSERT INTO Citas (PacienteID, MedicoID, FechaCita, Motivo, Estado) VALUES
(1, 1, '2024-11-08 10:30:00', 'Dolor de pecho', 'Pendiente'),
(2, 2, '2024-11-09 15:00:00', 'Erupción cutánea', 'Pendiente');

INSERT INTO Tratamientos (CitaID, Descripcion, Costo) VALUES
(1, 'Electrocardiograma', 50.00),
(2, 'Crema tópica', 20.00);
GO
