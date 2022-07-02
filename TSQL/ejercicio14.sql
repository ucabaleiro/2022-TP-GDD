/* Agregar el/los objetos necesarios para que si un cliente compra un producto
compuesto a un precio menor que la suma de los precios de sus componentes
que imprima la fecha, que cliente, que productos y a qué precio se realizó la
compra. No se deberá permitir que dicho precio sea menor a la mitad de la suma
de los componentes. */

BEGIN TRANSACTION T
GO

CREATE TRIGGER controlPrecioCompuesto ON Item_Factura INSTEAD OF INSERT
AS
BEGIN
    --TODO
END
GO

ROLLBACK TRANSACTION T
GO