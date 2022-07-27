/* PARCIAL PRACTICO GESTION DE DATOS 02/07/2022 */
/*  
    CURSO: K3014 (Sabados Mañana)
    ALUMNO: PIATTI CASTRO, MARCO AUGUSTO
    LEGAJO: 175.645-0
    EMAIL: mpiatti@frba.utn.edu.ar
*/

-- Punto 1 SQL
/*
Realizar una consulta SQL que devuelva los clientes que NO tuvieron
la facturación máxima y la facturación mínima en el 2012. De estos
clientes mostrar:
    - El número de orden: asignado 1 al cliente de mayor venta y N al
      de menor venta. Entiéndase N como el número correspondiente
      al que menos vendió en el 2012. Entiéndase venta como total
      facturado.
    - El código de cliente
    - El monto total comprado en el 2012
    - La cantidad de unidades de productos compradas en el 2012

NOTA: No se permiten select en el from, es decir, select...from(select...) as T,...
*/

SELECT  ROW_NUMBER() OVER (ORDER BY SUM(F.fact_total) DESC) AS [Numero de orden],
        C.clie_codigo AS [Codigo de cliente],
        SUM(F.fact_total) AS [Monto total Comprado en 2012],
        (
            SELECT SUM(I.item_cantidad)
            FROM Cliente C1
            JOIN Factura F ON F.fact_cliente = C.clie_codigo
            JOIN Item_Factura I ON I.item_numero = F.fact_numero
                                AND I.item_sucursal = F.fact_sucursal
                                AND I.item_tipo = F.fact_tipo
            WHERE C1.clie_codigo = C.clie_codigo
        ) AS [Cantidad total de unidades de productos comprados en 2012]
FROM Cliente C
JOIN Factura F ON F.fact_cliente = C.clie_codigo
WHERE YEAR(F.fact_fecha) = 2012
GROUP BY C.clie_codigo
HAVING 
    SUM(F.fact_total) < (
    SELECT TOP 1
    SUM(fact_total) AS [Monto total de compra]
    FROM Cliente
    JOIN Factura ON clie_codigo = fact_cliente
    WHERE YEAR(fact_fecha) = 2012
    GROUP BY clie_codigo
    ORDER BY SUM(fact_total) DESC
    )
    AND 
    SUM(F.fact_total) > (
    SELECT TOP 1
    SUM(fact_total) AS [Monto total de compra]
    FROM Cliente
    JOIN Factura ON clie_codigo = fact_cliente
    WHERE YEAR(fact_fecha) = 2012
    GROUP BY clie_codigo
    ORDER BY SUM(fact_total) ASC
    )

-- Punto 2 TSQL
/*
Suponiendo que se aplican los siguientes cambios en el modelo de 
datos:
*/
CREATE TABLE Provincia (
    id int PRIMARY KEY,
    nombre char(100)
);

ALTER TABLE Cliente ADD pcia_id int NULL;
GO

/*
Crear el/los objetos necesarios para implementar el concepto de foreign
key entre 2 cliente y provincia.

NOTA: No se permite agregar una constraint de tipo FOREIGN KEY entre la
tabla y el campo agregado.
*/
CREATE TRIGGER controlFKClieProv ON Cliente AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE cursorClientes CURSOR FOR
    SELECT clie_codigo, pcia_id
    FROM inserted
    ;
    DECLARE @clienteID char(6), @provinciaID int;
    DECLARE @error BIT;
    OPEN cursorClientes;

    FETCH NEXT FROM cursorClientes INTO @clienteID, @provinciaID;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF (NOT EXISTS (SELECT * FROM Provincia WHERE id = @provinciaID))
        BEGIN
            PRINT 'No se puede insertar el cliente ' + @clienteID 
                + ' porque el campo pcia_id no es una referencia valida a la tabla Provincias';
            SET @error = 1;
        END
        FETCH NEXT FROM cursorClientes INTO @clienteID, @provinciaID;
    END
    CLOSE cursorClientes;
    DEALLOCATE cursorClientes;

    IF (@error = 1)
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO