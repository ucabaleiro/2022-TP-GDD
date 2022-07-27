/* Cree el/los objetos de base de datos necesarios para que dado un código de
empleado se retorne la cantidad de empleados que este tiene a su cargo (directa o
indirectamente). Solo contar aquellos empleados (directos o indirectos) que
tengan un código mayor que su jefe directo. */

BEGIN TRANSACTION T
GO

CREATE FUNCTION cantidadSubordinados(@codigoJefe numeric(6))
RETURNS int
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
    JOIN Empleado E ON JefeEmpleadoRecursivo.codigoEmpleado = E.empl_codigo
    WHERE codigoJefe = @codigoJefe 
        AND E.empl_codigo > E.empl_jefe

    RETURN @cantidad
END
GO

BEGIN
DECLARE @result int;
SET @result = dbo.cantidadSubordinados(1);
PRINT @result; --deberia ser 8
SET @result = dbo.cantidadSubordinados(2);
PRINT @result; --deberia ser 1
SET @result = dbo.cantidadSubordinados(3);
PRINT @result; --deberia ser 5
END
GO

ROLLBACK TRANSACTION T
GO