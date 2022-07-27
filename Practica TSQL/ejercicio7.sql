/* 
Hacer un procedimiento que dadas dos fechas complete la tabla Ventas. Debe
insertar una línea por cada artículo con los movimientos de stock generados por
las ventas entre esas fechas. La tabla se encuentra creada y vacía.
VENTAS
Código | Detalle | Cant. Mov. | Precio de Venta (promedio) | Renglon | Ganancia = PrecioVenta - Qty * Costo
*/

BEGIN TRANSACTION T
GO

CREATE TABLE Ventas
(
    [Código] char(8) NOT NULL PRIMARY KEY, 
    [Detalle] char(30) NOT NULL, 
    [Cant. Mov.] decimal(12,2) NOT NULL,
    [Precio de Venta] decimal(12,2) NOT NULL,
    [Renglon] bigint NOT NULL,
    [Ganancia] decimal(12,2) NOT NULL
)
GO

CREATE PROCEDURE insertarVentas(@fechaInicio DATETIME, @fechaFin DATETIME)
AS
BEGIN
    INSERT INTO Ventas ([Código], [Detalle], [Cant. Mov.], [Precio de Venta], [Renglon], [Ganancia])
    SELECT  P.prod_codigo AS [Código], 
            P.prod_detalle AS [Detalle], 
            COUNT(*) AS [Cant. Mov.], 
            AVG(I.item_precio) AS [Precio de Venta],
            ROW_NUMBER() OVER (ORDER BY P.prod_codigo) AS Renglon,
            SUM(I.item_precio) - SUM(I.item_cantidad) * P.prod_precio AS [Ganancia]
    FROM Producto P
    JOIN Item_Factura I ON I.item_producto = P.prod_codigo
    JOIN Factura F  ON F.fact_numero = I.item_numero
                    AND F.fact_sucursal = I.item_sucursal
                    AND F.fact_tipo = I.item_tipo
    WHERE F.fact_fecha <= @fechaFin AND F.fact_fecha >= @fechaInicio
END
GO

ROLLBACK TRANSACTION T
GO