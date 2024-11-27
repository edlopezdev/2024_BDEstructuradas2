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

-- Insertar datos ficticios en Autores
INSERT INTO Autores (Nombre, Nacionalidad) VALUES
('Gabriel García Márquez', 'Colombiana'),
('Jane Austen', 'Inglesa'),
('J.K. Rowling', 'Inglesa'),
('Haruki Murakami', 'Japonesa'),
('Stephen King', 'Estadounidense'),
('Isabel Allende', 'Chilena'),
('George Orwell', 'Inglesa'),
('Miguel de Cervantes', 'Española'),
('Ernest Hemingway', 'Estadounidense'),
('Leo Tolstoy', 'Rusa'),
('Fyodor Dostoevsky', 'Rusa'),
('Mark Twain', 'Estadounidense'),
('Charles Dickens', 'Inglesa');

-- Insertar datos ficticios en Categorias
INSERT INTO Categorias (Nombre) VALUES
('Ficción'),
('Romance'),
('Fantasía'),
('Misterio'),
('Historia'),
('Ciencia Ficción'),
('Biografía'),
('Aventura'),
('Poesía'),
('Drama');

-- Insertar datos ficticios en Libros
INSERT INTO Libros (Titulo, AutorID, CategoriaID, AñoPublicacion, Disponibles) VALUES
('Cien Años de Soledad', 1, 1, 1967, 3),
('Orgullo y Prejuicio', 2, 2, 1813, 5),
('Harry Potter y la Piedra Filosofal', 3, 3, 1997, 7),
('Kafka en la Orilla', 4, 4, 2002, 2),
('El Resplandor', 5, 4, 1977, 4),
('La Casa de los Espíritus', 6, 1, 1982, 6),
('1984', 7, 6, 1949, 5),
('Don Quijote de la Mancha', 8, 5, 1605, 2),
('El Viejo y el Mar', 9, 1, 1952, 3),
('Guerra y Paz', 10, 5, 1869, 2),
('Crimen y Castigo', 11, 1, 1866, 4),
('Las Aventuras de Tom Sawyer', 12, 8, 1876, 5),
('Grandes Esperanzas', 13, 10, 1861, 3),
('Harry Potter y la Cámara Secreta', 3, 3, 1998, 6),
('Harry Potter y el Prisionero de Azkaban', 3, 3, 1999, 5);

-- Insertar datos ficticios en Lectores
INSERT INTO Lectores (Nombre, Telefono, Email) VALUES
('Juan Pérez', '123456789', 'juanperez@gmail.com'),
('María González', '987654321', 'mariagonzalez@hotmail.com'),
('Luis Torres', '555666777', 'luistorres@yahoo.com'),
('Ana López', '111222333', 'analopez@gmail.com'),
('Carlos Martínez', '444555666', 'carlosm@hotmail.com'),
('Elena Rodríguez', '777888999', 'elenar@yahoo.com'),
('Pedro Sánchez', '222333444', 'pedros@gmail.com'),
('Lucía Fernández', '555666777', 'luciaf@hotmail.com'),
('Miguel Gómez', '888999000', 'miguelg@yahoo.com');

-- Insertar datos ficticios en Prestamos
INSERT INTO Prestamos (LectorID, LibroID, FechaPrestamo, FechaDevolucion, Estado) VALUES
(1, 1, '2024-11-10', '2024-11-20', 'Devuelto'),
(2, 3, '2024-11-12', NULL, 'Pendiente'),
(3, 4, '2024-11-01', '2024-11-15', 'Retrasado'),
(4, 5, '2024-11-15', NULL, 'Pendiente'),
(5, 6, '2024-11-05', '2024-11-18', 'Devuelto'),
(6, 7, '2024-11-10', '2024-11-20', 'Devuelto'),
(7, 2, '2024-11-02', '2024-11-12', 'Devuelto'),
(8, 8, '2024-11-08', NULL, 'Pendiente'),
(9, 9, '2024-11-09', '2024-11-19', 'Devuelto'),
(1, 14, '2024-11-13', NULL, 'Pendiente'),
(2, 15, '2024-11-14', '2024-11-24', 'Retrasado'),
(3, 12, '2024-11-16', NULL, 'Pendiente');
GO

-- **Instrucciones:** 
-- La prueba consta de 10 preguntas, cada una con una ponderación de 1.5 puntos. 
-- Puedes elegir hasta **5 preguntas** para enviar. 
-- Si respondes correctamente **4 preguntas**, obtendrás la nota máxima de **7**. 
-- Tú decides cuáles preguntas enviar.=> edgar.lopez@inacapmail.cl 


-- 1. Listar todos los libros junto con sus autores y categorías.
-- 2. Mostrar el número total de libros disponibles en la biblioteca.
-- 3. Mostrar los lectores que han realizado más de dos préstamos.
-- 4. Encontrar las categorías que no tienen libros asignados.
-- 5. Listar los autores que tienen más de un libro en la biblioteca.
-- 6. Mostrar el promedio de ejemplares disponibles por categoría.
-- 7. Mostrar los préstamos cuya fecha de devolución es anterior a la fecha de préstamo.
-- 8. Encontrar los lectores que han pedido libros de todas las categorías.
-- 9. Mostrar los libros que han sido prestados por lectores llamados 'Juan Pérez'.
-- 10. Mostrar los meses y el número de préstamos realizados en cada mes.
