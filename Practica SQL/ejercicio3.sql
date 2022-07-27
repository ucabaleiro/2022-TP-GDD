/* Realizar una consulta que muestre código de producto, nombre de producto y el stock
total, sin importar en que deposito se encuentre, los datos deben ser ordenados por
nombre del artículo de menor a mayor. */

SELECT P.prod_codigo, P.prod_detalle, ISNULL(SUM(S.stoc_cantidad),0) as stock
FROM Producto P
LEFT JOIN Stock S
    ON S.stoc_producto = P.prod_codigo
GROUP BY P.prod_codigo, P.prod_detalle
ORDER BY P.prod_detalle ASC;

/*
Notas. Hay articulos que no existen en la tabla de stock, por lo cual
se hace LEFT JOIN y a las referencias NULLS se las convierte a 0 para tener
la cantidad total. 
*/