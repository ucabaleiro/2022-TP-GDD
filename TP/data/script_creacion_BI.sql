USE [GD1C2022]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* Comienzo Drops Prelimpieza */

/************************************/
/* DROP TABLAS DIMENSIONES Y HECHOS */
/************************************/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Incidente]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Incidente]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Parada]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Parada]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Telemetria]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Telemetria]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Circuito]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Circuito]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Escuderia]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Escuderia]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Auto]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Auto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Piloto]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Piloto]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Tipo_Sector]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Tipo_Sector]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Tipo_Neumatico]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Tipo_Neumatico]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Tipo_Incidente]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Tipo_Incidente]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_Tiempo]') AND type in (N'U'))
DROP TABLE [MARCO_AND_FRIENDS].[BI_Tiempo]
GO

/***************/
/* DROP VISTAS */
/***************/

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_PELIGROSOS]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_PELIGROSOS];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_MAX_VELOCIDAD_POR_AUTO_POR_TIPO_SECTOR_POR_CIRCUITO]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_MAX_VELOCIDAD_POR_AUTO_POR_TIPO_SECTOR_POR_CIRCUITO];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_PROMEDIO_INCIDENTES_ESCUDERIA_POR_ANIO_POR_SECTOR]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_PROMEDIO_INCIDENTES_ESCUDERIA_POR_ANIO_POR_SECTOR];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_TIEMPO_PROMEDIO_PARADAS_POR_CUATRIMESTRE]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_TIEMPO_PROMEDIO_PARADAS_POR_CUATRIMESTRE];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_CIRCUITOS_CON_MAYOR_CONSUMO_DE_COMBUSTIBLE_PROMEDIO]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_CIRCUITOS_CON_MAYOR_CONSUMO_DE_COMBUSTIBLE_PROMEDIO];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_DESGASTE_PROMEDIO_AUTO_POR_VUELTA_POR_CIRCUITO]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_DESGASTE_PROMEDIO_AUTO_POR_VUELTA_POR_CIRCUITO];
GO

/******************/
/* DROP FUNCIONES */
/******************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[CUATRIMESTRE]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [MARCO_AND_FRIENDS].[CUATRIMESTRE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[GET_PK_TIEMPO]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIEMPO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[GET_PK_TIPO_NEUMATICO]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIPO_NEUMATICO]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[GET_PK_TIPO_INCIDENTE]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIPO_INCIDENTE]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[CONSUMO_CIRCUITO_AUTO]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [MARCO_AND_FRIENDS].[CONSUMO_CIRCUITO_AUTO]
GO

/* Create Tablas BI */

/* Create Dimensiones */
CREATE TABLE [MARCO_AND_FRIENDS].[BI_Circuito] (
    [codigo_circuito] int NOT NULL PRIMARY KEY,
    [nombre_circuito] nvarchar(255) NOT NULL,
    [pais_circuito] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Escuderia] (
    [codigo_escuderia] int NOT NULL PRIMARY KEY,
    [nombre_escuderia] nvarchar(255) NOT NULL,
    [nacionalidad_escuderia] nvarchar(255) NOT NULL,
)
GO


CREATE TABLE [MARCO_AND_FRIENDS].[BI_Auto] (
    [codigo_auto] int NOT NULL PRIMARY KEY,
    [modelo_auto] nvarchar(255) NOT NULL,
    [numero_auto] int NOT NULL
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Piloto] (
    [codigo_piloto] int NOT NULL PRIMARY KEY,
    [nombre_piloto] nvarchar(50) NOT NULL,
    [apellido_piloto] nvarchar(50) NOT NULL,
    [nacionalidad_piloto] nvarchar(50) NOT NULL,
    [nacimiento_piloto] date NOT NULL
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Tipo_Sector] (
    [codigo_tipo_sector] int NOT NULL IDENTITY PRIMARY KEY,
    [descripcion] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Tipo_Neumatico] (
    [codigo_tipo_neumatico] int NOT NULL IDENTITY PRIMARY KEY,
    [descripcion] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Tipo_Incidente] (
    [codigo_tipo_incidente] int NOT NULL IDENTITY PRIMARY KEY,
    [descripcion] nvarchar (255) NOT NULL
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Tiempo] (
    [id_tiempo] int NOT NULL IDENTITY PRIMARY KEY,
    [anio] int NOT NULL,
    [cuatrimestre] int NOT NULL   
)
GO

/* Create Hechos */
CREATE TABLE [MARCO_AND_FRIENDS].[BI_Incidente] (
    [codigo_incidente] int NOT NULL,
    [fecha_incidente] int NOT NULL,
    [codigo_circuito] int NOT NULL,
    [tipo_sector] int NOT NULL,
    [codigo_escuderia] int NOT NULL,
    [codigo_piloto] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [tipo_incidente] int NOT NULL,
    [tiempo_incidente] decimal(18,2) NOT NULL,
    [bandera_incidente] nvarchar(255) NOT NULL,
    [numero_vuelta] decimal(18,0) NOT NULL,
    CONSTRAINT PK_BI_INCIDENTE PRIMARY KEY (codigo_incidente, fecha_incidente, codigo_circuito, tipo_sector, codigo_escuderia, codigo_piloto, codigo_auto)
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Parada] (
    [codigo_parada] int NOT NULL,
    [fecha_parada] int NOT NULL,
    [codigo_circuito] int NOT NULL,
    [codigo_escuderia] int NOT NULL,
    [codigo_piloto] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [tiempo_parada_box] decimal(18,2) NOT NULL,
    [numero_vuelta_box] decimal(18,0) NOT NULL,

    CONSTRAINT PK_BI_PARADA PRIMARY KEY (codigo_parada, fecha_parada, codigo_circuito, codigo_escuderia, codigo_piloto, codigo_auto)
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Telemetria] (
    [codigo_telemetria] int NOT NULL,
    [fecha_telemetria] int NOT NULL,
    [codigo_circuito] int NOT NULL,
    [tipo_sector] int NOT NULL,
    [codigo_escuderia] int NOT NULL,
    [codigo_piloto] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [tiempo_vuelta] decimal(18,10) NOT NULL,
    [numero_vuelta] decimal(18,0) NOT NULL,
    [velocidad] decimal(18,2) NOT NULL,
    [combustible] decimal(18,2) NOT NULL,
    [desgaste_caja] decimal(18,2) NOT NULL,
    [potencia_motor] decimal(18,6) NOT NULL,
    [grosor_pastilla1] decimal(18,2) NOT NULL,
    [grosor_pastilla2] decimal(18,2) NOT NULL,
    [grosor_pastilla3] decimal(18,2) NOT NULL,
    [grosor_pastilla4] decimal(18,2) NOT NULL,
    [profundidad_neumatico1] decimal(18,6) NOT NULL,
    [profundidad_neumatico2] decimal(18,6) NOT NULL,
    [profundidad_neumatico3] decimal(18,6) NOT NULL,
    [profundidad_neumatico4] decimal(18,6) NOT NULL,
    CONSTRAINT PK_BI_TELEMETRIA PRIMARY KEY (codigo_telemetria, fecha_telemetria, codigo_circuito, codigo_escuderia, codigo_piloto, codigo_auto)
)
GO

/* Utils */
CREATE FUNCTION [MARCO_AND_FRIENDS].[CUATRIMESTRE] (@fecha DATE) RETURNS INT AS
BEGIN 
    DECLARE @RETURN_VALUE INT;
    SET @RETURN_VALUE = (MONTH(@fecha) / 3) + 1
	RETURN @RETURN_VALUE
END
GO

CREATE FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIEMPO] (@fecha DATE) RETURNS INT AS
    BEGIN
        DECLARE @RETURN_VALUE INT;
        SELECT @RETURN_VALUE = [id_tiempo] FROM [MARCO_AND_FRIENDS].[BI_Tiempo] WHERE cuatrimestre = [MARCO_AND_FRIENDS].[CUATRIMESTRE](@fecha) and anio = YEAR(@fecha);
        RETURN @RETURN_VALUE;
    END
GO

CREATE FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR] (@desc_tipo_sector nvarchar(255)) RETURNS INT AS
    BEGIN
        DECLARE @RETURN_VALUE INT;
        SELECT @RETURN_VALUE = [codigo_tipo_sector] FROM [MARCO_AND_FRIENDS].[BI_Tipo_Sector] WHERE descripcion = @desc_tipo_sector;
        RETURN @RETURN_VALUE;
    END
GO

CREATE FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIPO_NEUMATICO] (@desc_tipo_neumatico nvarchar(255)) RETURNS INT AS
    BEGIN
        DECLARE @RETURN_VALUE INT;
        SELECT @RETURN_VALUE = [codigo_tipo_neumatico] FROM [MARCO_AND_FRIENDS].[BI_Tipo_Neumatico] WHERE descripcion = @desc_tipo_neumatico;
        RETURN @RETURN_VALUE;
    END
GO

CREATE FUNCTION [MARCO_AND_FRIENDS].[GET_PK_TIPO_INCIDENTE] (@desc_tipo_incidente nvarchar(255)) RETURNS INT AS
    BEGIN
        DECLARE @RETURN_VALUE INT;
        SELECT @RETURN_VALUE = [codigo_tipo_incidente] FROM [MARCO_AND_FRIENDS].[BI_Tipo_incidente] WHERE descripcion = @desc_tipo_incidente;
        RETURN @RETURN_VALUE;
    END
GO

CREATE FUNCTION [MARCO_AND_FRIENDS].[CONSUMO_CIRCUITO_AUTO] (@cod_auto int, @cod_circuito int) RETURNS decimal(18, 2) AS
	BEGIN
		DECLARE @RETURN_VALUE decimal(18,2);
		DECLARE @COMBUSTIBLE_MAX decimal(18,2);
		DECLARE @COMBUSTIBLE_MIN decimal(18,2);
		SELECT @COMBUSTIBLE_MAX = MAX(T.combustible) from MARCO_AND_FRIENDS.BI_Telemetria T WHERE T.codigo_auto = @cod_auto and T.codigo_circuito = @cod_circuito;
		SELECT @COMBUSTIBLE_MIN = MIN(T.combustible) from MARCO_AND_FRIENDS.BI_Telemetria T WHERE T.codigo_auto = @cod_auto and T.codigo_circuito = @cod_circuito;
		SET @RETURN_VALUE = @COMBUSTIBLE_MAX - @COMBUSTIBLE_MIN
		RETURN @RETURN_VALUE
	END
GO



/* Carga de dimensiones a modelo BI */
INSERT INTO [MARCO_AND_FRIENDS].[BI_Tiempo] ([anio], [cuatrimestre]) 
SELECT YEAR(fecha_carrera), [MARCO_AND_FRIENDS].[CUATRIMESTRE](fecha_carrera) FROM [MARCO_AND_FRIENDS].[Carrera]
group by fecha_carrera
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Circuito] ([codigo_circuito], [nombre_circuito], [pais_circuito])
SELECT * FROM [MARCO_AND_FRIENDS].[Circuito]
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Escuderia] ([codigo_escuderia], [nombre_escuderia], [nacionalidad_escuderia])
SELECT [codigo_escuderia], [nombre_escuderia], [nacionalidad_escuderia] FROM [MARCO_AND_FRIENDS].[Escuderia]
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Auto] ([codigo_auto], [modelo_auto], [numero_auto])
SELECT [codigo_auto], [modelo_auto], [numero_auto] FROM [MARCO_AND_FRIENDS].[Auto]
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Piloto](
    [codigo_piloto],
    [nombre_piloto],
    [apellido_piloto],
    [nacionalidad_piloto],
    [nacimiento_piloto]
)
SELECT  [codigo_piloto],
        [nombre_piloto],
        [apellido_piloto],
        [nacionalidad_piloto],
        [nacimiento_piloto]
FROM [MARCO_AND_FRIENDS].[Piloto]
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Tipo_Sector] ([descripcion])
SELECT DISTINCT [tipo_sector] FROM [MARCO_AND_FRIENDS].[Sector]
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Tipo_Neumatico] ([descripcion])
SELECT DISTINCT [tipo_neumatico] FROM [MARCO_AND_FRIENDS].[Neumatico]
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Tipo_Incidente] ([descripcion])
SELECT DISTINCT [tipo_incidente] FROM [MARCO_AND_FRIENDS].[Incidente_Auto]
GO

/* Carga de Hechos BI */
INSERT INTO [MARCO_AND_FRIENDS].[BI_Parada](
    [codigo_parada],
    [fecha_parada],
    [codigo_circuito],
    [codigo_escuderia],
    [codigo_piloto],
    [codigo_auto],
    [tiempo_parada_box],
    [numero_vuelta_box]
)
SELECT  Par.codigo_parada_box,
        [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        C.codigo_circuito,
        A.codigo_escuderia,
        Pil.codigo_piloto,
        A.codigo_auto,
        Par.tiempo_parada_box,
        Par.numero_vuelta_box
FROM MARCO_AND_FRIENDS.Parada_Box Par
LEFT JOIN MARCO_AND_FRIENDS.Carrera C ON Par.codigo_carrera = C.codigo_carrera
LEFT JOIN MARCO_AND_FRIENDS.Auto A ON Par.codigo_auto = A.codigo_auto
LEFT JOIN MARCO_AND_FRIENDS.Piloto Pil ON Pil.codigo_auto = A.codigo_auto
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Incidente](
    [codigo_incidente],
    [fecha_incidente],
    [codigo_circuito],
    [tipo_sector],
    [codigo_escuderia],
    [codigo_piloto],
    [codigo_auto],
    [tipo_incidente],
    [tiempo_incidente],
    [bandera_incidente],
    [numero_vuelta]
)
SELECT  I.codigo_incidente,
        [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        I.codigo_circuito,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](S.tipo_sector),
        A.codigo_escuderia,
        Pil.codigo_piloto,
        A.codigo_auto,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_INCIDENTE](IA.tipo_incidente),
        I.tiempo_incidente,
        I.bandera_incidente,
        IA.numero_vuelta
FROM MARCO_AND_FRIENDS.Incidente_Auto IA
JOIN MARCO_AND_FRIENDS.Incidente I ON I.codigo_incidente = IA.codigo_incidente
JOIN MARCO_AND_FRIENDS.Carrera C ON C.codigo_carrera = I.codigo_carrera
JOIN MARCO_AND_FRIENDS.Sector S ON S.codigo_sector = I.codigo_sector AND S.codigo_circuito = I.codigo_circuito
JOIN MARCO_AND_FRIENDS.Auto A ON A.codigo_auto = IA.codigo_auto
JOIN MARCO_AND_FRIENDS.Piloto Pil ON Pil.codigo_auto = IA.codigo_auto
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Telemetria](
    [codigo_telemetria],
    [fecha_telemetria],
    [codigo_circuito],
    [tipo_sector],
    [codigo_escuderia],
    [codigo_piloto],
    [codigo_auto],
    [tiempo_vuelta],
    [numero_vuelta],
    [velocidad],
    [combustible],
    [desgaste_caja],
    [potencia_motor],
    [grosor_pastilla1],
    [grosor_pastilla2],
    [grosor_pastilla3],
    [grosor_pastilla4],
    [profundidad_neumatico1],
    [profundidad_neumatico2],
    [profundidad_neumatico3],
    [profundidad_neumatico4]
)
SELECT  T.codigo_telemetria_auto,
        [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        C.codigo_circuito,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](S.tipo_sector),
        A.codigo_escuderia,
        T.codigo_auto,
        Pil.codigo_piloto,
        T.tiempo_vuelta_auto,
        T.num_vuelta_auto,
        T.velocidad_auto,
        T.combustible_auto,
        TC.desgaste_caja,
        TM.potencia_motor,
        TF1.grosor_pastilla,
        TF2.grosor_pastilla,
        TF3.grosor_pastilla,
        TF4.grosor_pastilla,
        TN1.profundidad_neumatico,
        TN2.profundidad_neumatico,
        TN3.profundidad_neumatico,
        TN4.profundidad_neumatico
FROM MARCO_AND_FRIENDS.Telemetria_Auto T
LEFT JOIN MARCO_AND_FRIENDS.Carrera C ON C.codigo_carrera = T.codigo_carrera
LEFT JOIN MARCO_AND_FRIENDS.Sector S ON S.codigo_sector = T.codigo_sector AND S.codigo_circuito = T.codigo_circuito
LEFT JOIN MARCO_AND_FRIENDS.Auto A ON A.codigo_auto = T.codigo_auto
LEFT JOIN MARCO_AND_FRIENDS.Piloto Pil ON Pil.codigo_auto = T.codigo_auto
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Caja TC ON TC.codigo_telemetria_caja = T.codigo_telemetria_caja
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Motor TM ON TM.codigo_telemetria_motor = T.codigo_telemetria_motor
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF1 ON TF1.codigo_telemetria_freno = T.codigo_tele_freno1
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF2 ON TF2.codigo_telemetria_freno = T.codigo_tele_freno2
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF3 ON TF3.codigo_telemetria_freno = T.codigo_tele_freno3
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF4 ON TF4.codigo_telemetria_freno = T.codigo_tele_freno4
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN1 ON TN1.codigo_telemetria_neumatico = T.codigo_tele_neumatico1
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN2 ON TN2.codigo_telemetria_neumatico = T.codigo_tele_neumatico2
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN3 ON TN3.codigo_telemetria_neumatico = T.codigo_tele_neumatico3
LEFT JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN4 ON TN4.codigo_telemetria_neumatico = T.codigo_tele_neumatico4
GO

/* Creacion de vistas */

-- Mejor tiempo de vuelta de cada escudería por circuito por año. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS] AS
	SELECT Anio, Escuderia, Circuito, MIN(Tiempo) as Mejor_Tiempo
    FROM(
    SELECT
        F.anio as Anio,
		E.nombre_escuderia as Escuderia,
        C.codigo_circuito as Circuito,
        T.numero_vuelta as Vuelta,
        MAX(T.tiempo_vuelta) as Tiempo
	FROM MARCO_AND_FRIENDS.BI_Telemetria T
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = T.fecha_telemetria
    LEFT JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = T.codigo_escuderia
    LEFT JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = T.codigo_circuito
    GROUP BY F.anio, E.nombre_escuderia, C.codigo_circuito, T.numero_vuelta
    ) B
    GROUP BY Anio, Escuderia, Circuito
GO

-- Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES] AS
    SELECT TOP 3 C.nombre_circuito, SUM(tiempo_parada_box) as Tiempo
    FROM MARCO_AND_FRIENDS.BI_Parada P
    LEFT JOIN MARCO_AND_FRIENDS.BI_Circuito C ON P.codigo_circuito = C.codigo_circuito
    GROUP BY C.nombre_circuito
    ORDER BY SUM(tiempo_parada_box) DESC 
GO 

-- Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_PELIGROSOS] AS
    SELECT TOP 3 F.anio, C.nombre_circuito, COUNT(*) as Cantidad
    FROM MARCO_AND_FRIENDS.BI_Incidente I
    LEFT JOIN MARCO_AND_FRIENDS.BI_Circuito C ON I.codigo_circuito = C.codigo_circuito
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = I.fecha_incidente
    GROUP BY F.anio, C.nombre_circuito
    ORDER BY Cantidad DESC
GO

-- Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_PROMEDIO_INCIDENTES_ESCUDERIA_POR_ANIO_POR_SECTOR] AS
    SELECT Escuderia, Tipo_Sector, AVG(Cant_Incidentes) as Promedio_Por_Anio
    FROM(
    SELECT  E.nombre_escuderia as Escuderia,
            S.descripcion as Tipo_Sector,
            F.anio as Anio,
            COUNT(*) as Cant_Incidentes
    FROM    MARCO_AND_FRIENDS.BI_Incidente I
    LEFT JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = I.codigo_escuderia
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tipo_Sector S ON S.codigo_tipo_sector = I.tipo_sector
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = I.fecha_incidente
    GROUP BY E.nombre_escuderia, S.descripcion, F.anio
    ) B
    GROUP BY Escuderia, Tipo_Sector
GO

-- Cantidad de paradas por circuito por escudería por año.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO] AS
    SELECT
        E.nombre_escuderia,
        C.nombre_circuito,
        F.anio,
        COUNT(*) AS cantidad_paradas
    FROM MARCO_AND_FRIENDS.BI_Parada PB
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = PB.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = PB.codigo_escuderia
	JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = PB.fecha_parada
    GROUP BY E.nombre_escuderia, C.nombre_circuito, F.anio
GO

-- Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_MAX_VELOCIDAD_POR_AUTO_POR_TIPO_SECTOR_POR_CIRCUITO] AS
    SELECT
        C.nombre_circuito,
        TS.descripcion AS tipo_sector,
        A.modelo_auto,
        MAX(T.velocidad) AS velocidad_maxima
    FROM MARCO_AND_FRIENDS.BI_Telemetria T
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON T.codigo_circuito = C.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Auto A ON T.codigo_auto = A.codigo_auto
    JOIN MARCO_AND_FRIENDS.BI_Tipo_Sector TS ON T.tipo_sector = TS.codigo_tipo_sector
    GROUP BY C.nombre_circuito, TS.descripcion, A.modelo_auto
GO

-- Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TIEMPO_PROMEDIO_PARADAS_POR_CUATRIMESTRE] AS
    SELECT  E.nombre_escuderia as Escuderia,
            F.anio as Anio,
            F.cuatrimestre as Cuatrimestre,
            AVG(P.tiempo_parada_box) as Tiempo_Promedio
    FROM    MARCO_AND_FRIENDS.BI_Parada P
    LEFT JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = P.codigo_escuderia
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = P.fecha_parada
    GROUP BY E.nombre_escuderia, F.anio, F.cuatrimestre
GO

-- Los 3 circuitos con mayor consumo de combustible promedio
CREATE VIEW [MARCO_AND_FRIENDS].[BI_CIRCUITOS_CON_MAYOR_CONSUMO_DE_COMBUSTIBLE_PROMEDIO] AS
    SELECT TOP 3
        C.codigo_circuito,
        AVG(SS.PROMEDIO) AS PROMEDIO
    FROM
            (SELECT codigo_circuito as CIRCUITO, MARCO_AND_FRIENDS.CONSUMO_CIRCUITO_AUTO(codigo_auto, codigo_circuito) as PROMEDIO from MARCO_AND_FRIENDS.BI_Telemetria
            group by codigo_circuito, codigo_auto) AS SS
            JOIN MARCO_AND_FRIENDS.BI_Circuito C ON SS.CIRCUITO = C.codigo_circuito
    GROUP BY C.codigo_circuito
    ORDER BY 2 DESC
GO

-- Desgaste promedio de cada componente de cada auto por vuelta por circuito. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_DESGASTE_PROMEDIO_AUTO_POR_VUELTA_POR_CIRCUITO] AS
	SELECT
		C.nombre_circuito, A.codigo_auto, A.modelo_auto,
		AVG(SS.dgt_motor)		AS promedio_desgaste_motor,
		AVG(dgt_caja)			AS promedio_desgaste_caja,
		AVG(dgt_freno1)			AS promedio_desgaste_freno1,
		AVG(dgt_freno2)			AS promedio_desgaste_freno2,
		AVG(dgt_freno3)			AS promedio_desgaste_freno3,
		AVG(dgt_freno4)			AS promedio_desgaste_freno4,
		AVG(dgt_neu1)			AS promedio_desgaste_neumatico1,
		AVG(dgt_neu2)			AS promedio_desgaste_neumatico2,
		AVG(dgt_neu3)			AS promedio_desgaste_neumatico3,
		AVG(dgt_neu4)			AS promedio_desgaste_neumatico4
	FROM (SELECT 
		codigo_circuito, codigo_auto, numero_vuelta,
		MAX(potencia_motor) - MIN(potencia_motor)						as dgt_motor,
		MAX(desgaste_caja) - MIN(desgaste_caja)							as dgt_caja,
	
		MAX(grosor_pastilla1) - MIN(grosor_pastilla1)					as dgt_freno1,
		MAX(grosor_pastilla2) - MIN(grosor_pastilla2)					as dgt_freno2,
		MAX(grosor_pastilla3) - MIN(grosor_pastilla3)					as dgt_freno3,
		MAX(grosor_pastilla4) - MIN(grosor_pastilla4)					as dgt_freno4,
	
		MAX(profundidad_neumatico1) - MIN(profundidad_neumatico1)		as dgt_neu1,
		MAX(profundidad_neumatico2) - MIN(profundidad_neumatico2)		as dgt_neu2,
		MAX(profundidad_neumatico3) - MIN(profundidad_neumatico3)		as dgt_neu3,
		MAX(profundidad_neumatico4) - MIN(profundidad_neumatico4)		as dgt_neu4
			
		FROM [MARCO_AND_FRIENDS].[BI_Telemetria]
		GROUP BY codigo_circuito, codigo_auto, numero_vuelta
		) AS SS
		JOIN MARCO_AND_FRIENDS.BI_Auto A ON SS.codigo_auto = A.codigo_auto
		JOIN MARCO_AND_FRIENDS.BI_Circuito C ON SS.codigo_circuito = C.codigo_circuito 
	GROUP BY C.nombre_circuito, A.codigo_auto, A.modelo_auto
GO