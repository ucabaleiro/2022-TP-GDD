/* Hacer una función que dado un artículo y un deposito devuelva un string que
indique el estado del depósito según el artículo. Si la cantidad almacenada es
menor al límite retornar “OCUPACION DEL DEPOSITO XX %” siendo XX el
% de ocupación. Si la cantidad almacenada es mayor o igual al límite retornar
“DEPOSITO COMPLETO”. */

BEGIN TRANSACTION T
GO

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
GO

ROLLBACK TRANSACTION T
GO