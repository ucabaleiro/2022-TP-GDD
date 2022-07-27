/* Realizar una consulta que retorne el detalle de la familia, la cantidad diferentes de
productos vendidos y el monto de dichas ventas sin impuestos. Los datos se deberán
ordenar de mayor a menor, por la familia que más productos diferentes vendidos tenga,
solo se deberán mostrar las familias que tengan una venta superior a 20000 pesos para
el año 2012. */

SELECT  F.fami_detalle, 
        COUNT(DISTINCT P.prod_codigo) AS productosDistintosVendidos, 
        SUM(I.item_cantidad * I.item_precio) dineroEnVentas
FROM Familia F
JOIN Producto P ON P.prod_familia = F.fami_id
JOIN Item_Factura I ON I.item_producto = P.prod_codigo
GROUP BY F.fami_detalle
HAVING  (
            SELECT TOP 1 SUM(I.item_cantidad * I.item_precio)
            FROM Familia F
            JOIN Producto P ON P.prod_familia = F.fami_id
            JOIN Item_Factura I ON I.item_producto = P.prod_codigo
            JOIN Factura Fact ON I.item_tipo = Fact.fact_tipo
                              AND I.item_sucursal = Fact.fact_sucursal
                              AND I.item_numero = Fact.fact_numero
            WHERE YEAR(Fact.fact_fecha) = 2012  
        ) > 20000
ORDER BY dineroEnVentas DESC