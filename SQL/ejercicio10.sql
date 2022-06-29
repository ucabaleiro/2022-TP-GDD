/* Mostrar los 10 productos más vendidos en la historia y también los 10 productos menos
vendidos en la historia. Además mostrar de esos productos, quien fue el cliente que
mayor compra realizo. */

SELECT P.prod_codigo, P.prod_detalle,
    (
		SELECT TOP 1 C.clie_razon_social
		FROM Factura F
		JOIN Item_Factura Imax
				ON F.fact_sucursal = Imax.item_sucursal 
                AND F.fact_numero = Imax.item_numero 
                AND F.fact_tipo = Imax.item_tipo
        JOIN Cliente C ON C.clie_codigo = F.fact_cliente
		WHERE P.prod_codigo = Imax.item_producto
        GROUP BY C.clie_razon_social
		ORDER BY SUM(Imax.item_cantidad) DESC
	) AS clienteMayorCompra
FROM Producto P
JOIN Item_Factura I ON I.item_producto = P.prod_codigo
WHERE 
	P.prod_codigo IN(
		SELECT TOP 10 item_producto
		FROM Item_Factura
		GROUP BY item_producto
		ORDER BY SUM(item_cantidad) DESC
	)
	OR
	P.prod_codigo IN(
		SELECT TOP 10 item_producto
		FROM Item_Factura
		GROUP BY item_producto
		ORDER BY SUM(item_cantidad) ASC
	)
GROUP BY P.prod_codigo,P.prod_detalle