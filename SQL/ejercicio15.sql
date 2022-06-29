/* Escriba una consulta que retorne los pares de productos que hayan sido vendidos juntos
(en la misma factura) más de 500 veces. El resultado debe mostrar el código y
descripción de cada uno de los productos y la cantidad de veces que fueron vendidos
juntos. El resultado debe estar ordenado por la cantidad de veces que se vendieron
juntos dichos productos. Los distintos pares no deben retornarse más de una vez.
Ejemplo de lo que retornaría la consulta:
PROD1 DETALLE1 PROD2 DETALLE2 VECES
1731 MARLBORO KS 1 7 1 8 P H ILIPS MORRIS KS 5 0 7
1718 PHILIPS MORRIS KS 1 7 0 5 P H I L I P S MORRIS BOX 10 5 6 2 */

SELECT  P1.prod_codigo, P1.prod_detalle, P2.prod_codigo, P2.prod_detalle,
        COUNT(*) as FacturasCompartidas
FROM Producto P1
JOIN Item_Factura I1 ON P1.prod_codigo = I1.item_producto
JOIN Factura F  ON  F.fact_numero = I1.item_numero 
                AND F.fact_sucursal = I1.item_sucursal
                AND F.fact_tipo = I1.item_tipo
JOIN Item_Factura I2 ON  F.fact_numero = I2.item_numero 
                AND F.fact_sucursal = I2.item_sucursal
                AND F.fact_tipo = I2.item_tipo
JOIN Producto P2 ON I2.item_producto = P2.prod_codigo
WHERE P1.prod_codigo > P2.prod_codigo
GROUP BY P1.prod_codigo, P1.prod_detalle, P2.prod_codigo, P2.prod_detalle
HAVING COUNT(*) > 500
ORDER BY COUNT(*) ASC