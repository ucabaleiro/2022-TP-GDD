BEGIN TRANSACTION T
GO 

CREATE TRIGGER controlStockProducto ON Producto INSTEAD OF DELETE
AS
BEGIN
    IF (SELECT SUM(stoc_cantidad) FROM Stock JOIN deleted ON stoc_producto = prod_codigo) > 0
    BEGIN
        PRINT 'No se puede eliminar el producto porque tiene stock';
        ROLLBACK TRANSACTION;
        RETURN;
    END
    ELSE
    BEGIN
        DELETE FROM Producto WHERE prod_codigo IN (SELECT prod_codigo FROM deleted)
    END
END
GO

ROLLBACK TRANSACTION T
GO