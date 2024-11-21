-- 1. Obtener los libros más prestados.
SELECT TOP 3 L.Titulo, COUNT(P.PrestamoID) AS TotalPrestamos
FROM Libros L
JOIN Prestamos P ON L.LibroID = P.LibroID
GROUP BY L.Titulo
ORDER BY TotalPrestamos DESC;

-- 2. Mostrar los lectores que tienen préstamos pendientes.
SELECT Lec.Nombre, Lec.Email, P.FechaPrestamo
FROM Lectores Lec
JOIN Prestamos P ON Lec.LectorID = P.LectorID
WHERE P.Estado = 'Pendiente';

-- 3. Calcular cuántos libros hay disponibles por categoría.
SELECT Cat.Nombre AS Categoria, SUM(L.Disponibles) AS TotalLibrosDisponibles
FROM Categorias Cat
JOIN Libros L ON Cat.CategoriaID = L.CategoriaID
GROUP BY Cat.Nombre;

-- 4. Mostrar el autor con más libros registrados en la biblioteca.
SELECT A.Nombre, COUNT(L.LibroID) AS TotalLibros
FROM Autores A
JOIN Libros L ON A.AutorID = L.AutorID
GROUP BY A.Nombre
ORDER BY TotalLibros DESC;

-- 5. Listar los préstamos que están retrasados.
SELECT P.PrestamoID, L.Nombre AS Lector, Li.Titulo, P.FechaPrestamo, P.FechaDevolucion
FROM Prestamos P
JOIN Lectores L ON P.LectorID = L.LectorID
JOIN Libros Li ON P.LibroID = Li.LibroID
WHERE P.Estado = 'Retrasado';

-- 6. Obtener el promedio de libros prestados por lector.
SELECT AVG(LibrosPrestados) AS PromedioPrestamos
FROM (
    SELECT LectorID, COUNT(*) AS LibrosPrestados
    FROM Prestamos
    GROUP BY LectorID
) SubQuery;

-- 7. Mostrar los préstamos realizados entre dos fechas específicas.
SELECT P.PrestamoID, L.Nombre AS Lector, Li.Titulo, P.FechaPrestamo
FROM Prestamos P
JOIN Lectores L ON P.LectorID = L.LectorID
JOIN Libros Li ON P.LibroID = Li.LibroID
WHERE P.FechaPrestamo BETWEEN '2024-11-01' AND '2024-11-15';

-- 8. Determinar cuántos préstamos han realizado los lectores por cada libro.
SELECT L.Titulo, COUNT(P.PrestamoID) AS TotalPrestamos
FROM Libros L
JOIN Prestamos P ON L.LibroID = P.LibroID
GROUP BY L.Titulo;

-- 9. Mostrar los libros que no han sido prestados nunca.
SELECT L.Titulo
FROM Libros L
LEFT JOIN Prestamos P ON L.LibroID = P.LibroID
WHERE P.PrestamoID IS NULL;

-- 10. Mostrar todos los lectores que han pedido libros de una categoría específica (ejemplo: Fantasía).
SELECT Lec.Nombre, Lec.Email, Cat.Nombre AS Categoria
FROM Lectores Lec
JOIN Prestamos P ON Lec.LectorID = P.LectorID
JOIN Libros L ON P.LibroID = L.LibroID
JOIN Categorias Cat ON L.CategoriaID = Cat.CategoriaID
WHERE Cat.Nombre = 'Fantasía';
