USE [GD1C2022]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* Comienzo Drop Tablas Prelimpieza */

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

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_PELIGROSOS]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_PELIGROSOS];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_PROMEDIO_INCIDENTES_ESCUDERIA_POR_ANIO_POR_SECTOR]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_PROMEDIO_INCIDENTES_ESCUDERIA_POR_ANIO_POR_SECTOR];
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO]') and type in (N'V'))
DROP VIEW [MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO];
GO

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
    [numero_vuelta] decimal (18,0) NOT NULL,
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
    [numero_vuelta]
)
SELECT  T.codigo_telemetria_auto,
        [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        C.codigo_circuito,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](S.tipo_sector),
        A.codigo_escuderia,
        T.codigo_auto,
        Pil.codigo_piloto,
        T.tiempo_vuelta_auto,
        T.num_vuelta_auto
FROM MARCO_AND_FRIENDS.Telemetria_Auto T
LEFT JOIN MARCO_AND_FRIENDS.Carrera C ON C.codigo_carrera = T.codigo_carrera
LEFT JOIN MARCO_AND_FRIENDS.Sector S ON S.codigo_sector = T.codigo_sector AND S.codigo_circuito = T.codigo_circuito
LEFT JOIN MARCO_AND_FRIENDS.Auto A ON A.codigo_auto = T.codigo_auto
LEFT JOIN MARCO_AND_FRIENDS.Piloto Pil ON Pil.codigo_auto = T.codigo_auto
GO

/* Creacion de vistas */

-- Mejor tiempo de vuelta de cada escudería por circuito por año. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS] AS
	SELECT
        F.anio,
		E.nombre_escuderia,
        C.codigo_circuito,
        MIN(T.tiempo_vuelta) as Tiempo
	FROM MARCO_AND_FRIENDS.BI_Telemetria T
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = T.fecha_telemetria
    LEFT JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = T.codigo_escuderia
    LEFT JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = T.codigo_circuito
    GROUP BY F.anio, E.nombre_escuderia, C.codigo_circuito
GO

-- Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES] AS
    SELECT TOP 3 C.nombre_circuito
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
    SELECT  F.anio,
            E.nombre_escuderia as Escuderia,
            S.descripcion as Tipo_Sector,
            AVG(COUNT(*)/*Cant. Incidentes x Escuderia x Sector x Cuatrimestre */) as Promedio_Incidentes
    FROM    MARCO_AND_FRIENDS.BI_Incidente I
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = I.fecha_incidente
    LEFT JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = I.codigo_escuderia
    LEFT JOIN MARCO_AND_FRIENDS.BI_Tipo_Sector S ON S.codigo_tipo_sector = I.tipo_sector
    GROUP BY F.anio, E.nombre_escuderia, S.descripcion
GO

-- Cantidad de paradas por circuito por escudería por año.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO] AS
    SELECT
        COUNT(*) AS cantidad_paradas,
        C.nombre_circuito,
        E.nombre_escuderia,
        F.anio
    FROM MARCO_AND_FRIENDS.BI_Parada PB
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = PB.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = PB.codigo_escuderia
	JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = PB.fecha_parada
    GROUP BY E.nombre_escuderia, C.nombre_circuito, F.anio
GO

-- Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito.


-- Los 3 circuitos con mayor consumo de combustible promedio
