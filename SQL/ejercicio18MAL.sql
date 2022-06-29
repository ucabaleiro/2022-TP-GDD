/* Escriba una consulta que retorne una estadística de ventas para todos los rubros.
La consulta debe retornar:
DETALLE_RUBRO: Detalle del rubro
VENTAS: Suma de las ventas en pesos de productos vendidos de dicho rubro
PROD1: Código del producto más vendido de dicho rubro
PROD2: Código del segundo producto más vendido de dicho rubro
CLIENTE: Código del cliente que compro más productos del rubro en los últimos 30
días
La consulta no puede mostrar NULL en ninguna de sus columnas y debe estar ordenada
por cantidad de productos diferentes vendidos del rubro. */

SELECT  R.rubr_detalle AS DETALLE_RUBRO,
        SUM(I.item_cantidad * I.item_precio) OVER
        (PARTITION BY R.rubr_detalle) AS VENTAS
FROM Rubro R
JOIN Producto P ON R.rubr_id = P.prod_rubro
JOIN Item_Factura I ON P.prod_codigo = I.item_producto