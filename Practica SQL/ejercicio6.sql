/* Mostrar para todos los rubros de artículos código, detalle, cantidad de artículos de ese
rubro y stock total de ese rubro de artículos. Solo tener en cuenta aquellos artículos que
tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’. */

SELECT  R.rubr_id, R.rubr_detalle,
        COUNT(DISTINCT ISNULL(P.prod_codigo,0)) as cantidad, 
        SUM(ISNULL(S.stoc_cantidad,0)) as stock
FROM Rubro R
LEFT JOIN Producto P ON P.prod_rubro = R.rubr_id
LEFT JOIN Stock S ON S.stoc_producto = P.prod_codigo
WHERE S.stoc_deposito > (
        SELECT S2.stoc_deposito
        FROM Stock S2
        WHERE S2.stoc_producto = '00000000'
        AND S2.stoc_deposito = '00'
        )
GROUP BY R.rubr_id, R.rubr_detalle
ORDER BY R.rubr_id ASC

-- NOTA Rubro podria no tener productos, y productos
-- podrian no estar en stock, por ende left join y isnull