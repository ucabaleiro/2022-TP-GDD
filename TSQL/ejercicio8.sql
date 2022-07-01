/* Realizar un procedimiento que complete la tabla Diferencias de precios, para los
productos facturados que tengan composición y en los cuales el precio de
facturación sea diferente al precio del cálculo de los precios unitarios por
cantidad de sus componentes, se aclara que un producto que compone a otro,
también puede estar compuesto por otros y así sucesivamente, la tabla se debe
crear y está formada por las siguientes columnas: */

--SOLUCION SIN RECURSIVIDAD DE COMPOSICIONES
BEGIN TRANSACTION T
GO

CREATE TABLE Diferencias (
    [Codigo] char(8) NOT NULL PRIMARY KEY,
    [Detalle] char(50) NOT NULL,
    [Cantidad] decimal(12,2) NOT NULL,
    [Precio_generado] decimal(12,2) NOT NULL,
    [Precio_compra] decimal(12,2) NOT NULL
)
GO

CREATE PROCEDURE cargarDiferencias
AS
BEGIN 
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
    INSERT INTO Diferencias (Codigo, Detalle, Cantidad, Precio_generado, Precio_compra)
    SELECT  P.prod_codigo AS [Codigo], 
            P.prod_detalle AS [Detalle], 
            SUM(C.Cantidad) AS [Cantidad],
            SUM(C.Cantidad * P2.prod_precio) AS [Precio Generado],
            P.prod_precio AS [Precio_facturado]
    FROM Producto P 
    JOIN CompRecursivoHojas C ON C.Producto = P.prod_codigo
    JOIN Producto P2 ON P2.prod_codigo = C.Hoja
    GROUP BY P.prod_codigo, P.prod_detalle, P.prod_precio
    HAVING SUM(P.prod_precio) != SUM(C.Cantidad * P2.prod_precio)
END
GO

EXEC cargarDiferencias
GO

SELECT * FROM Diferencias
GO

ROLLBACK TRANSACTION T
GO