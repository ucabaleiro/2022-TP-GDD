/* Generar una consulta que muestre para cada artículo código, detalle, mayor precio
menor precio y % de la diferencia de precios (respecto del menor Ej.: menor precio =
10, mayor precio =12 => mostrar 20 %). Mostrar solo aquellos artículos que posean
stock. */

SELECT  P.prod_codigo, P.prod_detalle,
        MAX(I.item_precio) as Maximo,
        MIN(I.item_precio) as Minimo,
        CONCAT(
            CONVERT( decimal(10,2),
                    ((MAX(I.item_precio) - MIN(I.item_precio)) / MIN(I.item_precio) * 100)
            ),
            '%'
        ) as Porcentaje
FROM Producto P
JOIN Item_Factura I ON I.item_producto = P.prod_codigo
JOIN Stock S ON S.stoc_producto = P.prod_codigo
WHERE S.stoc_cantidad > 0
GROUP BY P.prod_codigo, P.prod_detalle