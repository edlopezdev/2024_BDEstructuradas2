## Docente 
    Edgar López

## Asignatura 
    Bases De Datos Estructuradas

## Descripción
Este repositorio contiene los materiales y ejercicios para la Clase 1 del curso de Bases de Datos Estructuradas. En esta clase, introducimos los conceptos básicos de objetos de esquema, incluyendo la creación de tablas, vistas e índices.

## Objetivos de la Asignatura
Desarrollo de habilidades prácticas en manejo de bases de datos: El curso se enfoca en habilidades prácticas más que en teoría pura, lo cual es crucial para aplicaciones reales en tecnologías de información y ciberseguridad.

Gestión de objetos de esquema: Esto implica que los estudiantes aprenderán a manejar y modificar la estructura de las bases de datos, como tablas, vistas, índices, entre otros.
Elaboración de consultas: Serán capaces de crear consultas SQL para extraer y manipular datos de manera efectiva.

Construcción de procedimientos y triggers: 
    Aprenderán a escribir procedimientos almacenados y triggers para automatizar tareas y garantizar la integridad de los datos.
Operación segura de bases de datos: 
    Se enfatizará en las prácticas de seguridad para proteger la información y operar dentro de un marco ético y legal.
Competencias a Desarrollar
    Competencias técnicas: Dominio de SQL, diseño y gestión de bases de datos.
    Competencias en ciberseguridad: Aseguramiento de la integridad y seguridad de los datos.
    Competencias éticas y ciudadanas: Enseñanza de cómo la tecnología se relaciona con la ética y los derechos ciudadanos, especialmente importante en el manejo de información sensible.
Modalidad de Enseñanza
    Presencial con componente online: Esto sugiere una combinación de clases en persona para habilidades prácticas y componentes online para teoría o actividades complementarias, ofreciendo una experiencia de aprendizaje flexible y accesible.

## Contenido del Repositorio

- `***.sql`: Archivo con las soluciones a los ejercicios propuestos.

## Ejercicios Prácticos Clase 1
1. Creación de Tablas
Descripción:
    Crea una tabla llamada Estudiantes que contenga las siguientes columnas:
        ID como número entero, que sea la clave primaria y que se autoincremente.
        Nombre como texto (cadena de caracteres) que no puede ser nulo.
        Edad como número entero.
        FechaIngreso como fecha.

2. Creación de Vistas
Descripción:
    Crea una vista llamada VistaEstudiantes que muestre el nombre y la edad de los estudiantes que tengan más de 18 años.

3. Creación de Índices
Descripción:
    Crea un índice para la columna Edad en la tabla Estudiantes para mejorar la velocidad de las consultas que filtren por edad.

## Ejercicios Parte 2:

Usando el script de "script_clase 01.sql"

1. **Consulta Básica**: Mostrar todos los libros de la tabla "Libros".
2. **Consulta con Filtro**: Mostrar el nombre y nacionalidad del autor del libro con ID 2.
3. **Consulta con JOIN**: Mostrar el título del libro y el nombre del autor de todos los libros.
4. **Actualización de Datos**: Cambiar la nacionalidad del autor con ID 3 a "Argentino - Francés".
5. **Inserción de Datos**: Agregar un nuevo autor a la tabla "Autores" con ID 4, nombre "Isabel Allende" y nacionalidad "Chilena".
6. **Eliminación de Datos**: Eliminar el libro con ID 1 de la tabla "Libros".

## Respuestas: 
1. ```SELECT * FROM Libros;```
2. ```SELECT Autores.Nombre, Autores.Nacionalidad FROM Autores JOIN Libros ON Autores.ID = Libros.Autor_ID WHERE Libros.ID = 2;```
3. ```SELECT Libros.Titulo, Autores.Nombre FROM Libros JOIN Autores ON Libros.Autor_ID = Autores.ID;```
4. ```UPDATE Autores SET Nacionalidad = 'Argentino - Francés' WHERE ID = 3;```
5. ```INSERT INTO Autores (ID, Nombre, Nacionalidad) VALUES (4, 'Isabel Allende', 'Chilena');```
6. ```DELETE FROM Libros WHERE ID = 1;```

## Ejercicios sin solución:

1. **Crear un nuevo libro**:
Inserta un nuevo registro en la tabla "Libros" con los siguientes datos:
   - ID: 4
   - Título: "El amor en los tiempos del cólera"
   - Autor_ID: 1
2. **Actualizar un libro**:
Actualiza el título del libro con ID 2 a "Conversación en la catedral".
3. **Eliminar un autor**:
Elimina el autor con ID 3 de la tabla "Autores" y todos los libros asociados a este autor.
4. **Leer todos los libros de un autor**:
Muestra todos los libros escritos por el autor con ID 1.
5. **Actualizar la nacionalidad de un autor**:
Cambia la nacionalidad del autor con ID 2 a "Peruana".

## Ejercicios Prácticos Clase 2

6. **Creación de una Función**: 
    - Descripción: Crea una función `fn_CantidadEstudiantes` que devuelva el número total de estudiantes.
    - Script: 
      ```sql
      CREATE FUNCTION fn_CantidadEstudiantes() RETURNS INT AS BEGIN
          DECLARE @total INT;
          SELECT @total = COUNT(*) FROM Estudiantes;
          RETURN @total;
      END;
      ```

7. **Uso de la Función**: 
    - Descripción: Utiliza la función creada para mostrar el total de estudiantes.
    - Script: 
      ```sql
      SELECT dbo.fn_CantidadEstudiantes() AS TotalEstudiantes;
      ```

8. **Creación de un Procedimiento Almacenado para Actualizar Edad**:
    - Descripción: Crea un procedimiento almacenado `sp_ActualizarEdad` que permita actualizar la edad de un estudiante dado su ID.
    - Script: 
      ```sql
      CREATE PROCEDURE sp_ActualizarEdad @EstudianteID INT, @NuevaEdad INT AS
      BEGIN
          UPDATE Estudiantes SET Edad = @NuevaEdad WHERE ID = @EstudianteID;
      END;
      ```

9. **Uso del Procedimiento Almacenado para Actualizar Edad**:
    - Descripción: Actualiza la edad del estudiante con ID 1 a 22 años usando el procedimiento `sp_ActualizarEdad`.
    - Script: 
      ```sql
      EXEC sp_ActualizarEdad @EstudianteID = 1, @NuevaEdad = 22;
      ```

10. **Creación de Índices sobre Múltiples Columnas**:
    - Descripción: Crea un índice compuesto en las columnas `Nombre` y `FechaIngreso` para optimizar las consultas que usan estos campos.
    - Script: 
      ```sql
      CREATE NONCLUSTERED INDEX idx_NombreFechaIngreso ON Estudiantes (Nombre, FechaIngreso);
      ```
## Ejercicios sin Solución

1. **Consulta Avanzada de Estudiantes**:
   - Escribe una consulta SQL que liste todos los estudiantes menores de 25 años ordenados por fecha de ingreso de manera ascendente.

2. **Actualización de Información**:
   - Actualiza el registro de los estudiantes para incrementar su edad en un año si han ingresado antes del año 2023.

3. **Eliminar Estudiantes**:
   - Elimina de la tabla `Estudiantes` aquellos que tienen más de 30 años.

4. **Creación de Vistas Complejas**:
   - Crea una vista llamada `VistaEstudiantesActivos` que muestre solamente los estudiantes que tienen menos de 30 años y ordena los resultados por edad de manera descendente.

5. **Función para Calcular la Edad Mínima**:
   - Desarrolla una función llamada `fn_EdadMinimaEstudiantes` que devuelva la edad mínima de los estudiantes.



## Contribuciones
Las contribuciones a este repositorio son bienvenidas. Si tienes sugerencias para mejorar los ejercicios, por favor, crea un pull request o abre un issue.

## Licencia
Este proyecto está licenciado bajo la Licencia MIT - vea el archivo `LICENSE.md` para más detalles.
