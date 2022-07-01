/* Cree el/los objetos de base de datos necesarios para corregir la tabla empleado
en caso que sea necesario. Se sabe que debería existir un único gerente general
(debería ser el único empleado sin jefe). Si detecta que hay más de un empleado
sin jefe deberá elegir entre ellos el gerente general, el cual será seleccionado por
mayor salario. Si hay más de uno se seleccionara el de mayor antigüedad en la
empresa. Al finalizar la ejecución del objeto la tabla deberá cumplir con la regla
de un único empleado sin jefe (el gerente general) y deberá retornar la cantidad
de empleados que había sin jefe antes de la ejecución. */

BEGIN TRANSACTION T
GO

create procedure agregarJefe
as
begin
    declare @id_jefe integer
    declare @cantidadSinJefe integer

    select top 1
        @id_jefe = empl_codigo
    from Empleado 
    where empl_jefe is null
    order by empl_salario desc, empl_ingreso asc

    update Empleado 
        set empl_jefe = @id_jefe
    where empl_jefe is null and empl_codigo != @id_jefe

    set @cantidadSinJefe = @@rowcount + 1
end
GO

ROLLBACK TRANSACTION T
GO