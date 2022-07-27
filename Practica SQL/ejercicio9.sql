/* Mostrar el código del jefe, código del empleado que lo tiene como jefe, nombre del
mismo y la cantidad de depósitos que ambos tienen asignados. */

SELECT  E.empl_jefe, E.empl_codigo, E.empl_nombre, 
        COUNT(DISTINCT DE.depo_codigo) as deposEmpleado,
        COUNT(DISTINCT DJ.depo_codigo) as deposJefe
FROM Empleado E
LEFT JOIN Deposito DE ON DE.depo_encargado = E.empl_codigo
LEFT JOIN Deposito DJ ON DJ.depo_encargado = E.empl_jefe
GROUP BY E.empl_jefe, E.empl_codigo, E.empl_nombre