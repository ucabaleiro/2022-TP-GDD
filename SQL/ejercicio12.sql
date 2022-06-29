/* Mostrar nombre de producto, cantidad de clientes distintos que lo compraron, importe
promedio pagado por el producto, cantidad de depósitos en los cuales hay stock del
producto y stock actual del producto en todos los depósitos. Se deberán mostrar
aquellos productos que hayan tenido operaciones en el año 2012 y los datos deberán
ordenarse de mayor a menor por monto vendido del producto. */

SELECT  P.prod_detalle, 
        COUNT(DISTINCT F.fact_cliente) AS cantidadClientes,
        AVG(I.item_cantidad * I.item_precio) AS importePromedio,
        (
		    SELECT COUNT(DISTINCT stoc_deposito) 
		    FROM STOCK
		    WHERE P.prod_codigo = stoc_producto 
			AND stoc_cantidad > 0
	    ) AS [Cantidad de Depositos en los que hay stock],
        (
		    SELECT SUM(stoc_cantidad)
		    FROM STOCK
		    WHERE P.prod_codigo = stoc_producto
	    ) AS [Stock Actual en todos los depositos]
FROM Producto P
JOIN Item_Factura I ON I.item_producto = P.prod_codigo
JOIN Factura F ON F.fact_tipo = I.item_tipo
        AND F.fact_sucursal = I.item_sucursal
        AND F.fact_numero = I.item_numero
WHERE YEAR(F.fact_fecha) = 2012
GROUP BY P.prod_codigo, P.prod_detalle
ORDER BY SUM(I.item_cantidad * I.item_precio) DESC