-- 1. Creación de la base de datos
CREATE DATABASE BD_TiendaVirtual;
GO

USE BD_TiendaVirtual;

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
    Estado NVARCHAR(20) -- Ej.: 'Confirmada', 'Pendiente', 'Cancelada'
);

-- 3. Inserción de datos ficticios
INSERT INTO Clientes VALUES 
(1, 'Juan', 'Pérez', 'juan.perez@mail.com', '+56912345678', EncryptByPassPhrase('ClaveSecreta', '5000')),
(2, 'María', 'González', 'maria.gonzalez@mail.com', '+56987654321', EncryptByPassPhrase('ClaveSecreta', '3000')),
(3, 'Carlos', 'Rojas', 'carlos.rojas@mail.com', '+56922334455', EncryptByPassPhrase('ClaveSecreta', '7000'));

INSERT INTO Productos VALUES 
(1, 'Laptop', 800000, 10),
(2, 'Mouse', 15000, 50),
(3, 'Teclado', 30000, 30);

INSERT INTO Ventas VALUES 
(1, 1, 1, '2023-11-01', 'Confirmada'),
(2, 2, 2, '2023-11-02', 'Pendiente'),
(3, 3, 3, '2023-11-03', 'Cancelada');

-- 4. Preguntas tipo prueba:

-- Preguntas sobre SAVE TRAN y ROLLBACK TO
-- 1. Crea una transacción que inserte un nuevo cliente y una venta asociada. Guarda un punto de transacción con SAVE TRAN y realiza un rollback parcial.
-- 2. Inserta un nuevo producto y realiza un rollback completo para deshacer la operación.

-- Preguntas sobre Niveles de Aislamiento
-- 3. Configura el nivel de aislamiento SERIALIZABLE y realiza una consulta de las ventas.
-- 4. Configura el nivel de aislamiento READ COMMITTED y verifica su efecto en la tabla `Clientes`.

-- Preguntas sobre UNION y UNION ALL
-- 5. Utiliza UNION para combinar los nombres de los clientes y los productos.
-- 6. Utiliza UNION ALL para combinar los correos de los clientes y el estado de las ventas.

-- Preguntas sobre LEN y CONCAT
-- 7. Muestra el nombre completo de los clientes concatenando `Nombre` y `Apellido` con un espacio entre ellos.
-- 8. Muestra la longitud de los nombres de los productos utilizando la función LEN.

-- Pregunta sobre WITH(NOLOCK)
-- 9. Realiza una consulta a la tabla `Ventas` utilizando WITH(NOLOCK) para evitar bloqueos.

-- Preguntas sobre EXECUTE AS
-- 10. Crea un procedimiento almacenado que permita consultar los datos descifrados del saldo de los clientes. Usa EXECUTE AS para ejecutarlo bajo un usuario autorizado.
-- 11. Verifica qué sucede si intentas ejecutar el procedimiento con un usuario no autorizado.

-- Preguntas sobre CASE
-- 12. Crea una consulta que clasifique las ventas como "Alta" si el precio del producto es mayor a 100,000, y "Baja" en caso contrario.
-- 13. Crea una consulta que clasifique el stock de los productos como "Bajo" (<=10), "Medio" (11-30), o "Alto" (>30).

-- Preguntas sobre WHILE
-- 14. Utiliza un ciclo WHILE para mostrar los nombres de los productos iterando por su `ProductoID`.
-- 15. Crea un ciclo WHILE que calcule y muestre la suma acumulativa del stock de los productos.

-- Pregunta sobre GOTO
-- 16. Crea un ciclo WHILE que recorra los productos y use GOTO para salir si encuentra un producto con stock menor a 5.

-- Preguntas sobre EncryptByPassPhrase y DecryptByPassPhrase
-- 17. Crea una consulta que descifre y muestre el saldo de cada cliente.
-- 18. Actualiza el saldo cifrado de un cliente utilizando EncryptByPassPhrase.
-- 19. Crea un procedimiento almacenado cifrado (`WITH ENCRYPTION`) que permita actualizar el saldo cifrado de un cliente.

-- Ejercicio Integrador
-- 20. Combina varios conceptos: 
--     a) Crea una transacción que inserte un nuevo cliente y un nuevo producto.
--     b) Usa SAVE TRAN para guardar un punto de la transacción.
--     c) Realiza una clasificación con CASE del stock de los productos.
--     d) Descifra el saldo de un cliente usando DecryptByPassPhrase.
