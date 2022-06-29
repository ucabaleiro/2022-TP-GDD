/* Realizar una consulta que muestre código de artículo, detalle y cantidad de egresos de
stock que se realizaron para ese artículo en el año 2012 (egresan los productos que
fueron vendidos). Mostrar solo aquellos que hayan tenido más egresos que en el 2011. */

-- Cantidad de egresos = Cantidad de ventas

/* Solucion con subquery en HAVING */
SELECT P.prod_codigo, P.prod_detalle, SUM(I.item_cantidad) as cantidad2012
FROM Producto P
JOIN Item_Factura I ON P.prod_codigo = I.item_producto
JOIN Factura F
	ON F.fact_numero = I.item_numero 
    AND F.fact_sucursal = I.item_sucursal 
    AND F.fact_tipo = I.item_tipo
WHERE YEAR(F.fact_fecha) = 2012
GROUP BY P.prod_codigo, P.prod_detalle
HAVING SUM(I.item_cantidad) > (
		SELECT SUM(I2.item_cantidad)
		FROM Item_Factura I2
		JOIN Factura F2
			ON F2.fact_numero = I2.item_numero 
            AND F2.fact_sucursal = I2.item_sucursal 
            AND F2.fact_tipo = I2.item_tipo
		WHERE YEAR(F2.fact_fecha) = 2011 AND I2.item_producto = P.prod_codigo
		)
ORDER BY P.prod_codigo