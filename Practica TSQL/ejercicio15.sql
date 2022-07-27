/* Cree el/los objetos de base de datos necesarios para que el objeto principal
reciba un producto como parametro y retorne el precio del mismo.
Se debe prever que el precio de los productos compuestos sera la sumatoria de
los componentes del mismo multiplicado por sus respectivas cantidades. No se
conocen los nivles de anidamiento posibles de los productos. Se asegura que
nunca un producto esta compuesto por si mismo a ningun nivel. El objeto
principal debe poder ser utilizado como filtro en el where de una sentencia
select. */

BEGIN TRANSACTION
GO

CREATE FUNCTION precioCompuesto(@codigoProducto char(8))
RETURNS decimal(12,2)
AS
BEGIN
    DECLARE @precioCompuesto decimal(12,2)
    
    WITH CompPadreHijo AS (
        SELECT CAST(NULL AS char(8)) AS [Padre], P.prod_codigo AS [Codigo], 
        CONVERT(decimal(12,2), 0) AS [Cantidad], 0 AS [Nivel]
        FROM Producto P
        WHERE P.prod_codigo NOT IN (SELECT comp_componente FROM Composicion)
        AND P.prod_codigo IN (SELECT comp_producto FROM Composicion)
        
        UNION ALL
        
        SELECT CP.Codigo as [Padre], P2.prod_codigo AS [Codigo], 
        C.comp_cantidad AS [Cantidad], CP.[Nivel] + 1 AS [NIVEL]
        FROM Producto P2
        JOIN Composicion C ON P2.prod_codigo = C.comp_componente
        JOIN CompPadreHijo CP ON C.comp_producto = CP.Codigo
    ),
    CompRecursivo AS (
        SELECT Padre, Codigo, Cantidad, Nivel
        FROM CompPadreHijo
        WHERE Padre IS NOT NULL

        UNION ALL

        SELECT CR.Padre, CP.Codigo, CONVERT(decimal(12,2),CP.Cantidad * CR.Cantidad), CP.Nivel
        FROM CompPadreHijo CP
        JOIN CompRecursivo CR ON CP.Padre = CR.Codigo
    ),
    CompRecursivoHojas AS (
        SELECT Padre AS Producto, Codigo AS Hoja, Cantidad, Nivel
        FROM CompRecursivo
        WHERE Codigo NOT IN (SELECT Padre FROM CompRecursivo)
    )
    SELECT @precioCompuesto = SUM(Cantidad * P.prod_precio)
    FROM CompRecursivoHojas
    JOIN Producto P ON P.prod_codigo = Hoja
    WHERE Producto = @codigoProducto

    RETURN @precioCompuesto
END
GO

ROLLBACK TRANSACTION
GO