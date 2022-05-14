create function limiteDeposito(@prodId char(8), @depositoId char(2))
returns char(27)
as
begin
    declare @limite decimal(12,2),
            @stock decimal(12,2),    
            @resultado char(27)
    
    select  @stock = stoc_cantidad,
            @limite = stoc_stock_maximo
    from    stock
    where   stoc_producto = @prodId and stoc_deposito = @depositoId

    if (@limite >= @stock) set @resultado = 'DEPOSITO COMPLETO'
    else set @resultado = 'OCUPACION DEL DEPOSITO ' + convert(char(2), @stock * 100 / @limite) + ' %'

    return @resultado
end