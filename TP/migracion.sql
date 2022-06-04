USE [GD1C2022]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* Comienzo Drops de las tablas */
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Telemetria_Auto]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Telemetria_Auto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Parada_Box]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Parada_Box]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Incidente_Auto]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Incidente_Auto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Incidente]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Incidente]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Sector]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Sector]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Circuito]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Circuito]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Carrera]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Carrera]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Piloto]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Piloto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Auto]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Auto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Escuderia]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Escuderia]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Telemetria_Neumatico]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Telemetria_Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Cambio_Neumatico]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Cambio_Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Neumatico]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Telemetria_Motor]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Telemetria_Motor]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Motor]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Motor]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Telemetria_Freno]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Telemetria_Freno]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Freno]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Freno]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Telemetria_Caja]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Telemetria_Caja]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[Caja]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[Caja]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[MIGRAR_TABLA_MAESTRA]'))
DROP PROCEDURE [MARCO_AND_FRIENDS].[MIGRAR_TABLA_MAESTRA]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'MARCO_AND_FRIENDS')
DROP SCHEMA [MARCO_AND_FRIENDS]
GO

/* Fin Drops de las tablas */

/*Comienzo Migracion */
CREATE SCHEMA MARCO_AND_FRIENDS
GO

CREATE PROCEDURE [MARCO_AND_FRIENDS].[MIGRAR_TABLA_MAESTRA] AS
BEGIN

/*Comienzo Creates de las tablas*/
CREATE TABLE [MARCO_AND_FRIENDS].[Circuito] (
    [codigo_circuito] int NOT NULL PRIMARY KEY,
    [nombre_circuito] nvarchar(255) NOT NULL,
    [pais_circuito] nvarchar(255) NOT NULL
)

CREATE TABLE [MARCO_AND_FRIENDS].[Carrera] (
    [codigo_carrera] int NOT NULL PRIMARY KEY,
    [codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Circuito] ([codigo_circuito]),
    [fecha_carrera] date NOT NULL,
    [clima_carrera] nvarchar(100) NOT NULL,
    [total_carrera] decimal(18,2) NOT NULL,
    [cantidad_vueltas_carrera] int NOT NULL
)

CREATE TABLE [MARCO_AND_FRIENDS].[Sector] (
    [codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Circuito] ([codigo_circuito]),
	[codigo_sector] int NOT NULL,
    [distancia_sector] decimal(18,2) NOT NULL,
    [tipo_sector] nvarchar(255) NOT NULL,
    CONSTRAINT PK_SECTOR PRIMARY KEY (codigo_circuito, codigo_sector)
)


CREATE TABLE [MARCO_AND_FRIENDS].[Escuderia] (
    [codigo_escuderia] int NOT NULL IDENTITY PRIMARY KEY,
    [nombre_escuderia] nvarchar(255) NOT NULL,
    [nacionalidad_escuderia] nvarchar(255) NOT NULL,
)


CREATE TABLE [MARCO_AND_FRIENDS].[Auto] (
    [codigo_auto] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_escuderia] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Escuderia] ([codigo_escuderia]),
    [modelo_auto] nvarchar(255) NOT NULL,
    [numero_auto] int NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Incidente] (
    [codigo_incidente] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_sector] int NOT NULL,
	[codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Circuito] ([codigo_circuito]),
    [bandera_incidente] nvarchar(255) NOT NULL,
    [tiempo_incidente] decimal(18,2) NOT NULL,
	CONSTRAINT FK_INCIDENTE_A_SECTOR FOREIGN KEY([codigo_circuito],[codigo_sector]) REFERENCES [MARCO_AND_FRIENDS].[Sector]([codigo_circuito],[codigo_sector]),
)


CREATE TABLE [MARCO_AND_FRIENDS].[Incidente_Auto] (
    [codigo_incidente] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [numero_vuelta] decimal(18,0) NOT NULL,
    [tipo_incidente] nvarchar(255) NOT NULL,
    CONSTRAINT PK_INCIDENTE_AUTO PRIMARY KEY (codigo_incidente, codigo_auto)
)


CREATE TABLE [MARCO_AND_FRIENDS].[Piloto] (
    [codigo_piloto] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Auto] ([codigo_auto]),
    [nombre_piloto] nvarchar(50) NOT NULL,
    [apellido_piloto] nvarchar(50) NOT NULL,
    [nacionalidad_piloto] nvarchar(50) NOT NULL,
    [nacimiento_piloto] date NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Neumatico] (
    [num_serie_neumatico] nvarchar(255) NOT NULL PRIMARY KEY,
    [tipo_neumatico] nvarchar(255) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Telemetria_Neumatico] (
    [codigo_telemetria_neumatico] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_neumatico] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Neumatico] ([num_serie_neumatico]),
    [posicion_neumatico] nvarchar(255) NOT NULL,
    [profundidad_neumatico] decimal(18,6) NOT NULL,
    [temperatura_neumatico] decimal(18,6) NOT NULL,
    [presion_neumatico] decimal(18,6) NOT NULL,
)


CREATE TABLE [MARCO_AND_FRIENDS].[Cambio_Neumatico] (
    [codigo_cambio_neumatico] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_viejo] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Neumatico] ([num_serie_neumatico]),
    [num_serie_nuevo] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Neumatico] ([num_serie_neumatico]),
    [posicion] nvarchar(255) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Parada_Box] (
    [codigo_parada_box] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Auto] ([codigo_auto]),
    [codigo_cambio_neumatico1] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_cambio_neumatico2] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_cambio_neumatico3] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_cambio_neumatico4] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([codigo_cambio_neumatico]),
    [codigo_carrera] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Carrera] ([codigo_carrera]),
    [numero_vuelta_box] decimal(18,0) NOT NULL,
    [tiempo_parada_box] decimal(18,2) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Motor] (
    [num_serie_motor] nvarchar(255) NOT NULL PRIMARY KEY,
    [modelo_motor] nvarchar(255) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Telemetria_Motor] (
    [codigo_telemetria_motor] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_motor] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Motor] ([num_serie_motor]),
    [potencia_motor] decimal(18,6) NOT NULL,
    [rpm_motor] decimal(18,6) NOT NULL,
    [temp_aceite_motor] decimal(18,6) NOT NULL,
    [temp_agua_motor] decimal(18,6) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Freno] (
    [num_serie_freno] nvarchar(255) NOT NULL PRIMARY KEY,
    [tamanio_disco_freno] nvarchar(255) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Telemetria_Freno] (
    [codigo_telemetria_freno] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_freno] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Freno] ([num_serie_freno]),
    [grosor_pastilla] decimal(18,2) NOT NULL,
    [posicion_freno] nvarchar(255) NOT NULL,
    [temperatura_freno] decimal(18,2) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Caja] (
    [num_serie_caja] nvarchar(255) NOT NULL PRIMARY KEY,
    [modelo_caja] nvarchar(50) NOT NULL,
)

CREATE TABLE [MARCO_AND_FRIENDS].[Telemetria_Caja] (
    [codigo_telemetria_caja] int NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_caja] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Caja] ([num_serie_caja]),
    [temp_aceite_caja] decimal(18,2) NOT NULL,
    [rpm_caja] decimal(18,2) NOT NULL,
    [desgaste_caja] decimal(18,2) NOT NULL
)


CREATE TABLE [MARCO_AND_FRIENDS].[Telemetria_Auto] (
    [codigo_telemetria_auto] decimal(18,0) NOT NULL PRIMARY KEY,
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Auto] ([codigo_auto]),
    [codigo_carrera] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Carrera] ([codigo_carrera]),
    [codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Circuito] ([codigo_circuito]),
	[codigo_sector] int NOT NULL,
    [codigo_telemetria_caja] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Caja] ([codigo_telemetria_caja]),
    [codigo_telemetria_motor] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Motor] ([codigo_telemetria_motor]),
    [codigo_tele_freno1] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno2] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno3] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno4] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_neumatico1] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico2] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico3] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico4] int NOT NULL FOREIGN KEY REFERENCES [MARCO_AND_FRIENDS].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [num_vuelta_auto] decimal(18,0) NOT NULL,
    [distancia_vuelta_auto] decimal(18,2) NOT NULL,
    [distancia_carrera_auto] decimal(18,6) NOT NULL,
    [posicion_auto] decimal(18,0) NOT NULL,
    [tiempo_vuelta_auto] decimal(18,10) NOT NULL,
    [velocidad_auto] decimal(18,2) NOT NULL,
    [combustible_auto] decimal(18,2) NOT NULL,
	CONSTRAINT FK_TELE_AUTO_A_SECTOR FOREIGN KEY([codigo_circuito],[codigo_sector]) REFERENCES [MARCO_AND_FRIENDS].[Sector]([codigo_circuito],[codigo_sector]),
)

/* FIN CREACION TABLAS */
/* COMIENZO CARGA DE DATOS */

-- Motor
INSERT INTO [MARCO_AND_FRIENDS].[Motor] ([num_serie_motor], [modelo_motor])
SELECT DISTINCT TELE_MOTOR_NRO_SERIE, TELE_MOTOR_MODELO
FROM [gd_esquema].[Maestra]
WHERE   TELE_MOTOR_NRO_SERIE IS NOT NULL 
    AND TELE_MOTOR_MODELO IS NOT NULL


-- Telemetria Motor
INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Motor]
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


-- Caja
INSERT INTO [MARCO_AND_FRIENDS].[Caja] ([num_serie_caja], [modelo_caja])
SELECT DISTINCT TELE_CAJA_NRO_SERIE, TELE_CAJA_MODELO
FROM [gd_esquema].[Maestra]
WHERE
    TELE_CAJA_MODELO IS NOT NULL AND 
    TELE_CAJA_MODELO IS NOT NULL


-- Telemetria Caja 
INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Caja] (num_serie_caja, temp_aceite_caja, rpm_caja, desgaste_caja)
SELECT DISTINCT TELE_CAJA_NRO_SERIE, TELE_CAJA_TEMP_ACEITE, TELE_CAJA_RPM, TELE_CAJA_DESGASTE
FROM [gd_esquema].[Maestra]
WHERE
    TELE_CAJA_NRO_SERIE IS NOT NULL AND
    TELE_CAJA_TEMP_ACEITE IS NOT NULL AND 
    TELE_CAJA_RPM IS NOT NULL AND 
    TELE_CAJA_DESGASTE IS NOT NULL


-- Neumatico
insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO1_NRO_SERIE_VIEJO, NEUMATICO1_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO1_NRO_SERIE_VIEJO is not null and NEUMATICO1_NRO_SERIE_VIEJO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO2_NRO_SERIE_VIEJO, NEUMATICO2_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO2_NRO_SERIE_VIEJO is not null and NEUMATICO2_NRO_SERIE_VIEJO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO3_NRO_SERIE_VIEJO, NEUMATICO3_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO3_NRO_SERIE_VIEJO is not null and NEUMATICO3_NRO_SERIE_VIEJO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO4_NRO_SERIE_VIEJO, NEUMATICO4_TIPO_VIEJO
	from gd_esquema.Maestra
	where NEUMATICO4_NRO_SERIE_VIEJO is not null and NEUMATICO4_NRO_SERIE_VIEJO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO1_NRO_SERIE_NUEVO, NEUMATICO1_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO1_NRO_SERIE_NUEVO is not null and NEUMATICO1_NRO_SERIE_NUEVO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO2_NRO_SERIE_NUEVO, NEUMATICO2_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO2_NRO_SERIE_NUEVO is not null and NEUMATICO2_NRO_SERIE_NUEVO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO3_NRO_SERIE_NUEVO, NEUMATICO3_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO3_NRO_SERIE_NUEVO is not null and NEUMATICO3_NRO_SERIE_NUEVO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct NEUMATICO4_NRO_SERIE_NUEVO, NEUMATICO4_TIPO_NUEVO
	from gd_esquema.Maestra
	where NEUMATICO4_NRO_SERIE_NUEVO is not null and NEUMATICO4_NRO_SERIE_NUEVO not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct TELE_NEUMATICO1_NRO_SERIE, NEUMATICO1_TIPO_VIEJO
	from gd_esquema.Maestra
	where TELE_NEUMATICO1_NRO_SERIE is not null and TELE_NEUMATICO1_NRO_SERIE not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct TELE_NEUMATICO2_NRO_SERIE, NEUMATICO2_TIPO_VIEJO
	from gd_esquema.Maestra
	where TELE_NEUMATICO2_NRO_SERIE is not null and TELE_NEUMATICO2_NRO_SERIE not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct TELE_NEUMATICO3_NRO_SERIE, NEUMATICO3_TIPO_VIEJO
	from gd_esquema.Maestra
	where TELE_NEUMATICO3_NRO_SERIE is not null and TELE_NEUMATICO3_NRO_SERIE not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )

insert into MARCO_AND_FRIENDS.Neumatico ([num_serie_neumatico], [tipo_neumatico])
(	select distinct TELE_NEUMATICO4_NRO_SERIE, NEUMATICO4_TIPO_VIEJO
	from gd_esquema.Maestra
	where TELE_NEUMATICO4_NRO_SERIE is not null and TELE_NEUMATICO4_NRO_SERIE not in (select num_serie_neumatico from MARCO_AND_FRIENDS.Neumatico) )


-- Telemetria Neumatico

insert into [MARCO_AND_FRIENDS].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO1_NRO_SERIE, TELE_NEUMATICO1_POSICION, TELE_NEUMATICO1_PROFUNDIDAD, TELE_NEUMATICO1_TEMPERATURA, TELE_NEUMATICO1_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO1_NRO_SERIE is not null

insert into [MARCO_AND_FRIENDS].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO2_NRO_SERIE, TELE_NEUMATICO2_POSICION, TELE_NEUMATICO2_PROFUNDIDAD, TELE_NEUMATICO2_TEMPERATURA, TELE_NEUMATICO2_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO2_NRO_SERIE is not null

insert into [MARCO_AND_FRIENDS].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO3_NRO_SERIE, TELE_NEUMATICO3_POSICION, TELE_NEUMATICO3_PROFUNDIDAD, TELE_NEUMATICO3_TEMPERATURA, TELE_NEUMATICO3_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO3_NRO_SERIE is not null

insert into [MARCO_AND_FRIENDS].[Telemetria_Neumatico]([num_serie_neumatico],[posicion_neumatico],[profundidad_neumatico],[temperatura_neumatico],[presion_neumatico])
select distinct TELE_NEUMATICO4_NRO_SERIE, TELE_NEUMATICO4_POSICION, TELE_NEUMATICO4_PROFUNDIDAD, TELE_NEUMATICO4_TEMPERATURA, TELE_NEUMATICO4_PRESION from gd_esquema.Maestra
where TELE_NEUMATICO4_NRO_SERIE is not null


-- Escuderia
INSERT INTO [MARCO_AND_FRIENDS].[Escuderia] ([nombre_escuderia], [nacionalidad_escuderia])
SELECT DISTINCT ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD
FROM [gd_esquema].[Maestra]
WHERE   ESCUDERIA_NOMBRE IS NOT NULL 
    AND ESCUDERIA_NACIONALIDAD IS NOT NULL
GROUP BY ESCUDERIA_NOMBRE, 
        ESCUDERIA_NACIONALIDAD


-- Auto
INSERT INTO [MARCO_AND_FRIENDS].[Auto] ([codigo_escuderia], [modelo_auto], [numero_auto])
SELECT DISTINCT E.codigo_escuderia, AUTO_MODELO, AUTO_NUMERO
FROM gd_esquema.Maestra LEFT JOIN MARCO_AND_FRIENDS.Escuderia E ON
E.nacionalidad_escuderia = ESCUDERIA_NACIONALIDAD AND E.nombre_escuderia = ESCUDERIA_NOMBRE
WHERE AUTO_MODELO IS NOT NULL AND AUTO_NUMERO IS NOT NULL


-- Piloto
INSERT INTO [MARCO_AND_FRIENDS].[Piloto] 
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
FROM gd_esquema.Maestra LEFT JOIN MARCO_AND_FRIENDS.Auto A ON
    A.modelo_auto = AUTO_MODELO AND A.numero_auto = AUTO_NUMERO
WHERE PILOTO_NOMBRE IS NOT NULL 
AND PILOTO_APELLIDO IS NOT NULL
AND PILOTO_NACIONALIDAD IS NOT NULL
AND PILOTO_FECHA_NACIMIENTO IS NOT NULL


-- Circuito
INSERT INTO [MARCO_AND_FRIENDS].[Circuito] ([codigo_circuito], [nombre_circuito], [pais_circuito])
SELECT DISTINCT CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS
FROM [gd_esquema].[Maestra]
WHERE
	CIRCUITO_CODIGO IS NOT NULL AND
    CIRCUITO_NOMBRE IS NOT NULL AND
    CIRCUITO_PAIS	IS NOT NULL



-- Carrera
INSERT INTO [MARCO_AND_FRIENDS].[Carrera] ([codigo_carrera],[fecha_carrera], [clima_carrera], [total_carrera], [cantidad_vueltas_carrera])
SELECT DISTINCT CODIGO_CARRERA, CIRCUITO_CODIGO, CARRERA_FECHA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA, CARRERA_CANT_VUELTAS
FROM [gd_esquema].[Maestra]
WHERE
    CARRERA_FECHA IS NOT NULL AND
    CIRCUITO_CODIGO IS NOT NULL AND
    CARRERA_CLIMA IS NOT NULL AND
    CARRERA_TOTAL_CARRERA IS NOT NULL AND
    CARRERA_CANT_VUELTAS IS NOT NULL



-- Sector
INSERT INTO [MARCO_AND_FRIENDS].[Sector] ([codigo_circuito], [codigo_sector], [tipo_sector], [distancia_sector])
SELECT DISTINCT CIRCUITO_CODIGO, CODIGO_SECTOR, SECTO_TIPO, SECTOR_DISTANCIA
FROM [gd_esquema].[Maestra]
WHERE
    CIRCUITO_CODIGO IS NOT NULL AND
    SECTO_TIPO IS NOT NULL AND
    SECTOR_DISTANCIA IS NOT NULL


-- Freno
INSERT INTO [MARCO_AND_FRIENDS].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO1_NRO_SERIE, TELE_FRENO1_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL AND
TELE_FRENO1_TAMANIO_DISCO IS NOT NULL


INSERT INTO [MARCO_AND_FRIENDS].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO2_NRO_SERIE, TELE_FRENO2_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL AND
TELE_FRENO2_TAMANIO_DISCO IS NOT NULL


INSERT INTO [MARCO_AND_FRIENDS].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO3_NRO_SERIE, TELE_FRENO3_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL AND
TELE_FRENO3_TAMANIO_DISCO IS NOT NULL


INSERT INTO [MARCO_AND_FRIENDS].[Freno] ([num_serie_freno], [tamanio_disco_freno])
SELECT DISTINCT TELE_FRENO4_NRO_SERIE, TELE_FRENO4_TAMANIO_DISCO
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL AND
TELE_FRENO4_TAMANIO_DISCO IS NOT NULL


-- Telemetria Freno
INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO1_NRO_SERIE, TELE_FRENO1_GROSOR_PASTILLA, TELE_FRENO1_POSICION, TELE_FRENO1_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL AND
 TELE_FRENO1_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO1_POSICION IS NOT NULL AND
 TELE_FRENO1_TEMPERATURA IS NOT NULL


INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO2_NRO_SERIE, TELE_FRENO2_GROSOR_PASTILLA, TELE_FRENO2_POSICION, TELE_FRENO2_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL AND
 TELE_FRENO2_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO2_POSICION IS NOT NULL AND
 TELE_FRENO2_TEMPERATURA IS NOT NULL


INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO3_NRO_SERIE, TELE_FRENO3_GROSOR_PASTILLA, TELE_FRENO3_POSICION, TELE_FRENO3_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL AND
 TELE_FRENO3_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO3_POSICION IS NOT NULL AND
 TELE_FRENO3_TEMPERATURA IS NOT NULL


INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Freno] ([num_serie_freno], [grosor_pastilla],[posicion_freno], [temperatura_freno])
SELECT DISTINCT TELE_FRENO4_NRO_SERIE, TELE_FRENO4_GROSOR_PASTILLA, TELE_FRENO4_POSICION, TELE_FRENO4_TEMPERATURA
FROM [gd_esquema].[Maestra]
WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL AND
 TELE_FRENO4_GROSOR_PASTILLA IS NOT NULL AND
 TELE_FRENO4_POSICION IS NOT NULL AND
 TELE_FRENO4_TEMPERATURA IS NOT NULL


-- Cambios Neumatico
INSERT INTO [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO1_NRO_SERIE_VIEJO,
    NEUMATICO1_NRO_SERIE_NUEVO,
    NEUMATICO1_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO1_POSICION_VIEJO IS NOT NULL

INSERT INTO [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO2_NRO_SERIE_VIEJO,
    NEUMATICO2_NRO_SERIE_NUEVO,
    NEUMATICO2_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO2_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO2_POSICION_VIEJO IS NOT NULL

INSERT INTO [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO3_NRO_SERIE_VIEJO,
    NEUMATICO3_NRO_SERIE_NUEVO,
    NEUMATICO3_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO3_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO3_POSICION_VIEJO IS NOT NULL

INSERT INTO [MARCO_AND_FRIENDS].[Cambio_Neumatico] ([num_serie_viejo], [num_serie_nuevo], [posicion])
SELECT DISTINCT
    NEUMATICO4_NRO_SERIE_VIEJO,
    NEUMATICO4_NRO_SERIE_NUEVO,
    NEUMATICO4_POSICION_VIEJO
FROM gd_esquema.Maestra
WHERE NEUMATICO4_NRO_SERIE_VIEJO IS NOT NULL
AND    NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL
AND    NEUMATICO4_POSICION_VIEJO IS NOT NULL


-- Parada Box
INSERT INTO [MARCO_AND_FRIENDS].[Parada_Box]
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
LEFT JOIN [MARCO_AND_FRIENDS].[Auto] A ON 
A.[modelo_auto] = M.AUTO_MODELO AND A.[numero_auto] = M.AUTO_NUMERO
LEFT JOIN [MARCO_AND_FRIENDS].[Cambio_Neumatico] N1 ON 
N1.[num_serie_viejo] = M.NEUMATICO1_NRO_SERIE_VIEJO AND N1.[num_serie_nuevo] = M.NEUMATICO1_NRO_SERIE_NUEVO
LEFT JOIN [MARCO_AND_FRIENDS].[Cambio_Neumatico] N2 ON
N2.[num_serie_viejo] = M.NEUMATICO2_NRO_SERIE_VIEJO AND N2.[num_serie_nuevo] = M.NEUMATICO2_NRO_SERIE_NUEVO
LEFT JOIN [MARCO_AND_FRIENDS].[Cambio_Neumatico] N3 ON
N3.[num_serie_viejo] = M.NEUMATICO3_NRO_SERIE_VIEJO AND N3.[num_serie_nuevo] = M.NEUMATICO3_NRO_SERIE_NUEVO
LEFT JOIN [MARCO_AND_FRIENDS].[Cambio_Neumatico] N4 ON
N4.[num_serie_viejo] = M.NEUMATICO4_NRO_SERIE_VIEJO AND N4.[num_serie_nuevo] = M.NEUMATICO4_NRO_SERIE_NUEVO
LEFT JOIN [MARCO_AND_FRIENDS].[Carrera] C ON
C.[codigo_carrera] = M.CODIGO_CARRERA
WHERE M.PARADA_BOX_VUELTA IS NOT NULL AND M.PARADA_BOX_TIEMPO IS NOT NULL


-- Incidente 
INSERT INTO [MARCO_AND_FRIENDS].[Incidente]
([codigo_circuito], [codigo_sector],
  [bandera_incidente], [tiempo_incidente] )
SELECT DISTINCT
	M.CIRCUITO_CODIGO,
	M.CODIGO_SECTOR,
    M.INCIDENTE_BANDERA,
	M.INCIDENTE_TIEMPO
FROM [gd_esquema].[Maestra] M
WHERE
	M.INCIDENTE_BANDERA IS NOT NULL AND
	M.INCIDENTE_TIPO IS NOT NULL AND
	M.INCIDENTE_TIEMPO IS NOT NULL AND
	M.INCIDENTE_NUMERO_VUELTA IS NOT NULL
GROUP BY M.CIRCUITO_CODIGO, M.CODIGO_SECTOR, M.INCIDENTE_BANDERA, M.INCIDENTE_TIPO, M.INCIDENTE_TIEMPO, M.INCIDENTE_NUMERO_VUELTA


INSERT INTO [MARCO_AND_FRIENDS].[Incidente_Auto]
(
    [codigo_incidente],
    [codigo_auto],
    [numero_vuelta],
    [tipo_incidente]
)
SELECT DISTINCT
    I.[codigo_incidente],
    A.[codigo_auto],
    M.INCIDENTE_NUMERO_VUELTA,
    M.INCIDENTE_TIPO
FROM [gd_esquema].[Maestra] M 
LEFT JOIN [MARCO_AND_FRIENDS].[Auto] A ON
    A.[modelo_auto] = M.AUTO_MODELO AND A.[numero_auto] = M.AUTO_NUMERO
LEFT JOIN [MARCO_AND_FRIENDS].[Incidente] I ON
    I.[codigo_circuito] = M.CIRCUITO_CODIGO 
AND I.[codigo_sector] = M.CODIGO_SECTOR 
AND I.[bandera_incidente] = M.INCIDENTE_BANDERA
AND I.[tiempo_incidente] = M.INCIDENTE_TIEMPO
WHERE 
    M.INCIDENTE_BANDERA IS NOT NULL AND
    M.INCIDENTE_TIPO IS NOT NULL AND
    M.INCIDENTE_TIEMPO IS NOT NULL AND
    M.INCIDENTE_NUMERO_VUELTA IS NOT NULL AND
    M.AUTO_MODELO IS NOT NULL AND
    M.AUTO_NUMERO IS NOT NULL AND 
    M.CIRCUITO_CODIGO IS NOT NULL AND
    M.CODIGO_SECTOR IS NOT NULL


-- Telemetria Auto
INSERT INTO [MARCO_AND_FRIENDS].[Telemetria_Auto] (
	[codigo_telemetria_auto],
	[codigo_auto],
	[codigo_carrera],
	[codigo_circuito],
	[codigo_sector],
	[codigo_telemetria_caja],
	[codigo_telemetria_motor],
	[codigo_tele_freno1],
	[codigo_tele_freno2],
	[codigo_tele_freno3],
	[codigo_tele_freno4],
	[codigo_tele_neumatico1],
	[codigo_tele_neumatico2],
	[codigo_tele_neumatico3],
	[codigo_tele_neumatico4],
	[num_vuelta_auto],
	[distancia_vuelta_auto],
	[distancia_carrera_auto],
	[posicion_auto],
	[tiempo_vuelta_auto],
	[velocidad_auto],
	[combustible_auto]
	)
	SELECT DISTINCT 
		M.TELE_AUTO_CODIGO,
		A.codigo_auto,
		M.CODIGO_CARRERA,
		M.CIRCUITO_CODIGO,
		M.CODIGO_SECTOR,
		TC.codigo_telemetria_caja,
		TM.codigo_telemetria_motor,
		TF1.codigo_telemetria_freno,
		TF2.codigo_telemetria_freno,
		TF3.codigo_telemetria_freno,
		TF4.codigo_telemetria_freno,
		TN1.codigo_telemetria_neumatico,
		TN2.codigo_telemetria_neumatico,
		TN3.codigo_telemetria_neumatico,
		TN4.codigo_telemetria_neumatico,
		M.TELE_AUTO_NUMERO_VUELTA,
		M.TELE_AUTO_DISTANCIA_VUELTA,
		M.TELE_AUTO_DISTANCIA_CARRERA,
		M.TELE_AUTO_POSICION,
		M.TELE_AUTO_TIEMPO_VUELTA,
		M.TELE_AUTO_VELOCIDAD,
		M.TELE_AUTO_COMBUSTIBLE
	FROM 
		gd_esquema.Maestra M
		LEFT JOIN [MARCO_AND_FRIENDS].[Auto] A ON M.AUTO_MODELO = A.modelo_auto AND M.AUTO_NUMERO = A.numero_auto
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Caja] TC ON M.TELE_CAJA_NRO_SERIE = TC.num_serie_caja AND M.TELE_CAJA_DESGASTE = TC.desgaste_caja AND M.TELE_CAJA_RPM = TC.rpm_caja AND M.TELE_CAJA_TEMP_ACEITE = TC.temp_aceite_caja
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Motor] TM ON M.TELE_MOTOR_NRO_SERIE = TM.num_serie_motor AND TM.potencia_motor = M.TELE_MOTOR_POTENCIA AND TM.rpm_motor = M.TELE_MOTOR_RPM AND TM.temp_aceite_motor = M.TELE_MOTOR_TEMP_ACEITE AND TM.temp_agua_motor = M.TELE_MOTOR_TEMP_AGUA
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Freno] TF1 ON  TF1.num_serie_freno = M.TELE_FRENO1_NRO_SERIE AND TF1.posicion_freno = M.TELE_FRENO1_POSICION AND TF1.grosor_pastilla = M.TELE_FRENO1_GROSOR_PASTILLA AND TF1.temperatura_freno = M.TELE_FRENO1_TEMPERATURA
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Freno] TF2 ON  TF2.num_serie_freno = M.TELE_FRENO2_NRO_SERIE AND TF2.posicion_freno = M.TELE_FRENO2_POSICION AND TF2.grosor_pastilla = M.TELE_FRENO2_GROSOR_PASTILLA AND TF2.temperatura_freno = M.TELE_FRENO2_TEMPERATURA
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Freno] TF3 ON  TF3.num_serie_freno = M.TELE_FRENO3_NRO_SERIE AND TF3.posicion_freno = M.TELE_FRENO3_POSICION AND TF3.grosor_pastilla = M.TELE_FRENO3_GROSOR_PASTILLA AND TF3.temperatura_freno = M.TELE_FRENO3_TEMPERATURA
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Freno] TF4 ON  TF4.num_serie_freno = M.TELE_FRENO4_NRO_SERIE AND TF4.posicion_freno = M.TELE_FRENO4_POSICION AND TF4.grosor_pastilla = M.TELE_FRENO4_GROSOR_PASTILLA AND TF4.temperatura_freno = M.TELE_FRENO4_TEMPERATURA
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Neumatico] TN1 ON TN1.num_serie_neumatico = M.TELE_NEUMATICO1_NRO_SERIE AND TN1.profundidad_neumatico = M.TELE_NEUMATICO1_PROFUNDIDAD and TN1.temperatura_neumatico = M.TELE_NEUMATICO1_TEMPERATURA AND TN1.presion_neumatico = M.TELE_NEUMATICO1_PRESION AND TN1.posicion_neumatico = M.TELE_NEUMATICO1_POSICION
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Neumatico] TN2 ON TN2.num_serie_neumatico = M.TELE_NEUMATICO2_NRO_SERIE AND TN2.profundidad_neumatico = M.TELE_NEUMATICO2_PROFUNDIDAD and TN2.temperatura_neumatico = M.TELE_NEUMATICO2_TEMPERATURA AND TN2.presion_neumatico = M.TELE_NEUMATICO2_PRESION AND TN2.posicion_neumatico = M.TELE_NEUMATICO2_POSICION
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Neumatico] TN3 ON TN3.num_serie_neumatico = M.TELE_NEUMATICO3_NRO_SERIE AND TN3.profundidad_neumatico = M.TELE_NEUMATICO3_PROFUNDIDAD and TN3.temperatura_neumatico = M.TELE_NEUMATICO3_TEMPERATURA AND TN3.presion_neumatico = M.TELE_NEUMATICO3_PRESION AND TN3.posicion_neumatico = M.TELE_NEUMATICO3_POSICION
		LEFT JOIN [MARCO_AND_FRIENDS].[Telemetria_Neumatico] TN4 ON TN4.num_serie_neumatico = M.TELE_NEUMATICO4_NRO_SERIE AND TN4.profundidad_neumatico = M.TELE_NEUMATICO4_PROFUNDIDAD and TN4.temperatura_neumatico = M.TELE_NEUMATICO4_TEMPERATURA AND TN4.presion_neumatico = M.TELE_NEUMATICO4_PRESION AND TN4.posicion_neumatico = M.TELE_NEUMATICO4_POSICION
	WHERE M.TELE_AUTO_CODIGO IS NOT NULL

/* Fin Inserts */
END
GO

EXEC MARCO_AND_FRIENDS.MIGRAR_TABLA_MAESTRA;
GO