/* Realizar un procedimiento que complete con los datos existentes en el modelo
provisto la tabla de hechos denominada Fact_table tiene las siguiente definición: */

BEGIN TRANSACTION T
GO 

create table Fact_table
(
    anio char(4),
    mes char(2),
    familia char(3),
    rubro char(4),
    zona char(3),
    cliente char(6),
    producto char(8),
    cantidad decimal(12,2),
    monto  decimal(12,2)
)
alter table Fact_table
add constraint PK_Fact primary key(anio, mes, familia, rubro, zona, cliente, producto)
GO

create procedure completarFacts
as
begin
    INSERT INTO Fact_table
	SELECT YEAR(fact_fecha)
		,RIGHT('0' + convert(varchar(2),MONTH(fact_fecha)),2)
		,prod_familia
		,prod_rubro
		,depa_zona
		,fact_cliente
		,prod_codigo
		,SUM(item_cantidad)
		,sum(item_precio)
	FROM Factura F
		INNER JOIN Item_Factura IFACT
			ON IFACT.item_tipo =f.fact_tipo AND IFACT.item_sucursal = F.fact_sucursal AND IFACT.item_numero = F.fact_numero
		INNER JOIN Producto P
			ON P.prod_codigo = IFACT.item_producto
		INNER JOIN Empleado E
			ON E.empl_codigo = F.fact_vendedor
		INNER JOIN Departamento D
			ON D.depa_codigo = E.empl_departamento
	GROUP BY YEAR(fact_fecha)
		,RIGHT('0' + convert(varchar(2),MONTH(fact_fecha)),2)
		,prod_familia
		,prod_rubro
		,depa_zona
		,fact_cliente
		,prod_codigo
end
GO

ROLLBACK TRANSACTION T
GO