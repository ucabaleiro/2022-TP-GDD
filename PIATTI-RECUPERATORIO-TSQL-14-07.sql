/*
RECUPERATORIO TSQL 14-07-2022

K3014

PIATTI CASTRO, MARCO AUGUSTO
LEG: 175.645-0
*/

-- Envuelvo todo en una transaction rolleada para evitar molestias en caso de modificaciones durante el parcial
-- Esta transaction se puede borrar, no es parte de la resolución
BEGIN TRANSACTION T
GO

CREATE PROCEDURE pr_parcial(@descripcion char(50))
AS
BEGIN
    -- extraigo la primer y segunda palabra
    DECLARE @primerPalabra nvarchar(50), @segundaPalabra nvarchar(50);
    DECLARE @primerEspacio int, @segundoEspacio int;
    SET @primerEspacio = CHARINDEX(' ', @descripcion, 1);
    SET @segundoEspacio = CHARINDEX(' ', @descripcion, @primerEspacio+1);
    IF(@segundoEspacio = 0)
    BEGIN
        SET @segundoEspacio = LEN(@descripcion) - 1;
    END
    SET @primerPalabra = SUBSTRING(@descripcion, 1, @primerEspacio);
    SET @segundaPalabra = SUBSTRING(@descripcion, @primerEspacio+1, @segundoEspacio-@primerEspacio);

    -- cursor con las familias y su cantidad de ocurrencias en las descripciones
    DECLARE @familiaID char(3), @familiaDetalle char(50), @cantidad int;
    
    DECLARE cursorFamilias CURSOR FOR
        SELECT  F.fami_id as idFamilia, 
                F.fami_detalle as detalleFamilia, 
                COUNT(*) as cantidadOcurrencias
        FROM Producto P
        JOIN Familia F ON P.prod_familia = F.fami_id
        WHERE   CHARINDEX(UPPER(@primerPalabra), UPPER(P.prod_detalle), 1) > 0
            OR  CHARINDEX(UPPER(@segundaPalabra), UPPER(P.prod_detalle), 1) > 0 
        GROUP BY F.fami_id, F.fami_detalle
        ORDER BY COUNT(*) DESC
    ;

    DECLARE @habiaFamilias BIT, @habiaMasDeUnaFamilia BIT;
    SET @habiaFamilias = 0;
    SET @habiaMasDeUnaFamilia = 0;

    DECLARE @familiaIDMAX char(3), @familiaDetalleMAX char(50), @cantidadMax int;
    OPEN cursorFamilias;
        FETCH NEXT FROM cursorFamilias INTO @familiaID, @familiaDetalle, @cantidad;
        IF @@FETCH_STATUS = 0
        BEGIN
            SET @familiaIDMAX = @familiaID;
            SET @familiaDetalleMAX = @familiaDetalle;
            SET @cantidadMax = @cantidad;
        END

        WHILE (@@FETCH_STATUS = 0 AND @cantidadMax = @cantidad) 
        BEGIN
            IF(@habiaFamilias = 1)
            BEGIN
                SET @habiaMasDeUnaFamilia = 1;
            END
            ELSE
            BEGIN
                SET @habiaFamilias = 1;
            END
            FETCH NEXT FROM cursorFamilias INTO @familiaID, @familiaDetalle, @cantidad;
        END
    CLOSE cursorFamilias;
    DEALLOCATE cursorFamilias;

    IF(@habiaFamilias = 0 OR @habiaMasDeUnaFamilia = 1)
    BEGIN
        PRINT 'NO SUGIERE NINGUNA FAMILIA';
    END
    ELSE
    BEGIN
        PRINT 'FAMILIA: ' + @familiaDetalleMAX + ' - CODIGO: ' + @familiaIDMAX;
    END
END
GO

-- esto retorna correctamente "FAMILIA: ALCALINAS - CODIGO: 103"
EXEC pr_parcial @descripcion = 'Pilas A23';
GO

-- esto retorna correctamente "NO SUGIERE NINGUNA FAMILIA"
EXEC pr_parcial @descripcion = 'Piatti GestionDeDatos';
GO

ROLLBACK TRANSACTION T
GO