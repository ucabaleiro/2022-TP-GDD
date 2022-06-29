/* 17. Escriba una consulta que retorne una estadística de ventas por año y mes para cada
producto.
La consulta debe retornar:
PERIODO: Año y mes de la estadística con el formato YYYYMM
PROD: Código de producto
DETALLE: Detalle del producto
CANTIDAD_VENDIDA= Cantidad vendida del producto en el periodo
VENTAS_AÑO_ANT= Cantidad vendida del producto en el mismo mes del periodo
pero del año anterior
CANT_FACTURAS= Cantidad de facturas en las que se vendió el producto en el
periodo
La consulta no puede mostrar NULL en ninguna de sus columnas y debe estar ordenada
por periodo y código de producto. */

SELECT  FORMAT(F.fact_fecha, 'yyyy/MM') AS PERIODO,
        P.prod_codigo AS PROD,
        P.prod_detalle AS DETALLE,
        SUM(I.item_cantidad) AS CANTIDAD_VENDIDA,
        (
            SELECT ISNULL(SUM(I2.item_cantidad),0)
            FROM Item_Factura I2
            JOIN Factura F2 ON F2.fact_numero = I2.item_numero
                            AND F2.fact_sucursal = I2.item_sucursal
                            AND F2.fact_tipo = I2.item_tipo
            WHERE I2.item_producto = P.prod_codigo
                AND YEAR(F2.fact_fecha) = YEAR(F.fact_fecha) - 1
                AND MONTH(F2.fact_fecha) = MONTH(F.fact_fecha)
        ) AS VENTAS_ANIO_ANT,
        COUNT(*) AS CANT_FACTURAS
FROM Producto P 
JOIN Item_Factura I ON I.item_producto = P.prod_codigo
JOIN Factura F  ON F.fact_numero = I.item_numero
                AND F.fact_sucursal = I.item_sucursal
                AND F.fact_tipo = I.item_tipo
GROUP BY F.fact_fecha, P.prod_codigo, P.prod_detalle
ORDER BY F.fact_fecha, P.prod_codigo DESC
