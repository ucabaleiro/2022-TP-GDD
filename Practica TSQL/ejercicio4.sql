/* Cree el/los objetos de base de datos necesarios para actualizar la columna de
empleado empl_comision con la sumatoria del total de lo vendido por ese
empleado a lo largo del último año. Se deberá retornar el código del vendedor
que más vendió (en monto) a lo largo del último año. */

BEGIN TRANSACTION T
GO

create procedure actualizarComisiones
as 
begin
    declare @id_masVendido numeric(6)
    declare @id numeric(6), @vendido decimal(12,2);

    declare comisionesCursor cursor for
        select  empl_codigo,
                sum(F.fact_total) as total
        from Empleado
        join Factura F on F.fact_vendedor = empl_codigo
        where YEAR(F.fact_fecha) = YEAR(GETDATE()) - 1
        group by empl_codigo
    ;

    open comisionesCursor;
        fetch next from comisionesCursor
        into @id, @vendido;

        while @@fetch_status = 0
        begin
            update Empleado 
                set empl_comision = @vendido
            where empl_codigo = @id
            fetch next from comisionesCursor
            into @id, @vendido;
        end
    close comisionesCursor;
    deallocate comisionesCursor;

    select top 1 @id_masVendido = empl_codigo
    from Empleado
    order by empl_comision desc
end
GO

ROLLBACK TRANSACTION T
GO