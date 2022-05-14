create procedure agregarJefe
as
begin
    declare @id_jefe integer
    declare @cantidadSinJefe integer

    select top 1
        @id_jefe = empl_id
    from Empleado e where empl_ingreso = ( select top 1
                                                empl_ingreso 
                                            from Empleado e where empl_jefe is null
                                            order by empl_ingreso desc )
    order by empl_antiguedad desc

    update Empleado 
        set empl_jefe = @jefe
    where empl_jefe is null and empl_codigo != @id_jefe

    set @cantidadSinJefe = @@rowcount + 1
end