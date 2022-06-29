SELECT P.prod_codigo
	,P.prod_detalle
	,SUM(IFACT.item_cantidad) AS [Cantidad unidades vendidas]
	,COUNT(DISTINCT IFACT.item_numero+IFACT.item_tipo+IFACT.item_sucursal) [Cant fact realizadas]
	,AVG(IFACT.item_precio) [Precio promedio facturado]
	,SUM(IFACT.item_precio*IFACT.item_cantidad) [Total Facturado]
FROM Producto P
	INNER JOIN Item_Factura IFACT
		ON IFACT.item_producto = P.prod_codigo
	INNER JOIN Composicion C
		ON C.comp_componente = P.prod_codigo
WHERE C.comp_producto = (
                            SELECT TOP 1
                                IFACT2.item_producto
                            FROM Item_Factura IFACT2    
                                JOIN Factura F2
                                ON F2.fact_tipo = IFACT2.item_tipo 
                                AND F2.fact_sucursal = IFACT2.item_sucursal 
                                AND F2.fact_numero = IFACT2.item_numero
                            WHERE YEAR(F2.fact_fecha) = 2012
                            GROUP BY IFACT2.item_producto
                            ORDER BY SUM(IFACT2.item_cantidad) DESC
                        )
GROUP BY P.prod_codigo, P.prod_detalle