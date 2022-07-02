/* Desarrolle el/los elementos de base de datos necesarios para que ante una venta
automaticamante se descuenten del stock los articulos vendidos. Se descontaran
del deposito que mas producto poseea y se supone que el stock se almacena
tanto de productos simples como compuestos (si se acaba el stock de los
compuestos no se arman combos)
En caso que no alcance el stock de un deposito se descontara del siguiente y asi
hasta agotar los depositos posibles. En ultima instancia se dejara stock negativo
en el ultimo deposito que se desconto. */

BEGIN TRANSACTION T
GO

CREATE TRIGGER actualizarStock ON Item_Factura AFTER INSERT
AS
BEGIN
    DECLARE cursorItem CURSOR FOR 
        SELECT I.item_producto, I.item_cantidad
        FROM inserted I
    ;
    DECLARE @articuloID char(8), @cantidadPorQuitar decimal(12,2);
    OPEN cursorStock;
    
    FETCH NEXT FROM cursorItem INTO @articuloID, @cantidadPorQuitar;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        DECLARE cursorStock CURSOR FOR
            SELECT S.stoc_deposito, S.stoc_cantidad
            FROM Stock S
            WHERE S.stoc_producto = @articuloID
            ORDER BY S.stoc_cantidad DESC
        ;
        DECLARE @depositoID char(2), @stockDeposito decimal(12,2);
        OPEN cursorStock;
        
        FETCH NEXT FROM cursorStock INTO @depositoID, @stockDeposito;
        WHILE @@FETCH_STATUS = 0 AND @cantidadPorQuitar > 0
        BEGIN
            
            IF @stockDeposito >= @cantidadPorQuitar
            BEGIN
                UPDATE Stock
                SET stoc_cantidad = @stockDeposito - @cantidadPorQuitar
                WHERE stoc_producto = @articuloID AND stoc_deposito = @depositoID
                SET @cantidadPorQuitar = 0.00;
            END
            ELSE
            BEGIN
                UPDATE Stock
                SET stoc_cantidad = 0.00
                WHERE stoc_producto = @articuloID AND stoc_deposito = @depositoID
                SET @cantidadPorQuitar = @cantidadPorQuitar - @stockDeposito;
            END
            FETCH NEXT FROM cursorStock INTO @depositoID, @stockDeposito;
        END

        IF(@cantidadPorQuitar > 0)
        BEGIN
            FETCH PREVIOUS FROM cursorStock INTO @depositoID, @stockDeposito;
            UPDATE Stock
            SET stoc_cantidad = @stockDeposito - @cantidadPorQuitar
            WHERE stoc_producto = @articuloID AND stoc_deposito = @depositoID
            SET @cantidadPorQuitar = 0.00;
        END
        
        CLOSE cursorStock;
        DEALLOCATE cursorStock;
        FETCH NEXT FROM cursorItem INTO @articuloID, @cantidadPorQuitar;
    END
    
    CLOSE cursorItem;
    DEALLOCATE cursorItem;
END
GO

ROLLBACK TRANSACTION T
GO