USE [GD1C2022]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* Comienzo Drops de las tablas */
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telemetria_Auto]') AND type in (N'U'))
DROP TABLE [dbo].[Telemetria_Auto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Parada_Box]') AND type in (N'U'))
DROP TABLE [dbo].[Parada_Box]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Incidente]') AND type in (N'U'))
DROP TABLE [dbo].[Incidente]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Carrera]') AND type in (N'U'))
DROP TABLE [dbo].[Carrera]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sector]') AND type in (N'U'))
DROP TABLE [dbo].[Sector]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Circuito]') AND type in (N'U'))
DROP TABLE [dbo].[Circuito]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Piloto]') AND type in (N'U'))
DROP TABLE [dbo].[Piloto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Auto]') AND type in (N'U'))
DROP TABLE [dbo].[Auto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Escuderia]') AND type in (N'U'))
DROP TABLE [dbo].[Escuderia]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telemetria_Neumatico]') AND type in (N'U'))
DROP TABLE [dbo].[Telemetria_Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cambio_Neumatico]') AND type in (N'U'))
DROP TABLE [dbo].[Cambio_Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Neumatico]') AND type in (N'U'))
DROP TABLE [dbo].[Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telemetria_Motor]') AND type in (N'U'))
DROP TABLE [dbo].[Telemetria_Motor]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Motor]') AND type in (N'U'))
DROP TABLE [dbo].[Motor]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telemetria_Freno]') AND type in (N'U'))
DROP TABLE [dbo].[Telemetria_Freno]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Freno]') AND type in (N'U'))
DROP TABLE [dbo].[Freno]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telemetria_Caja]') AND type in (N'U'))
DROP TABLE [dbo].[Telemetria_Caja]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Caja]') AND type in (N'U'))
DROP TABLE [dbo].[Caja]
GO
/* Fin Drops de las tablas */

/*Comienzo Creates de las tablas*/
CREATE TABLE [dbo].[Carrera] (
    [codigo_carrera] int NOT NULL PRIMARY KEY,
    [fecha_carrera] date NOT NULL,
    [clima_carrera] nvarchar(100) NOT NULL,
    [total_carrera] decimal(18,2) NOT NULL,
    [cantidad_vueltas_carrera] int NOT NULL
)
GO

CREATE TABLE [dbo].[Circuito] (
    [codigo_circuito] int NOT NULL PRIMARY KEY,
    [nombre_circuito] nvarchar(255) NOT NULL,
    [pais_circuito] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [dbo].[Sector] (
    [codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Circuito] ([codigo_circuito]),
	[codigo_sector] int NOT NULL,
    [distancia_sector] decimal(18,2) NOT NULL,
    [tipo_sector] nvarchar(255) NOT NULL,
    CONSTRAINT PK_SECTOR PRIMARY KEY (codigo_circuito, codigo_sector)
)
GO

CREATE TABLE [dbo].[Escuderia] (
    [codigo_escuderia] int NOT NULL IDENTITY PRIMARY KEY,
    [nombre_escuderia] nvarchar(255) NOT NULL,
    [nacionalidad_escuderia] nvarchar(255) NOT NULL,
)
GO

CREATE TABLE [dbo].[Auto] (
    [codigo_auto] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_escuderia] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Escuderia] ([codigo_escuderia]),
    [modelo_auto] nvarchar(255) NOT NULL,
    [numero_auto] int NOT NULL
)
GO

CREATE TABLE [dbo].[Incidente] (
    [codigo_incidente] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_sector] int NOT NULL,
	[codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Circuito] ([codigo_circuito]),
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto],
    [bandera_incidente] nvarchar(255) NOT NULL,
    [tipo_incidente] nvarchar(255) NOT NULL,
    [tiempo_incidente] decimal(18,2) NOT NULL,
    [numero_vuelta] decimal(18,0) NOT NULL,
	CONSTRAINT FK_INCIDENTE_A_SECTOR FOREIGN KEY([codigo_circuito],[codigo_sector]) REFERENCES [dbo].[Sector]([codigo_circuito],[codigo_sector]),
)
GO

CREATE TABLE [dbo].[Piloto] (
    [codigo_piloto] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto] ([codigo_auto]),
    [nombre_piloto] nvarchar(50) NOT NULL,
    [apellido_piloto] nvarchar(50) NOT NULL,
    [nacionalidad_piloto] nvarchar(50) NOT NULL,
    [nacimiento_piloto] date NOT NULL
)
GO

CREATE TABLE [dbo].[Neumatico] (
    [num_serie_neumatico] nvarchar(255) NOT NULL PRIMARY KEY,
    [modelo_neumatico] nvarchar(255)
)
GO

CREATE TABLE [dbo].[Telemetria_Neumatico] (
    [codigo_telemetria_neumatico] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_neumatico] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [posicion_neumatico] nvarchar(255) NOT NULL,
    [profundidad_neumatico] decimal(18,6) NOT NULL,
    [temperatura_neumatico] decimal(18,6) NOT NULL,
    [presion_neumatico] decimal(18,6) NOT NULL,
)
GO

CREATE TABLE [dbo].[Cambio_Neumatico] (
    [codigo_cambio_neumatico] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_viejo] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_nuevo] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [posicion] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [dbo].[Parada_Box] (
    [codigo_parada_box] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto] ([codigo_auto]),
    [codigo_cambio_neumatico1] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_cambio_neumatico2] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_cambio_neumatico3] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_cambio_neumatico4] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_carrera] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Carrera] ([codigo_carrera]),
    [numero_vuelta_box] decimal(18,0) NOT NULL,
    [tiempo_parada_box] decimal(18,2) NOT NULL
)
GO

CREATE TABLE [dbo].[Motor] (
    [num_serie_motor] nvarchar(255) NOT NULL PRIMARY KEY,
    [modelo_motor] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Motor] (
    [codigo_telemetria_motor] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_motor] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [dbo].[Motor] ([num_serie_motor]),
    [potencia_motor] decimal(18,6) NOT NULL,
    [rpm_motor] decimal(18,6) NOT NULL,
    [temp_aceite_motor] decimal(18,6) NOT NULL,
    [temp_agua_motor] decimal(18,6) NOT NULL
)
GO

CREATE TABLE [dbo].[Freno] (
    [num_serie_freno] nvarchar(255) NOT NULL PRIMARY KEY,
    [tamanio_disco_freno] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Freno] (
    [codigo_telemetria_freno] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_freno] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [dbo].[Freno] ([num_serie_freno]),
    [grosor_pastilla] decimal(18,2) NOT NULL,
    [posicion_freno] nvarchar(255) NOT NULL,
    [temperatura_freno] decimal(18,2) NOT NULL
)
GO

CREATE TABLE [dbo].[Caja] (
    [num_serie_caja] nvarchar(255) NOT NULL PRIMARY KEY,
    [modelo_caja] nvarchar(50) NOT NULL,
)

CREATE TABLE [dbo].[Telemetria_Caja] (
    [codigo_telemetria_caja] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_caja] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [dbo].[Caja] ([num_serie_caja]),
    [temp_aceite_caja] decimal(18,2) NOT NULL,
    [rpm_caja] decimal(18,2) NOT NULL,
    [desgaste_caja] decimal(18,2) NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Auto] (
    [codigo_telemetria_auto] decimal(18,0) NOT NULL PRIMARY KEY,
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto] ([codigo_auto]),
    [codigo_carrera] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Carrera] ([codigo_carrera]),
    [codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Circuito] ([codigo_circuito]),
	[codigo_sector] int NOT NULL,
    [codigo_telemetria_caja] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Caja] ([codigo_telemetria_caja]),
    [codigo_telemetria_motor] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Motor] ([codigo_telemetria_motor]),
    [codigo_tele_freno1] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno2] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno3] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno4] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_neumatico1] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico2] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico3] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico4] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [num_vuelta_auto] decimal(18,0) NOT NULL,
    [distancia_vuelta_auto] decimal(18,2) NOT NULL,
    [distancia_carrera_auto] decimal(18,6) NOT NULL,
    [posicion_auto] decimal(18,0) NOT NULL,
    [tiempo_vuelta_auto] decimal(18,10) NOT NULL,
    [velocidad_auto] decimal(18,2) NOT NULL,
    [combustible_auto] decimal(18,2) NOT NULL,
	CONSTRAINT FK_TELE_AUTO_A_SECTOR FOREIGN KEY([codigo_circuito],[codigo_sector]) REFERENCES [dbo].[Sector]([codigo_circuito],[codigo_sector]),
)
GO
/* FIN CREACION TABLAS */




















/* COMIENZO CARGA DE DATOS */

-- Motor
INSERT INTO [dbo].[Motor] ([num_serie_motor], [modelo_motor])
SELECT DISTINCT TELE_MOTOR_NRO_SERIE, TELE_MOTOR_MODELO
FROM [gd_esquema].[Maestra]
WHERE   TELE_MOTOR_NRO_SERIE IS NOT NULL 
    AND TELE_MOTOR_MODELO IS NOT NULL
GO

-- Telemetria Motor
INSERT INTO [dbo].[Telemetria_Motor]
(
    [num_serie_motor],
    [potencia_motor],
    [rpm_motor],
    [temp_aceite_motor],
    [temp_agua_motor]
)
SELECT  distinct TELE_MOTOR_NRO_SERIE, 
        TELE_MOTOR_POTENCIA, 
        TELE_MOTOR_RPM, 
        TELE_MOTOR_TEMP_ACEITE, 
        TELE_MOTOR_TEMP_AGUA
FROM [gd_esquema].[Maestra]
WHERE   TELE_MOTOR_NRO_SERIE IS NOT NULL 
    AND TELE_MOTOR_POTENCIA IS NOT NULL
    AND TELE_MOTOR_RPM IS NOT NULL
    AND TELE_MOTOR_TEMP_ACEITE IS NOT NULL
    AND TELE_MOTOR_TEMP_AGUA IS NOT NULL
GO

-- Caja
INSERT INTO [dbo].[Caja] ([num_serie_caja], [modelo_caja])
SELECT DISTINCT TELE_CAJA_NRO_SERIE, TELE_CAJA_MODELO
FROM [gd_esquema].[Maestra]
WHERE
    TELE_CAJA_MODELO IS NOT NULL AND 
    TELE_CAJA_MODELO IS NOT NULL
GO

-- Telemetria Caja 
INSERT INTO [dbo].[Telemetria_Caja] (num_serie_caja, temp_aceite_caja, rpm_caja, desgaste_caja)
SELECT DISTINCT TELE_CAJA_NRO_SERIE, TELE_CAJA_TEMP_ACEITE, TELE_CAJA_RPM, TELE_CAJA_DESGASTE
FROM [gd_esquema].[Maestra]
WHERE
    TELE_CAJA_NRO_SERIE IS NOT NULL AND
    TELE_CAJA_TEMP_ACEITE IS NOT NULL AND 
    TELE_CAJA_RPM IS NOT NULL AND 
    TELE_CAJA_DESGASTE IS NOT NULL
GO

-- Neumatico
insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO1_NRO_SERIE_VIEJO, NEUMATICO1_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO1_NRO_SERIE_VIEJO is not null and NEUMATICO1_NRO_SERIE_VIEJO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO2_NRO_SERIE_VIEJO, NEUMATICO2_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO2_NRO_SERIE_VIEJO is not null and NEUMATICO2_NRO_SERIE_VIEJO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO3_NRO_SERIE_VIEJO, NEUMATICO3_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO3_NRO_SERIE_VIEJO is not null and NEUMATICO3_NRO_SERIE_VIEJO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO4_NRO_SERIE_VIEJO, NEUMATICO4_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO4_NRO_SERIE_VIEJO is not null and NEUMATICO4_NRO_SERIE_VIEJO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO1_NRO_SERIE_NUEVO, NEUMATICO1_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO1_NRO_SERIE_NUEVO is not null and NEUMATICO1_NRO_SERIE_NUEVO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO2_NRO_SERIE_NUEVO, NEUMATICO2_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO2_NRO_SERIE_NUEVO is not null and NEUMATICO2_NRO_SERIE_NUEVO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO3_NRO_SERIE_NUEVO, NEUMATICO3_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO3_NRO_SERIE_NUEVO is not null and NEUMATICO3_NRO_SERIE_NUEVO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct NEUMATICO4_NRO_SERIE_NUEVO, NEUMATICO4_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO4_NRO_SERIE_NUEVO is not null and NEUMATICO4_NRO_SERIE_NUEVO not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct TELE_NEUMATICO1_NRO_SERIE, null
	from gd_esquema.Maestra
	where TELE_NEUMATICO1_NRO_SERIE is not null and TELE_NEUMATICO1_NRO_SERIE not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct TELE_NEUMATICO2_NRO_SERIE, null
	from gd_esquema.Maestra
	where TELE_NEUMATICO2_NRO_SERIE is not null and TELE_NEUMATICO2_NRO_SERIE not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct TELE_NEUMATICO3_NRO_SERIE, null
	from gd_esquema.Maestra
	where TELE_NEUMATICO3_NRO_SERIE is not null and TELE_NEUMATICO3_NRO_SERIE not in (select num_serie_neumatico from dbo.Neumatico) )

insert into dbo.Neumatico ([num_serie_neumatico], [modelo_neumatico])
(	select distinct TELE_NEUMATICO4_NRO_SERIE, null
	from gd_esquema.Maestra
	where TELE_NEUMATICO4_NRO_SERIE is not null and TELE_NEUMATICO4_NRO_SERIE not in (select num_serie_neumatico from dbo.Neumatico) )

-- Telemetria Neumatico

insert into [dbo].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO1_NRO_SERIE, TELE_NEUMATICO1_POSICION, TELE_NEUMATICO1_PROFUNDIDAD, TELE_NEUMATICO1_TEMPERATURA, TELE_NEUMATICO1_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO1_NRO_SERIE is not null

insert into [dbo].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO2_NRO_SERIE, TELE_NEUMATICO2_POSICION, TELE_NEUMATICO2_PROFUNDIDAD, TELE_NEUMATICO2_TEMPERATURA, TELE_NEUMATICO2_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO2_NRO_SERIE is not null

insert into [dbo].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO3_NRO_SERIE, TELE_NEUMATICO3_POSICION, TELE_NEUMATICO3_PROFUNDIDAD, TELE_NEUMATICO3_TEMPERATURA, TELE_NEUMATICO3_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO3_NRO_SERIE is not null

insert into [dbo].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO4_NRO_SERIE, TELE_NEUMATICO4_POSICION, TELE_NEUMATICO4_PROFUNDIDAD, TELE_NEUMATICO4_TEMPERATURA, TELE_NEUMATICO4_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO4_NRO_SERIE is not null

-- Escuderia
INSERT INTO [dbo].[Escuderia] ([nombre_escuderia], [nacionalidad_escuderia])
SELECT DISTINCT ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD
FROM [gd_esquema].[Maestra]
WHERE   ESCUDERIA_NOMBRE IS NOT NULL 
    AND ESCUDERIA_NACIONALIDAD IS NOT NULL
GROUP BY ESCUDERIA_NOMBRE, 
        ESCUDERIA_NACIONALIDAD
GO

-- Auto
INSERT INTO [dbo].[Auto] ([codigo_escuderia], [modelo_auto], [numero_auto])
SELECT DISTINCT E.codigo_escuderia, AUTO_MODELO, AUTO_NUMERO
FROM gd_esquema.Maestra LEFT JOIN dbo.Escuderia E ON
E.nacionalidad_escuderia = ESCUDERIA_NACIONALIDAD AND E.nombre_escuderia = ESCUDERIA_NOMBRE
WHERE AUTO_MODELO IS NOT NULL AND AUTO_NUMERO IS NOT NULL
GO

-- Piloto
INSERT INTO [dbo].[Piloto] 
(
    [codigo_auto],
    [nombre_piloto],
    [apellido_piloto],
    [nacionalidad_piloto],
    [nacimiento_piloto]
)
SELECT DISTINCT
    A.codigo_auto,
    PILOTO_NOMBRE,
    PILOTO_APELLIDO,
    PILOTO_NACIONALIDAD,
    PILOTO_FECHA_NACIMIENTO
FROM gd_esquema.Maestra LEFT JOIN dbo.Auto A ON
    A.modelo_auto = AUTO_MODELO AND A.numero_auto = AUTO_NUMERO
WHERE PILOTO_NOMBRE IS NOT NULL 
AND PILOTO_APELLIDO IS NOT NULL
AND PILOTO_NACIONALIDAD IS NOT NULL
AND PILOTO_FECHA_NACIMIENTO IS NOT NULL
GO

-- Circuito
INSERT INTO [dbo].[Circuito] ([codigo_circuito], [nombre_circuito], [pais_circuito])
SELECT DISTINCT CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS
FROM [gd_esquema].[Maestra]
WHERE
	CIRCUITO_CODIGO IS NOT NULL AND
    CIRCUITO_NOMBRE IS NOT NULL AND
    CIRCUITO_PAIS	IS NOT NULL
GO


-- Carrera
INSERT INTO [dbo].[Carrera] ([codigo_carrera],[fecha_carrera], [clima_carrera], [total_carrera], [cantidad_vueltas_carrera])
SELECT DISTINCT CODIGO_CARRERA, CARRERA_FECHA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA, CARRERA_CANT_VUELTAS
FROM [gd_esquema].[Maestra]
WHERE
    CARRERA_FECHA IS NOT NULL AND
    CARRERA_CLIMA IS NOT NULL AND
    CARRERA_TOTAL_CARRERA IS NOT NULL AND
    CARRERA_CANT_VUELTAS IS NOT NULL
GO


-- Sector
INSERT INTO [dbo].[Sector] ([codigo_circuito], [codigo_sector], [tipo_sector], [distancia_sector])
SELECT DISTINCT CIRCUITO_CODIGO, CODIGO_SECTOR, SECTO_TIPO, SECTOR_DISTANCIA
FROM [gd_esquema].[Maestra]
WHERE
    CIRCUITO_CODIGO IS NOT NULL AND
    SECTO_TIPO IS NOT NULL AND
    SECTOR_DISTANCIA IS NOT NULL
GO

-- Freno
INSERT INTO [dbo].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO1_NRO_SERIE, TELE_FRENO1_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL AND
TELE_FRENO1_TAMANIO_DISCO IS NOT NULL
GO

INSERT INTO [dbo].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO2_NRO_SERIE, TELE_FRENO2_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL AND
TELE_FRENO2_TAMANIO_DISCO IS NOT NULL
GO

INSERT INTO [dbo].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO3_NRO_SERIE, TELE_FRENO3_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL AND
TELE_FRENO3_TAMANIO_DISCO IS NOT NULL
GO

INSERT INTO [dbo].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO4_NRO_SERIE, TELE_FRENO4_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL AND
TELE_FRENO4_TAMANIO_DISCO IS NOT NULL
GO

-- Telemetria Freno
INSERT INTO [dbo].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO1_NRO_SERIE, TELE_FRENO1_GROSOR_PASTILLA, TELE_FRENO1_POSICION, TELE_FRENO1_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL AND
 TELE_FRENO1_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO1_POSICION IS NOT NULL AND
 TELE_FRENO1_TEMPERATURA IS NOT NULL
GO

INSERT INTO [dbo].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO2_NRO_SERIE, TELE_FRENO2_GROSOR_PASTILLA, TELE_FRENO2_POSICION, TELE_FRENO2_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL AND
 TELE_FRENO2_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO2_POSICION IS NOT NULL AND
 TELE_FRENO2_TEMPERATURA IS NOT NULL
GO

INSERT INTO [dbo].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO3_NRO_SERIE, TELE_FRENO3_GROSOR_PASTILLA, TELE_FRENO3_POSICION, TELE_FRENO3_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL AND
 TELE_FRENO3_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO3_POSICION IS NOT NULL AND
 TELE_FRENO3_TEMPERATURA IS NOT NULL
GO

INSERT INTO [dbo].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO4_NRO_SERIE, TELE_FRENO4_GROSOR_PASTILLA, TELE_FRENO4_POSICION, TELE_FRENO4_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL AND
 TELE_FRENO4_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO4_POSICION IS NOT NULL AND
 TELE_FRENO4_TEMPERATURA IS NOT NULL
GO

-- Cambios Neumatico
INSERT INTO [dbo].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO1_NRO_SERIE_VIEJO,
    NEUMATICO1_NRO_SERIE_NUEVO,
    NEUMATICO1_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO1_POSICION_VIEJO IS NOT NULL

INSERT INTO [dbo].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO2_NRO_SERIE_VIEJO,
    NEUMATICO2_NRO_SERIE_NUEVO,
    NEUMATICO2_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO2_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO2_POSICION_VIEJO IS NOT NULL

INSERT INTO [dbo].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO3_NRO_SERIE_VIEJO,
    NEUMATICO3_NRO_SERIE_NUEVO,
    NEUMATICO3_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO3_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO3_POSICION_VIEJO IS NOT NULL

INSERT INTO [dbo].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO4_NRO_SERIE_VIEJO,
    NEUMATICO4_NRO_SERIE_NUEVO,
    NEUMATICO4_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO4_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO4_POSICION_VIEJO IS NOT NULL

-- Parada Box
INSERT INTO [dbo].[Parada_Box]
(
    [codigo_auto],
    [codigo_cambio_neumatico1],
    [codigo_cambio_neumatico2],
    [codigo_cambio_neumatico3],
    [codigo_cambio_neumatico4],
    [codigo_carrera],
    [numero_vuelta_box],
    [tiempo_parada_box]
)
SELECT DISTINCT
    A.[codigo_auto],
    N1.[codigo_cambio_neumatico],
    N2.[codigo_cambio_neumatico],
    N3.[codigo_cambio_neumatico],
    N4.[codigo_cambio_neumatico],
    C.[codigo_carrera],
    M.PARADA_BOX_VUELTA,
    M.PARADA_BOX_TIEMPO
FROM [gd_esquema].[Maestra] M
LEFT JOIN [dbo].[Auto] A ON 
A.[modelo_auto] = M.AUTO_MODELO AND A.[numero_auto] = M.AUTO_NUMERO
LEFT JOIN [dbo].[Cambio_Neumatico] N1 ON 
N1.[num_serie_viejo] = M.NEUMATICO1_NRO_SERIE_VIEJO AND N1.[num_serie_nuevo] = M.NEUMATICO1_NRO_SERIE_NUEVO
LEFT JOIN [dbo].[Cambio_Neumatico] N2 ON
N2.[num_serie_viejo] = M.NEUMATICO2_NRO_SERIE_VIEJO AND N2.[num_serie_nuevo] = M.NEUMATICO2_NRO_SERIE_NUEVO
LEFT JOIN [dbo].[Cambio_Neumatico] N3 ON
N3.[num_serie_viejo] = M.NEUMATICO3_NRO_SERIE_VIEJO AND N3.[num_serie_nuevo] = M.NEUMATICO3_NRO_SERIE_NUEVO
LEFT JOIN [dbo].[Cambio_Neumatico] N4 ON
N4.[num_serie_viejo] = M.NEUMATICO4_NRO_SERIE_VIEJO AND N4.[num_serie_nuevo] = M.NEUMATICO4_NRO_SERIE_NUEVO
LEFT JOIN [dbo].[Carrera] C ON
C.[codigo_carrera] = M.CODIGO_CARRERA
WHERE M.PARADA_BOX_VUELTA IS NOT NULL AND M.PARADA_BOX_TIEMPO IS NOT NULL
GO

-- Incidente 
INSERT INTO [dbo].[Incidente]
( [codigo_auto], [codigo_circuito], [codigo_sector],
  [bandera_incidente], [tipo_incidente], [tiempo_incidente],
  [numero_vuelta] )
SELECT DISTINCT
	A.[codigo_auto],
	M.CIRCUITO_CODIGO,
	M.CODIGO_SECTOR,
    M.INCIDENTE_BANDERA,
	M.INCIDENTE_TIPO,
	M.INCIDENTE_TIEMPO,
	M.INCIDENTE_NUMERO_VUELTA
FROM [gd_esquema].[Maestra] M LEFT JOIN [dbo].[Auto] A ON 
	A.[modelo_auto] = M.AUTO_MODELO AND 
	A.[numero_auto] = M.AUTO_NUMERO
WHERE
	M.INCIDENTE_BANDERA IS NOT NULL AND
	M.INCIDENTE_TIPO IS NOT NULL AND
	M.INCIDENTE_TIEMPO IS NOT NULL AND
	M.INCIDENTE_NUMERO_VUELTA IS NOT NULL
GROUP BY A.[codigo_auto], M.CIRCUITO_CODIGO, M.CODIGO_SECTOR, M.INCIDENTE_BANDERA, M.INCIDENTE_TIPO, M.INCIDENTE_TIEMPO, M.INCIDENTE_NUMERO_VUELTA


-- Telemetria Auto


/* Fin Inserts */
