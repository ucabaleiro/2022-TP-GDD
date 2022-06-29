/* Realizar una consulta que muestre para todos los artículos código, detalle y cantidad de
artículos que lo componen. Mostrar solo aquellos artículos para los cuales el stock
promedio por depósito sea mayor a 100. */

SELECT  P.prod_codigo, P.prod_detalle, 
        ISNULL(SUM(C.comp_cantidad),0) as cant_comp, 
        AVG(ISNULL(S.stoc_cantidad,0)) as stock_promedio_dep
FROM Producto P
LEFT JOIN Composicion C ON C.comp_producto = P.prod_codigo
CROSS JOIN Deposito D
LEFT JOIN Stock S 
    ON S.stoc_producto = P.prod_codigo
    AND S.stoc_deposito = D.depo_codigo
GROUP BY P.prod_codigo, P.prod_detalle
HAVING AVG(ISNULL(S.stoc_cantidad,0)) > 100

/* 
Notas. Hay articulos que no tienen composiciones, por lo cual la cantidad es 0.
Esto se hace con el LEFT JOIN para dar la composicion NULL en los productos que no tengan
y el ISNULL en caso de que algun producto no tenga FK a una composicion se toma 0.

Hay depositos que no tienen articulos, y articulos que no estan en todos los depositos.
Para considerar esto en el promedio, y no solo promediar entre los que si existen erroneamente
Se toman todos los posibles pares Producto - Deposito con CROSS JOIN
Luego con un LEFT JOIN a Stock nos da el stock de cada par, pero tambien da NULL en los pares
que no existen en la tabla de stock, a estos NULLS se los convierte a 0 para tener un promedio correcto.
*/