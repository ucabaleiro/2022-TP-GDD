/*31. Escriba una consulta sql que retorne una estadística por Año y Vendedor que retorne las
siguientes columnas:
- Año.
- Codigo de Vendedor
- Detalle del Vendedor
- Cantidad de facturas que realizó en ese año
- Cantidad de clientes a los cuales les vendió en ese año.
- Cantidad de productos facturados con composición en ese año
- Cantidad de productos facturados sin composicion en ese año.
- Monto total vendido por ese vendedor en ese año
Los datos deberan ser ordenados por año y dentro del año por el vendedor que haya
vendido mas productos diferentes de mayor a menor.*/

--SOLUCION MIA ERRADA POR ALGO
SELECT  YEAR(F.fact_fecha) AS [Año],
        E.empl_codigo,
        E.empl_nombre AS [Nombre],
        E.empl_apellido AS [Apellido],
        COUNT(DISTINCT F.fact_numero+F.fact_sucursal+F.fact_tipo) AS [Cantidad de facturas],
        COUNT(DISTINCT F.fact_cliente) AS [Cantidad de clientes],
        COUNT(DISTINCT I1.item_producto) AS [Cantidad de productos facturados con composición],
        COUNT(DISTINCT I2.item_producto) AS [Cantidad de productos facturados sin composición],
        SUM(DISTINCT F.fact_total) AS [Monto total vendido]
FROM Empleado E
JOIN Factura F ON F.fact_vendedor = E.empl_codigo
LEFT JOIN Item_Factura I1 ON I1.item_tipo = F.fact_tipo 
                    AND I1.item_sucursal = F.fact_sucursal 
                    AND I1.item_numero = F.fact_numero
                    AND I1.item_producto IN (SELECT comp_producto FROM Composicion)
LEFT JOIN Item_Factura I2 ON I2.item_tipo = F.fact_tipo
                    AND I2.item_sucursal = F.fact_sucursal
                    AND I2.item_numero = F.fact_numero
                    AND I2.item_producto NOT IN (SELECT comp_producto FROM Composicion)
GROUP BY YEAR(F.fact_fecha), E.empl_codigo, E.empl_nombre, E.empl_apellido
ORDER BY YEAR(F.fact_fecha), COUNT(DISTINCT I1.item_producto) + COUNT(DISTINCT I2.item_producto) DESC