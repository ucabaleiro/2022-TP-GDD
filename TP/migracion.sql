USE [GD1C2022]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Carrera] (
    [codigo_carrera] int NOT NULL IDENTITY PRIMARY KEY,
    [fecha_carrera] date NOT NULL,
    [clima_carrera] nvarchar(100) NOT NULL,
    [total_carrera] decimal(18,2) NOT NULL,
    [cantidad_vueltas_carrera] int NOT NULL
)
GO

CREATE TABLE [dbo].[Circuito] (
    [codigo_circuito] int NOT NULL IDENTITY PRIMARY KEY,
    [nombre_circuito] nvarchar(255) NOT NULL,
    [pais_circuito] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [dbo].[Sector] (
    [codigo_sector] int NOT NULL IDENTITY PRIMARY KEY,
    [codigo_circuito] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Circuito] ([codigo_circuito]),
    [distancia_sector] decimal(18,2) NOT NULL,
    [tipo_sector] nvarchar(255) NOT NULL,
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
    [codigo_sector] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Sector] ([codigo_sector]),
    [codigo_auto] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto],
    [bandera_incidente] nvarchar(255) NOT NULL,
    [tipo_incidente] nvarchar(255) NOT NULL,
    [tiempo_incidente] decimal(18,2) NOT NULL,
    [numero_vuelta] decimal(18,0) NOT NULL
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
    [modelo_neumatico] nvarchar(255) NOT NULL
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
    [codigo_sector] int NOT NULL FOREIGN KEY REFERENCES [dbo].[Sector] ([codigo_sector]),
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
    [combustible_auto] decimal(18,2) NOT NULL
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
GROUP BY TELE_MOTOR_NRO_SERIE, TELE_MOTOR_MODELO
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
SELECT  TELE_MOTOR_NRO_SERIE, 
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
GROUP BY TELE_MOTOR_NRO_SERIE, 
        TELE_MOTOR_POTENCIA, 
        TELE_MOTOR_RPM, 
        TELE_MOTOR_TEMP_ACEITE, 
        TELE_MOTOR_TEMP_AGUA
GO

-- Caja

-- Neumatico

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
GROUP BY E.codigo_escuderia, AUTO_MODELO, AUTO_NUMERO
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
GROUP BY A.codigo_auto, PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_NACIONALIDAD, PILOTO_FECHA_NACIMIENTO
GO

-- Circuito

-- Freno
