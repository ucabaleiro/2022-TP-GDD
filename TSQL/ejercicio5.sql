create procedure completarFacts
as
begin
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
end