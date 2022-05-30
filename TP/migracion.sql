USE [GD1C2022]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Carrera] (
    [codigo_carrera][int] NOT NULL IDENTITY PRIMARY KEY,
    [fecha_carrera][date] NOT NULL,
    [clima_carrera][nvarchar(100)] NOT NULL,
    [total_carrera][decimal(18,2)] NOT NULL,
    [cantidad_vueltas_carrera][int] NOT NULL
)
GO

CREATE TABLE [dbo].[Circuito] (
    [codigo_circuito][int] NOT NULL IDENTITY PRIMARY KEY,
    [nombre_circuito][nvarchar(255)] NOT NULL,
    [pais_circuito][nvarchar(255)] NOT NULL
)
GO

CREATE TABLE [dbo].[Sector] (
    [codigo_sector][int] NOT NULL IDENTITY PRIMARY KEY,
    [codigo_circuito][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Circuito] ([codigo_circuito]),
    [distancia_sector][decimal(18,2)] NOT NULL,
    [tipo_sector][nvarchar(255)] NOT NULL,
)
GO

CREATE TABLE [dbo].[Incidente] (
    [codigo_incidente][int] NOT NULL IDENTITY PRIMARY KEY,
    [codigo_sector][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Sector] ([codigo_sector]),
    [bandera_incidente][nvarchar(255)] NOT NULL,
    [tipo_incidente][nvarchar(255)] NOT NULL,
    [tiempo_incidente][decimal(18,2)] NOT NULL,
)
GO

CREATE TABLE [dbo].[Escuderia] (
    [codigo_escuderia][int] NOT NULL IDENTITY PRIMARY KEY,
    [nombre_escuderia][nvarchar(255)] NOT NULL,
    [nacionalidad_escuderia][nvarchar(255)] NOT NULL,
)
GO

CREATE TABLE [dbo].[Auto] (
    [codigo_auto][int] NOT NULL IDENTITY PRIMARY KEY,
    [codigo_escuderia][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Escuderia] ([codigo_escuderia]),
    [modelo_auto][nvarchar(255)] NOT NULL,
    [numero_auto][int] NOT NULL
)
GO

CREATE TABLE [dbo].[Auto_Incidente] (
    [codigo_incidente][int] NOT NULL,
    [codigo_auto][int] NOT NULL,
    [numero_vuelta][decimal(18,0)] NOT NULL,
    CONSTRAINT PK_Auto_Incidente PRIMARY KEY ([codigo_incidente], [codigo_auto])
)
GO

CREATE TABLE [dbo].[Piloto] (
    [codigo_piloto][int] NOT NULL IDENTITY PRIMARY KEY,
    [codigo_auto][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto] ([codigo_auto]),
    [nombre_piloto][nvarchar(50)] NOT NULL,
    [apellido_piloto][nvarchar(50)] NOT NULL,
    [nacionalidad_piloto][nvarchar(50)] NOT NULL,
    [nacimiento_piloto][date] NOT NULL
)
GO

CREATE TABLE [dbo].[Neumatico] (
    [num_serie_neumatico][nvarchar(255)] NOT NULL PRIMARY KEY,
    [modelo_neumatico][nvarchar(255)] NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Neumatico] (
    [codigo_telemetria_neumatico][int] NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_neumatico][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [posicion_neumatico][nvarchar(255)] NOT NULL,
    [profundidad_neumatico][decimal(18,6)] NOT NULL,
    [temperatura_neumatico][decimal(18,6)] NOT NULL,
    [presion_neumatico][decimal(18,6)] NOT NULL,
)
GO

CREATE TABLE [dbo].[Parada_Box] (
    [codigo_parada_box][int] NOT NULL IDENTITY PRIMARY KEY,
    [codigo_auto][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto] ([codigo_auto]),
    [num_serie_viejo1][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_nuevo1][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_viejo2][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_nuevo2][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_viejo3][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_nuevo3][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_viejo4][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [num_serie_nuevo4][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Neumatico] ([num_serie_neumatico]),
    [codigo_carrera][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Carrera] ([codigo_carrera]),
    [numero_vuelta_box][decimal(18,0)] NOT NULL,
    [tiempo_parada_box][decimal(18,2)] NOT NULL
)
GO

CREATE TABLE [dbo].[Motor] (
    [num_serie_motor][nvarchar(255)] NOT NULL PRIMARY KEY,
    [modelo_motor][nvarchar(255)] NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Motor] (
    [codigo_telemetria_motor][int] NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_motor][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Motor] ([num_serie_motor]),
    [potencia_motor][decimal(18,6)] NOT NULL,
    [rpm_motor][decimal(18,6)] NOT NULL,
    [temp_aceite_motor][decimal(18,6)] NOT NULL,
    [temp_agua_motor][decimal(18,6)] NOT NULL
)
GO

CREATE TABLE [dbo].[Freno] (
    [num_serie_freno][nvarchar(255)] NOT NULL PRIMARY KEY,
    [tamanio_disco_freno][nvarchar(255)] NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Freno] (
    [codigo_telemetria_freno][int] NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_freno][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Freno] ([num_serie_freno]),
    [grosor_pastilla][decimal(18,2)] NOT NULL,
    [posicion_freno][nvarchar(255)] NOT NULL,
    [temperatura_freno][decimal(18,2)] NOT NULL
)
GO

CREATE TABLE [dbo].[Caja] (
    [num_serie_caja][nvarchar(255)] NOT NULL PRIMARY KEY,
    [modelo_caja][nvarchar(50)] NOT NULL,
)

CREATE TABLE [dbo].[Telemetria_Caja] (
    [codigo_telemetria_caja][int] NOT NULL IDENTITY PRIMARY KEY,
    [num_serie_caja][nvarchar(255)] NOT NULL FOREIGN KEY REFERENCES [dbo].[Caja] ([num_serie_caja]),
    [temp_aceite_caja][decimal(18,2)] NOT NULL,
    [rpm_caja][decimal(18,2)] NOT NULL,
    [desgaste_caja][decimal(18,2)] NOT NULL
)
GO

CREATE TABLE [dbo].[Telemetria_Auto] (
    [codigo_telemetria_auto][decimal(18,0)] NOT NULL PRIMARY KEY,
    [codigo_auto][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Auto] ([codigo_auto]),
    [codigo_carrera][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Carrera] ([codigo_carrera]),
    [codigo_sector][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Sector] ([codigo_sector]),
    [codigo_telemetria_caja][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Caja] ([codigo_telemetria_caja]),
    [codigo_telemetria_motor][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Motor] ([codigo_telemetria_motor]),
    [codigo_tele_freno1][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno2][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno3][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_freno4][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Freno] ([codigo_telemetria_freno]),
    [codigo_tele_neumatico1][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico2][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico3][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [codigo_tele_neumatico4][int] NOT NULL FOREIGN KEY REFERENCES [dbo].[Telemetria_Neumatico] ([codigo_telemetria_neumatico]),
    [num_vuelta_auto][decimal(18,0)] NOT NULL,
    [distancia_vuelta_auto][decimal(18,2)] NOT NULL,
    [distancia_carrera_auto][decimal(18,6)] NOT NULL,
    [posicion_auto][decimal(18,0)] NOT NULL,
    [tiempo_vuelta_auto][decimal(18,10)] NOT NULL,
    [velocidad_auto][decimal(18,2)] NOT NULL,
    [combustible_auto][decimal(18,2)] NOT NULL
)
GO