/* Realizar una consulta que retorne para cada producto que posea composición nombre
del producto, precio del producto, precio de la sumatoria de los precios por la cantidad de los productos que lo componen. 
Solo se deberán mostrar los productos que estén
compuestos por más de 2 productos y deben ser ordenados de mayor a menor por
cantidad de productos que lo componen. */

SELECT  P.prod_detalle, P.prod_precio, 
        SUM(C.comp_cantidad * Co.prod_precio) AS precioTotal
FROM Producto P
JOIN Composicion C ON C.comp_producto = P.prod_codigo
JOIN Producto Co ON Co.prod_codigo = C.comp_componente
GROUP BY P.prod_detalle, P.prod_precio
HAVING SUM(C.comp_cantidad) > 2
ORDER BY SUM(C.comp_cantidad) DESC