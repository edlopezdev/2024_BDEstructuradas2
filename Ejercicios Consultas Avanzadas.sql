-- Creación de la base de datos
CREATE DATABASE BibliotecaDB;
GO

USE BibliotecaDB;
GO

-- Creación de tablas
CREATE TABLE Autores (
    AutorID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Nacionalidad NVARCHAR(100)
);

CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100)
);

CREATE TABLE Libros (
    LibroID INT PRIMARY KEY IDENTITY,
    Titulo NVARCHAR(200),
    AutorID INT,
    CategoriaID INT,
    AñoPublicacion INT,
    Disponibles INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

CREATE TABLE Lectores (
    LectorID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100),
    Telefono NVARCHAR(15),
    Email NVARCHAR(100)
);

CREATE TABLE Prestamos (
    PrestamoID INT PRIMARY KEY IDENTITY,
    LectorID INT,
    LibroID INT,
    FechaPrestamo DATE,
    FechaDevolucion DATE,
    Estado NVARCHAR(20) CHECK (Estado IN ('Pendiente', 'Devuelto', 'Retrasado')),
    FOREIGN KEY (LectorID) REFERENCES Lectores(LectorID),
    FOREIGN KEY (LibroID) REFERENCES Libros(LibroID)
);

-- Insertar datos ficticios
INSERT INTO Autores (Nombre, Nacionalidad) VALUES
('Gabriel García Márquez', 'Colombiana'),
('Jane Austen', 'Inglesa'),
('J.K. Rowling', 'Inglesa'),
('Haruki Murakami', 'Japonesa');

INSERT INTO Categorias (Nombre) VALUES
('Ficción'),
('Romance'),
('Fantasía'),
('Misterio');

INSERT INTO Libros (Titulo, AutorID, CategoriaID, AñoPublicacion, Disponibles) VALUES
('Cien Años de Soledad', 1, 1, 1967, 3),
('Orgullo y Prejuicio', 2, 2, 1813, 5),
('Harry Potter y la Piedra Filosofal', 3, 3, 1997, 7),
('Kafka en la Orilla', 4, 4, 2002, 2);

INSERT INTO Lectores (Nombre, Telefono, Email) VALUES
('Juan Pérez', '123456789', 'juanperez@gmail.com'),
('María González', '987654321', 'mariagonzalez@hotmail.com'),
('Luis Torres', '555666777', 'luistorres@yahoo.com');

INSERT INTO Prestamos (LectorID, LibroID, FechaPrestamo, FechaDevolucion, Estado) VALUES
(1, 1, '2024-11-10', '2024-11-20', 'Devuelto'),
(2, 3, '2024-11-12', NULL, 'Pendiente'),
(3, 4, '2024-11-01', '2024-11-15', 'Retrasado');
GO



-- 1. Obtener los libros más prestados.
-- 2. Mostrar los lectores que tienen préstamos pendientes.
-- 3. Calcular cuántos libros hay disponibles por categoría.
-- 4. Mostrar el autor con más libros registrados en la biblioteca.
-- 5. Listar los préstamos que están retrasados.
-- 6. Obtener el promedio de libros prestados por lector.
-- 7. Mostrar los préstamos realizados entre dos fechas específicas.
-- 8. Determinar cuántos préstamos han realizado los lectores por cada libro.
-- 9. Mostrar los libros que no han sido prestados nunca.
-- 10. Mostrar todos los lectores que han pedido libros de una categoría específica (ejemplo: Fantasía).
