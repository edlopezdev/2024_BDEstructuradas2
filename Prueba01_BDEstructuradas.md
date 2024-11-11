# Prueba de Evaluación de Bases de Datos Estructuradas

**Duración:** 1 hora 30 minutos  
**Total de puntos:** 100

---

## Parte 1: Preguntas Teóricas (20 puntos)
Responde las siguientes preguntas de manera breve, concisa y utilizando su lenguaje.

1. **(5 puntos)** Define qué es un procedimiento almacenado y menciona dos ventajas de su uso.
2. **(5 puntos)** Explica qué es un índice en SQL y cómo puede mejorar el rendimiento de una base de datos.
3. **(5 puntos)** Describe qué es un trigger y menciona un caso de uso práctico.
4. **(5 puntos)** Diferencia entre una vista y una tabla en SQL.

---

## Parte 2: Ejercicios Prácticos (40 puntos)
Realiza los siguientes ejercicios basados en el modelo de datos del hospital.

1. **(10 puntos)** Escribe una consulta para mostrar los detalles de las citas (Paciente, Médico, Fecha, Estado) cuyo estado sea `"Pendiente"`.
2. **(10 puntos)** Crea un procedimiento almacenado llamado `ActualizarEstadoCita` que reciba como parámetros el ID de una cita y el nuevo estado, y actualice el estado en la tabla `Citas`.
3. **(10 puntos)** Diseña un índice en la tabla `Tratamientos` que acelere las búsquedas por la columna `Costo`.
4. **(10 puntos)** Crea una vista llamada `PacientesPorEspecialidad` que muestre los pacientes atendidos por cada médico, agrupados por su especialidad.

---

## Parte 3: Consultas SQL Aplicadas (40 puntos)
Desarrolla las siguientes consultas para obtener la información requerida.

1. **(10 puntos)** Escribe una consulta para obtener el costo promedio de los tratamientos realizados en citas atendidas por un médico específico, cuyo `MedicoID` se pasa como parámetro.
2. **(10 puntos)** Escribe una consulta para obtener la lista de pacientes que tienen citas registradas en el sistema más de una vez el mismo día.
3. **(10 puntos)** Escribe un trigger que se active después de cada inserción en la tabla `Citas`, registrando la acción en una tabla de auditoría llamada `AuditoriaCitas` con las columnas: `AuditoriaID`, `CitaID`, `Accion` (Insertar) y `Fecha`.
4. **(10 puntos)** Muestra las citas programadas para la próxima semana, ordenadas por fecha.

---
