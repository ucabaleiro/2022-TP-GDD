/*32. Se desea conocer las familias que sus productos se facturaron juntos en las mismas
facturas para ello se solicita que escriba una consulta sql que retorne los pares de
familias que tienen productos que se facturaron juntos. Para ellos deberá devolver las
siguientes columnas:
- Código de familia
- Detalle de familia
- Código de familia
- Detalle de familia
- Cantidad de facturas
- Total vendido
Los datos deberan ser ordenados por Total vendido y solo se deben mostrar las familias
que se vendieron juntas más de 10 veces.*/

SELECT  F1.fami_id, F1.fami_detalle, F2.fami_id, F2.fami_detalle,
        COUNT(DISTINCT F.fact_numero+F.fact_sucursal+F.fact_tipo) AS [Cantidad de facturas],
        SUM(I1.item_cantidad*I1.item_precio) AS [Total vendido Familia 1],
        SUM(I2.item_cantidad*I2.item_precio) AS [Total vendido Familia 2],
        SUM(I1.item_cantidad*I1.item_precio) + SUM(I2.item_cantidad*I2.item_precio) AS [Total vendido]
FROM Familia F1
JOIN Producto P1 ON P1.prod_familia = F1.fami_id
JOIN Item_Factura I1 ON I1.item_producto = P1.prod_codigo
JOIN Factura F  ON F.fact_tipo = I1.item_tipo 
                AND F.fact_sucursal = I1.item_sucursal 
                AND F.fact_numero = I1.item_numero
JOIN Item_Factura I2 ON I2.item_tipo = F.fact_tipo 
                    AND I2.item_sucursal = F.fact_sucursal 
                    AND I2.item_numero = F.fact_numero
JOIN Producto P2 ON P2.prod_codigo = I2.item_producto
JOIN Familia F2 ON F2.fami_id = P2.prod_familia
WHERE F1.fami_id > F2.fami_id
GROUP BY F1.fami_id, F1.fami_detalle, F2.fami_id, F2.fami_detalle
HAVING COUNT(DISTINCT F.fact_numero+F.fact_sucursal+F.fact_tipo) > 10
ORDER BY [Total vendido] DESC;