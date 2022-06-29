SELECT P.prod_rubro
	,MONTH(F.fact_fecha) AS MES
	,COUNT(DISTINCT F.fact_tipo+F.fact_sucursal+F.fact_numero) AS FACTURAS_MALAS
FROM Producto P
	JOIN Item_Factura IFACT
		ON IFACT.item_producto = P.prod_codigo
	JOIN Factura F
		ON F.fact_tipo = IFACT.item_tipo 
        AND F.fact_sucursal = IFACT.item_sucursal 
        AND F.fact_numero = IFACT.item_numero
    JOIN Item_Factura IFACT2
        ON IFACT2.item_tipo = F.fact_tipo 
        AND IFACT2.item_sucursal = F.fact_sucursal 
        AND IFACT2.item_numero = F.fact_numero
    JOIN Producto P2
        ON P2.prod_codigo = IFACT2.item_producto
WHERE YEAR(F.fact_fecha) = 2011 AND P.prod_rubro != P2.prod_rubro
GROUP BY P.prod_rubro, MONTH(F.fact_fecha)
ORDER BY P.prod_rubro, MES ASC