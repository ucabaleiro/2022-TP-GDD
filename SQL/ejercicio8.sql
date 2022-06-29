/* Mostrar para el o los artículos que tengan stock en todos los depósitos, nombre del
artículo, stock del depósito que más stock tiene. */

SELECT P.prod_codigo, P.prod_detalle, MAX(S.stoc_cantidad) as stock
FROM Producto P
CROSS JOIN Deposito D
JOIN Stock S
    ON S.stoc_deposito = D.depo_codigo
    AND S.stoc_producto = P.prod_codigo
    AND S.stoc_cantidad > 0
GROUP BY P.prod_codigo, P.prod_detalle
HAVING COUNT(S.stoc_deposito) = (SELECT COUNT(*) FROM Deposito)
ORDER BY P.prod_codigo ASC