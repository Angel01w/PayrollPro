USE [PayrollPro]
GO

/****** Object:  Table [dbo].[Departamentos]    Script Date: 29/5/2024 4:52:50 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Departamentos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Ubicacion] [varchar](50) NULL,
	[Responsable_Area] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Empleados](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Cedula] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Id_Departamento] [int] NOT NULL,
	[Id_Puesto] [int] NOT NULL,
	[Salario] [decimal](18, 0) NULL,
	[Id_Tipo_Ingreso] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Puestos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Nivel_Riesgo] [varchar](50) NOT NULL,
	[Nivel_Min_Salario] [decimal](18, 0) NULL,
	[Nivel_Max_Salario] [decimal](18, 0) NULL
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Registro Transacciones](
	[Id_Transaccion] [int] IDENTITY(1,1) NOT NULL,
	[Id_Empleado] [int] NULL,
	[Id_Ingreso] [int] NULL,
	[Tipo_Transaccion] [varchar](50) NOT NULL,
	[Fecha] [datetime] NULL,
	[Monto] [decimal](18, 0) NULL,
	[Estado] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tipos de deducciones](
	[Id] [int] NULL,
	[Descripcion] [varchar](50) NULL,
	[Tipo_Descuentos] [varchar](50) NULL,
	[Estado] [varchar](50) NULL
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Tipos de ingreso](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Tipo_Salario] [varchar](50) NULL,
	[Estado] [varchar](50) NULL
) ON [PRIMARY]
GO