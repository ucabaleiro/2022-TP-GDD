/* Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por
cantidad vendida. */

SELECT P.prod_codigo, P.prod_detalle, SUM(I.item_cantidad) as cantidad
FROM Factura F
JOIN Item_Factura I 
    ON I.item_tipo = F.fact_tipo
    AND I.item_sucursal = F.fact_sucursal
    AND I.item_numero = F.fact_numero
JOIN Producto P
    ON P.prod_codigo = I.item_producto
WHERE YEAR(F.fact_fecha) = 2012
GROUP BY P.prod_codigo, P.prod_detalle
ORDER BY cantidad DESC