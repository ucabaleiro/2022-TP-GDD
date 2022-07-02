/* Cree el/los objetos de base de datos necesarios para implantar la siguiente regla
“Ningún jefe puede tener un salario mayor al 20% de las suma de los salarios de
sus empleados totales (directos + indirectos)”. Se sabe que en la actualidad dicha
regla se cumple y que la base de datos es accedida por n aplicaciones de
diferentes tipos y tecnologías */

BEGIN TRANSACTION T
GO

CREATE TRIGGER controlSalario ON Empleado AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @cantidad int;
    
    WITH JefeEmpleado AS (
        SELECT  E.empl_jefe AS [codigoJefe], 
                E.empl_codigo AS [codigoEmpleado], 
                0 AS [Nivel]
        FROM Empleado E
        WHERE E.empl_jefe IS NULL
        
        UNION ALL
        
        SELECT  E2.empl_jefe AS [codigoJefe], 
                E2.empl_codigo AS [codigoEmpleado], 
                JE.[Nivel] + 1 AS [Nivel]
        FROM Empleado E2
        JOIN JefeEmpleado JE ON E2.empl_jefe = JE.codigoEmpleado
    ),
    JefeEmpleadoRecursivo AS (
        SELECT codigoJefe, codigoEmpleado, Nivel
        FROM JefeEmpleado
        WHERE codigoJefe != codigoEmpleado

        UNION ALL

        SELECT JER.codigoJefe, JE.codigoEmpleado, JE.Nivel
        FROM JefeEmpleado JE
        JOIN JefeEmpleadoRecursivo JER ON JE.codigoJefe = JER.codigoEmpleado
    )
    SELECT @cantidad = COUNT(*)
    FROM JefeEmpleadoRecursivo
    JOIN Empleado JEFE ON codigoJefe = JEFE.empl_codigo
    JOIN Empleado EMPL ON codigoEmpleado = EMPL.empl_codigo
    GROUP BY JEFE.empl_salario
    HAVING JEFE.empl_salario > SUM(EMPL.empl_salario) * 1.2

    IF(@cantidad > 0)
    BEGIN
        PRINT 'Error: No puede haber un jefe con un salario mayor al 20% de la suma de los salarios de sus empleados totales (directos + indirectos)';
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO

UPDATE Empleado SET empl_salario = 1000000.00
WHERE empl_codigo = 2
GO

ROLLBACK TRANSACTION T
GO