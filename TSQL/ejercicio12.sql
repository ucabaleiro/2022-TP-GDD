/* Cree el/los objetos de base de datos necesarios para que nunca un producto
pueda ser compuesto por sí mismo. Se sabe que en la actualidad dicha regla se
cumple y que la base de datos es accedida por n aplicaciones de diferentes tipos
y tecnologías. No se conoce la cantidad de niveles de composición existentes. */

BEGIN TRANSACTION T
GO

CREATE TRIGGER controlComposicion ON Composicion INSTEAD OF INSERT, UPDATE
AS
BEGIN
    
END
GO

ROLLBACK TRANSACTION T
GO