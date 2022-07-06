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
    [fecha_incidente] int NOT NULL,
    [codigo_circuito] int NOT NULL,
    [tipo_sector] int NOT NULL,
    [codigo_escuderia] int NOT NULL,
    [codigo_piloto] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [tipo_incidente] int NOT NULL,
    [cantidad_incidentes] int NOT NULL,

    CONSTRAINT PK_BI_INCIDENTE PRIMARY KEY (fecha_incidente, codigo_circuito, tipo_sector, codigo_escuderia, codigo_piloto, codigo_auto, tipo_incidente)
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Parada] (
    [fecha_parada] int NOT NULL,
    [codigo_circuito] int NOT NULL,
    [codigo_escuderia] int NOT NULL,
    [codigo_piloto] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [tiempo_total_parado] decimal(18,2) NOT NULL,
    [cantidad_paradas] int NOT NULL,

    CONSTRAINT PK_BI_PARADA PRIMARY KEY (fecha_parada, codigo_circuito, codigo_escuderia, codigo_piloto, codigo_auto)
)
GO

CREATE TABLE [MARCO_AND_FRIENDS].[BI_Telemetria] (
    [fecha_telemetria] int NOT NULL,
    [codigo_circuito] int NOT NULL,
    [codigo_escuderia] int NOT NULL,
    [codigo_piloto] int NOT NULL,
    [codigo_auto] int NOT NULL,
    [numero_vuelta] decimal(18,0) NOT NULL,
    [tipo_sector] int NOT NULL,
    [tipo_neumatico] int NOT NULL,
    [mejor_tiempo_vuelta] decimal(18,10) NOT NULL,
    [velocidad_maxima] decimal(18,2) NOT NULL,
    [consumo_combustible_promedio] decimal(18,2) NOT NULL,
    [desgaste_caja_promedio] decimal(18,2) NOT NULL,
    [desgaste_motor_promedio] decimal(18,6) NOT NULL,
    [desgaste_freno1_promedio] decimal(18,2) NOT NULL,
    [desgaste_freno2_promedio] decimal(18,2) NOT NULL,
    [desgaste_freno3_promedio] decimal(18,2) NOT NULL,
    [desgaste_freno4_promedio] decimal(18,2) NOT NULL,
    [desgaste_neumatico1_promedio] decimal(18,6) NOT NULL,
    [desgaste_neumatico2_promedio] decimal(18,6) NOT NULL,
    [desgaste_neumatico3_promedio] decimal(18,6) NOT NULL,
    [desgaste_neumatico4_promedio] decimal(18,6) NOT NULL,
    CONSTRAINT PK_BI_TELEMETRIA PRIMARY KEY (fecha_telemetria, codigo_circuito, codigo_escuderia, codigo_piloto, codigo_auto, numero_vuelta, tipo_sector, tipo_neumatico)
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
    [fecha_parada],
    [codigo_circuito],
    [codigo_escuderia],
    [codigo_piloto],
    [codigo_auto],
    [tiempo_total_parado],
    [cantidad_paradas]
)
SELECT  [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        C.codigo_circuito,
        A.codigo_escuderia,
        Pil.codigo_piloto,
        A.codigo_auto,
        SUM(Par.tiempo_parada_box),
        COUNT(DISTINCT Par.codigo_parada_box)
FROM MARCO_AND_FRIENDS.Parada_Box Par
LEFT JOIN MARCO_AND_FRIENDS.Carrera C ON Par.codigo_carrera = C.codigo_carrera
LEFT JOIN MARCO_AND_FRIENDS.Auto A ON Par.codigo_auto = A.codigo_auto
LEFT JOIN MARCO_AND_FRIENDS.Piloto Pil ON Pil.codigo_auto = A.codigo_auto
GROUP BY [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        C.codigo_circuito,
        A.codigo_escuderia,
        Pil.codigo_piloto,
        A.codigo_auto
GO

INSERT INTO [MARCO_AND_FRIENDS].[BI_Incidente](
    [fecha_incidente],
    [codigo_circuito],
    [tipo_sector],
    [codigo_escuderia],
    [codigo_piloto],
    [codigo_auto],
    [tipo_incidente],
    [cantidad_incidentes]
)
SELECT  [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera),
        I.codigo_circuito,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](S.tipo_sector),
        A.codigo_escuderia,
        P.codigo_piloto,
        A.codigo_auto,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_INCIDENTE](IA.tipo_incidente),
        COUNT(DISTINCT I.codigo_incidente+A.codigo_auto)
FROM MARCO_AND_FRIENDS.Incidente_Auto IA
JOIN MARCO_AND_FRIENDS.Incidente I ON I.codigo_incidente = IA.codigo_incidente
JOIN MARCO_AND_FRIENDS.Carrera C ON C.codigo_carrera = I.codigo_carrera
JOIN MARCO_AND_FRIENDS.Sector S ON S.codigo_sector = I.codigo_sector AND S.codigo_circuito = I.codigo_circuito
JOIN MARCO_AND_FRIENDS.Auto A ON A.codigo_auto = IA.codigo_auto
JOIN MARCO_AND_FRIENDS.Piloto P ON P.codigo_auto = A.codigo_auto
GROUP BY    [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](C.fecha_carrera), 
            I.codigo_circuito, 
            [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](S.tipo_sector),
            A.codigo_escuderia,
            P.codigo_piloto,
            A.codigo_auto,
            [MARCO_AND_FRIENDS].[GET_PK_TIPO_INCIDENTE](IA.tipo_incidente)
GO

WITH datosTelePorSector (
    fecha,
    codigo_circuito,
    codigo_escuderia,
    codigo_piloto,
    codigo_auto,
    nro_vuelta,
    cod_sector,
    tipo_neumatico,
    tiempo_vuelta,
    velocidad_maxima,
    gasto_combustible,
    desgaste_caja,
    desgaste_motor,
    desgaste_freno1,
    desgaste_freno2,
    desgaste_freno3,
    desgaste_freno4,
    desgaste_neumatico1,
    desgaste_neumatico2,
    desgaste_neumatico3,
    desgaste_neumatico4
) 
AS (
    SELECT
        C.fecha_carrera,
        C.codigo_circuito,
        A.codigo_escuderia,
        Pil.codigo_piloto,
        T.codigo_auto,
        T.num_vuelta_auto,
        S.tipo_sector,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_NEUMATICO](N.tipo_neumatico),
        (
            SELECT MAX(T1.tiempo_vuelta_auto)
            FROM MARCO_AND_FRIENDS.Telemetria_Auto T1
            WHERE T1.codigo_auto = T.codigo_auto
            AND T1.num_vuelta_auto = T.num_vuelta_auto
            AND T1.codigo_carrera = T.codigo_carrera
        ) AS [tiempo_vuelta],
        MAX(T.velocidad_auto),
        MAX(T.combustible_auto) - MIN(T.combustible_auto),
        MAX(TC.desgaste_caja) - MIN(TC.desgaste_caja),
        MAX(TM.potencia_motor) - MIN(TM.potencia_motor),
        MAX(TF1.grosor_pastilla) - MIN(TF1.grosor_pastilla),
        MAX(TF2.grosor_pastilla) - MIN(TF2.grosor_pastilla),
        MAX(TF3.grosor_pastilla) - MIN(TF3.grosor_pastilla),
        MAX(TF4.grosor_pastilla) - MIN(TF4.grosor_pastilla),
        MAX(TN1.profundidad_neumatico) - MIN(TN1.profundidad_neumatico),
        MAX(TN2.profundidad_neumatico) - MIN(TN2.profundidad_neumatico),
        MAX(TN3.profundidad_neumatico) - MIN(TN3.profundidad_neumatico),
        MAX(TN4.profundidad_neumatico) - MIN(TN4.profundidad_neumatico)
    FROM MARCO_AND_FRIENDS.Telemetria_Auto T
        JOIN MARCO_AND_FRIENDS.Carrera C ON C.codigo_carrera = T.codigo_carrera
        JOIN MARCO_AND_FRIENDS.Sector S ON S.codigo_sector = T.codigo_sector AND S.codigo_circuito = T.codigo_circuito
        JOIN MARCO_AND_FRIENDS.Auto A ON A.codigo_auto = T.codigo_auto
        JOIN MARCO_AND_FRIENDS.Piloto Pil ON Pil.codigo_auto = T.codigo_auto
        JOIN MARCO_AND_FRIENDS.Telemetria_Caja TC ON TC.codigo_telemetria_caja = T.codigo_telemetria_caja
        JOIN MARCO_AND_FRIENDS.Telemetria_Motor TM ON TM.codigo_telemetria_motor = T.codigo_telemetria_motor
        JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF1 ON TF1.codigo_telemetria_freno = T.codigo_tele_freno1
        JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF2 ON TF2.codigo_telemetria_freno = T.codigo_tele_freno2
        JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF3 ON TF3.codigo_telemetria_freno = T.codigo_tele_freno3
        JOIN MARCO_AND_FRIENDS.Telemetria_Freno TF4 ON TF4.codigo_telemetria_freno = T.codigo_tele_freno4
        JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN1 ON TN1.codigo_telemetria_neumatico = T.codigo_tele_neumatico1
        JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN2 ON TN2.codigo_telemetria_neumatico = T.codigo_tele_neumatico2
        JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN3 ON TN3.codigo_telemetria_neumatico = T.codigo_tele_neumatico3
        JOIN MARCO_AND_FRIENDS.Telemetria_Neumatico TN4 ON TN4.codigo_telemetria_neumatico = T.codigo_tele_neumatico4
        JOIN MARCO_AND_FRIENDS.NEUMATICO N ON N.num_serie_neumatico = TN4.num_serie_neumatico
    GROUP BY
        T.codigo_carrera,
        C.fecha_carrera,
        C.codigo_circuito,
        A.codigo_escuderia,
        Pil.codigo_piloto,
        T.codigo_auto,
        T.num_vuelta_auto,
        S.tipo_sector,
        [MARCO_AND_FRIENDS].[GET_PK_TIPO_NEUMATICO](N.tipo_neumatico)
),
datosTelePorTipoSector (
    fecha,
    codigo_circuito,
    codigo_escuderia,
    codigo_piloto,
    codigo_auto,
    nro_vuelta,
    tipo_sector,
    tipo_neumatico,
    tiempo_vuelta,
    velocidad_maxima,
    gasto_combustible,
    desgaste_caja,
    desgaste_motor,
    desgaste_freno1,
    desgaste_freno2,
    desgaste_freno3,
    desgaste_freno4,
    desgaste_neumatico1,
    desgaste_neumatico2,
    desgaste_neumatico3,
    desgaste_neumatico4
) 
AS (
    SELECT  fecha,
            codigo_circuito,
            codigo_escuderia,
            codigo_piloto,
            codigo_auto,
            nro_vuelta,
            [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](cod_sector),
            tipo_neumatico,
            tiempo_vuelta,
            MAX(velocidad_maxima),
            SUM(gasto_combustible),
            SUM(desgaste_caja),
            SUM(desgaste_motor),
            SUM(desgaste_freno1),
            SUM(desgaste_freno2),
            SUM(desgaste_freno3),
            SUM(desgaste_freno4),
            SUM(desgaste_neumatico1),
            SUM(desgaste_neumatico2),
            SUM(desgaste_neumatico3),
            SUM(desgaste_neumatico4)
    FROM datosTelePorSector
    GROUP BY fecha, codigo_circuito, codigo_escuderia, codigo_piloto, codigo_auto, nro_vuelta,
             [MARCO_AND_FRIENDS].[GET_PK_TIPO_SECTOR](cod_sector), tipo_neumatico, tiempo_vuelta 
)
INSERT INTO [MARCO_AND_FRIENDS].[BI_Telemetria](
    [fecha_telemetria],
    [codigo_circuito],
    [codigo_escuderia],
    [codigo_piloto],
    [codigo_auto],
    [numero_vuelta],
    [tipo_sector],
    [tipo_neumatico],
    [mejor_tiempo_vuelta],
    [velocidad_maxima],
    [consumo_combustible_promedio],
    [desgaste_caja_promedio],
    [desgaste_motor_promedio],
    [desgaste_freno1_promedio],
    [desgaste_freno2_promedio],
    [desgaste_freno3_promedio],
    [desgaste_freno4_promedio],
    [desgaste_neumatico1_promedio],
    [desgaste_neumatico2_promedio],
    [desgaste_neumatico3_promedio],
    [desgaste_neumatico4_promedio]
)
SELECT  [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](fecha),
        codigo_circuito,
        codigo_escuderia,
        codigo_piloto,
        codigo_auto,
        nro_vuelta,
        tipo_sector,
        tipo_neumatico,
        MIN(tiempo_vuelta),
        MAX(velocidad_maxima),
        AVG(gasto_combustible),
        AVG(desgaste_caja),
        AVG(desgaste_motor),
        AVG(desgaste_freno1),
        AVG(desgaste_freno2),
        AVG(desgaste_freno3),
        AVG(desgaste_freno4),
        AVG(desgaste_neumatico1),
        AVG(desgaste_neumatico2),
        AVG(desgaste_neumatico3),
        AVG(desgaste_neumatico4)
FROM datosTelePorTipoSector
GROUP BY    [MARCO_AND_FRIENDS].[GET_PK_TIEMPO](fecha),
            codigo_circuito,
            codigo_escuderia,
            codigo_piloto,
            codigo_auto,
            nro_vuelta,
            tipo_sector,
            tipo_neumatico
GO

/* Creacion de vistas */

-- Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_TIEMPO_BOXES] AS
    SELECT TOP 3 C.nombre_circuito, SUM(tiempo_total_parado) as [Tiempo total parado en boxes]
    FROM MARCO_AND_FRIENDS.BI_Parada P
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON P.codigo_circuito = C.codigo_circuito
    GROUP BY C.nombre_circuito
    ORDER BY SUM(tiempo_total_parado) DESC 
GO 

-- Cantidad de paradas por circuito por escudería por año.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_CANTIDAD_PARADAS_POR_ESCUDERIA_POR_CIRCUITO] AS
    SELECT
        C.nombre_circuito,
        E.nombre_escuderia,
        F.anio,
        SUM(cantidad_paradas) AS [Cantidad de paradas del año]
    FROM MARCO_AND_FRIENDS.BI_Parada PB
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = PB.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = PB.codigo_escuderia
	JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = PB.fecha_parada
    GROUP BY C.nombre_circuito, E.nombre_escuderia, F.anio
GO

-- Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TIEMPO_PROMEDIO_PARADAS_POR_CUATRIMESTRE] AS
    SELECT  E.nombre_escuderia as Escuderia,
            F.anio as Anio,
            F.cuatrimestre as Cuatrimestre,
            SUM(tiempo_total_parado) / SUM(cantidad_paradas) as [Tiempo promedio en paradas del cuatrimestre]
    FROM    MARCO_AND_FRIENDS.BI_Parada P
    JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = P.codigo_escuderia
    JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = P.fecha_parada
    GROUP BY E.nombre_escuderia, F.anio, F.cuatrimestre
GO

-- Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_TOP_3_CIRCUITOS_PELIGROSOS] AS
    SELECT F.anio, C.nombre_circuito
    FROM MARCO_AND_FRIENDS.BI_Incidente I
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON I.codigo_circuito = C.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = I.fecha_incidente
    WHERE I.codigo_circuito IN (
        SELECT TOP 3 I1.codigo_circuito
        FROM MARCO_AND_FRIENDS.BI_Incidente I1
        JOIN MARCO_AND_FRIENDS.BI_Tiempo F1 ON F1.id_tiempo = I1.fecha_incidente
        GROUP BY F1.anio, I1.codigo_circuito
        ORDER BY SUM(cantidad_incidentes) DESC
    )
    GROUP BY F.anio, C.nombre_circuito
GO

-- Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_PROMEDIO_INCIDENTES_ESCUDERIA_POR_ANIO_POR_SECTOR] AS
    SELECT escuderia, sector, AVG(incidentes) as [Promedio de incidentes en año]
    FROM (
    SELECT E.nombre_escuderia as escuderia, F.anio as anio, S.descripcion as sector, SUM(cantidad_incidentes) as [incidentes]
    FROM MARCO_AND_FRIENDS.BI_Incidente
    JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = BI_Incidente.codigo_escuderia
    JOIN MARCO_AND_FRIENDS.BI_Tipo_Sector S ON S.codigo_tipo_sector = BI_Incidente.tipo_sector
    JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = BI_Incidente.fecha_incidente
    GROUP BY E.nombre_escuderia, F.anio, S.descripcion
    ) AS incidentesPorAnio
    GROUP BY escuderia, sector
GO

-- Mejor tiempo de vuelta de cada escudería por circuito por año. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_MEJORES_TIEMPOS_ESCUDERIAS] AS
	SELECT  E.nombre_escuderia, C.nombre_circuito, F.anio, 
            MIN(mejor_tiempo_vuelta) as [Mejor tiempo de vuelta]
    FROM MARCO_AND_FRIENDS.BI_Telemetria
    JOIN MARCO_AND_FRIENDS.BI_Escuderia E ON E.codigo_escuderia = BI_Telemetria.codigo_escuderia
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = BI_Telemetria.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Tiempo F ON F.id_tiempo = BI_Telemetria.fecha_telemetria
    GROUP BY E.nombre_escuderia, C.nombre_circuito, F.anio
GO

-- Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito.
CREATE VIEW [MARCO_AND_FRIENDS].[BI_MAX_VELOCIDAD_POR_AUTO_POR_TIPO_SECTOR_POR_CIRCUITO] AS
    SELECT
        A.modelo_auto,
        A.numero_auto,
        C.nombre_circuito,
        TS.descripcion AS tipo_sector,
        MAX(T.velocidad_maxima) AS velocidad_maxima
    FROM MARCO_AND_FRIENDS.BI_Telemetria T
    JOIN MARCO_AND_FRIENDS.BI_Circuito C ON T.codigo_circuito = C.codigo_circuito
    JOIN MARCO_AND_FRIENDS.BI_Auto A ON T.codigo_auto = A.codigo_auto
    JOIN MARCO_AND_FRIENDS.BI_Tipo_Sector TS ON T.tipo_sector = TS.codigo_tipo_sector
    GROUP BY A.modelo_auto, A.numero_auto, C.nombre_circuito, TS.descripcion
GO

-- Los 3 circuitos con mayor consumo de combustible promedio
CREATE VIEW [MARCO_AND_FRIENDS].[BI_CIRCUITOS_CON_MAYOR_CONSUMO_DE_COMBUSTIBLE_PROMEDIO] AS
    SELECT TOP 3
        SS.cod_circuito,
        SS.nombre_circuito,
        AVG(SS.consumoPromedioCircuitoIndividual) AS PROMEDIO_CONSUMO_HISTORICO
    FROM (
        SELECT  T.fecha_telemetria,
                T.codigo_circuito as cod_circuito, 
                C.nombre_circuito as nombre_circuito,
                T.codigo_escuderia,
                T.codigo_auto,
                T.codigo_piloto,
                SUM(consumo_combustible_promedio) AS consumoPromedioCircuitoIndividual
        FROM MARCO_AND_FRIENDS.BI_Telemetria T
        JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = T.codigo_circuito
        GROUP BY T.fecha_telemetria,
                T.codigo_circuito, 
                C.nombre_circuito,
                T.codigo_escuderia,
                T.codigo_auto,
                T.codigo_piloto
    ) AS SS
    GROUP BY        SS.cod_circuito,
                    SS.nombre_circuito
    ORDER BY AVG(consumoPromedioCircuitoIndividual) DESC
GO

-- Desgaste promedio de cada componente de cada auto por vuelta por circuito. 
CREATE VIEW [MARCO_AND_FRIENDS].[BI_DESGASTE_PROMEDIO_AUTO_POR_VUELTA_POR_CIRCUITO] AS
    SELECT 
        SS.codigo_auto,
        SS.numero_vuelta,
        SS.codigo_circuito,
        SS.nombre_circuito,
        AVG(dgt_caja)       [Desgaste caja],
        AVG(dgt_motor)      [Desgaste motor],
        AVG(dgt_freno1)     [Desgaste freno #1],
        AVG(dgt_freno2)     [Desgaste freno #2],
        AVG(dgt_freno3)     [Desgaste freno #3],
        AVG(dgt_freno4)     [Desgaste freno #4],
        AVG(dgt_neu1)       [Desgaste neumatico #1],
        AVG(dgt_neu2)       [Desgaste neumatico #2],
        AVG(dgt_neu3)       [Desgaste neumatico #3],
        AVG(dgt_neu4)       [Desgaste neumatico #4]
    FROM (
        SELECT 
            T.codigo_circuito,
            C.nombre_circuito,
            T.fecha_telemetria,
            T.codigo_auto,
            T.codigo_escuderia,
            T.codigo_piloto,
            T.numero_vuelta,
            SUM(T.desgaste_caja_promedio)   dgt_caja,
            SUM(T.desgaste_motor_promedio)  dgt_motor,
            SUM(T.desgaste_freno1_promedio)     dgt_freno1,
            SUM(T.desgaste_freno2_promedio)     dgt_freno2,
            SUM(T.desgaste_freno3_promedio)     dgt_freno3,
            SUM(T.desgaste_freno4_promedio)     dgt_freno4,
            SUM(T.desgaste_neumatico1_promedio)     dgt_neu1,
            SUM(T.desgaste_neumatico2_promedio)     dgt_neu2,
            SUM(T.desgaste_neumatico3_promedio)     dgt_neu3,
            SUM(T.desgaste_neumatico4_promedio)     dgt_neu4
        FROM MARCO_AND_FRIENDS.BI_Telemetria T
        JOIN MARCO_AND_FRIENDS.BI_Circuito C ON T.codigo_circuito = C.codigo_circuito
        GROUP BY    T.codigo_circuito,
                    C.nombre_circuito,
                    T.fecha_telemetria,
                    T.codigo_auto,
                    T.codigo_escuderia,
                    T.codigo_piloto,
                    T.numero_vuelta
    ) AS SS
    GROUP BY SS.codigo_circuito, SS.nombre_circuito, SS.numero_vuelta, SS.codigo_auto
GO