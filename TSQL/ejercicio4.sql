create procedure actualizarComisiones
as 
begin
    declare comisionesCursor cursor for
        select  empl_codigo,
                sum(vendidoDeAlgunaManera) as total
        from Empleado
        group by empl_codigo
    ;

    open comisionesCursor
        fetch next from comisionesCursor
        into @id, @vendido

        while @@fetch_status = 0
        begin
            update Empleado 
                set empl_comision = @vendido
            where empl_codigo = @id
        end
    close comisionesCursor;
    deallocate comisionesCursor;
end