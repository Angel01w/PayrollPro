USE [PayrollPro]
GO

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

INSERT INTO [dbo].[Departamentos] (Nombre, Ubicacion, Responsable_Area) VALUES
('Recursos Humanos', 'Piso 1', 'Patricia Encarnación'),
('Finanzas', 'Piso 3', 'Jorge Bisonó'),
('Marketing', 'Piso 3', 'Laura Paredes'),
('Ventas', 'Piso 3', 'Carlos Casals'),
('Atención al Cliente', 'Piso 1', 'Paula Sánchez'),
('Tecnología', 'Piso 4', 'Juan Contreras'),
('Logística', 'Piso 4', 'Angel Jiménez'),
('Producción', 'Piso 2', 'Luis Rodríguez'),
('Compras', 'Piso 2', 'Sofía Hernández'),
('Administración', 'Piso 4', 'Miguel Santos'),
('Comunicación', 'Piso 3', 'Amelia Moreno'),
('Planificación', 'Piso 4', 'Jorge Ortega');

SELECT * FROM [dbo].[Departamentos]



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

INSERT INTO [dbo].[Empleados] (Cedula, Nombre, Id_Departamento, Id_Puesto, Salario, Id_Tipo_Ingreso)
VALUES
('001-1409874-9', 'Carla Matos', 1, 1, 60000, 1),
('001-1789632-5', 'Jorge Mesa', 6, 4, 55000, 1),
('402-3547895-8', 'Lia Batista', 5, 11, 38000, 1),
('402-7459815-2', 'Eduardo Gomez', 6, 12, 40000, 1),
('002-1019682-1', 'Viana Salomón', 6, 4, 40000, 8),
('402-7804198-6', 'Camila Vargas', 3, 3, 55000, 1),
('402-3033972-3', 'Diana Moreno', 10, 10, 38000, 1),
('003-3458896-5', 'Cristian Cedeño', 12, 13, 60000, 11),
('001-1277634-4', 'Frank Encarnación', 8, 8, 45000, 2);

SELECT * FROM [dbo].[Empleados]



CREATE TABLE [dbo].[Puestos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Nivel_Riesgo] [varchar](50) NOT NULL,
	[Nivel_Min_Salario] [decimal](18, 0) NULL,
	[Nivel_Max_Salario] [decimal](18, 0) NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[Puestos] (Descripcion, Nivel_Riesgo, Nivel_Min_Salario, Nivel_Max_Salario)
VALUES
('Gerente General', 'Alto', 65000, 100000),
('Analista Financiero', 'Medio', 50000, 80000),
('Especialista en Marketing', 'Bajo', 40000, 70000),
('Desarrollador de Software', 'Medio', 45000, 90000),
('Ejecutivo de Ventas', 'Bajo', 40000, 68000),
('Jefe de Logística', 'Medio', 50000, 80000),
('Comprador', 'Bajo', 42000, 70000),
('Supervisor de Producción', 'Alto', 48000, 78000),
('Investigador', 'Alto', 55000, 90000),
('Asistente Administrativo', 'Bajo', 38000, 62000),
('Representante de Servicio al Cliente', 'Bajo', 35000, 60000),
('Técnico de Mantenimiento', 'Medio', 40000, 68000),
('Especialista en Innovación', 'Alto', 53000, 90000);

SELECT * FROM [dbo].[Puestos]



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

INSERT INTO [dbo].[Registro Transacciones] (Id_Empleado, Id_Ingreso, Tipo_Transaccion, Fecha, Monto, Estado)
VALUES
(1, 1, 'Salario', '2023-01-15', 60000, 'Completado'),
(2, 4, 'Salario', '2023-01-31', 55000, 'Completado'),
(3, 11, 'Salario', '2023-02-15', 38000, 'Completado'),
(4, 4, 'Salario', '2023-02-28', 40000, 'Completado'),
(5, 8, 'Salario', '2023-03-15', 40000, 'Completado'),
(6, 3, 'Salario', '2023-03-31', 55000, 'Completado'),
(7, 10, 'Salario', '2023-04-15', 38000, 'Completado'),
(8, 12, 'Salario', '2023-04-30', 60000, 'Completado'),
(9, 2, 'Salario', '2023-05-15', 45000, 'Completado'),
(2, 4, 'Bono', '2023-06-15', 4500, 'Completado'),
(3, 11, 'Bono', '2023-06-30', 3000, 'Completado'),
(4, 4, 'Bono', '2023-07-15', 3500, 'Completado'),
(5, 8, 'Bono', '2023-07-31', 3500, 'Completado'),
(6, 3, 'Bono', '2023-08-15', 4500, 'Completado'),
(7, 10, 'Bono', '2023-08-31', 3000, 'Completado'),
(9, 2, 'Bono', '2023-09-30', 3500, 'Completado'),
(1, 1, 'Comisión', '2023-10-15', 2000, 'Completado'),
(4, 4, 'Comisión', '2023-11-30', 1200, 'Completado'),
(6, 3, 'Comisión', '2023-12-31', 1500, 'Completado'),
(8, 12, 'Comisión', '2024-01-31', 2000, 'Completado'),
(9, 2, 'Comisión', '2024-02-15', 1200, 'Completado');

SELECT * FROM [dbo].[Registro Transacciones]



CREATE TABLE [dbo].[Tipos de deducciones](
	[Id] [int] NULL,
	[Descripcion] [varchar](50) NULL,
	[Tipo_Descuentos] [varchar](50) NULL,
	[Estado] [varchar](50) NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[Tipos de deducciones] (Id, Descripcion, Tipo_Descuentos, Estado)
VALUES
(1, 'Seguro Médico', 'Fijo', 'Activo'),
(2, 'Impuesto Sobre la Renta', 'Variable', 'Activo'),
(3, 'Aporte de Pensión', 'Fijo', 'Activo'),
(4, 'Seguro de Vida', 'Fijo', 'Activo'),
(5, 'Préstamo', 'Variable', 'Activo'),
(6, 'Cuota Sindical', 'Fijo', 'Activo'),
(7, 'Fondo de Ahorro', 'Variable', 'Inactivo'),
(8, 'Multa', 'Variable', 'Inactivo'),
(9, 'Adelanto de Sueldo', 'Variable', 'Activo'),
(10, 'Gastos Médicos', 'Fijo', 'Activo'),
(11, 'Seguro de Automóvil', 'Fijo', 'Activo'),
(12, 'Gastos de Viaje', 'Variable', 'Activo'),
(13, 'Gastos de Capacitación', 'Variable', 'Activo');

SELECT * FROM [dbo].[Tipos de deducciones]



CREATE TABLE [dbo].[Tipos de ingreso](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Tipo_Salario] [varchar](50) NULL,
	[Estado] [varchar](50) NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[Tipos de ingreso] (Descripcion, Tipo_Salario, Estado)
VALUES
('Salario Base', 'Fijo', 'Activo'),
('Bono', 'Fijo', 'Activo'),
('Comisión', 'Variable', 'Activo'),
('Horas Extra', 'Fijo', 'Activo'),
('Incentivo', 'Variable', 'Activo'),
('Bono de Desempeño', 'Variable', 'Activo'),
('Viáticos', 'Variable', 'Activo'),
('Pago por Proyecto', 'Variable', 'Activo'),
('Prima Vacacional', 'Fijo', 'Activo'),
('Gratificación', 'Variable', 'Activo'),
('Honorarios', 'Fijo', 'Activo'),
('Pago Adicional', 'Variable', 'Activo'),
('Aguinaldo', 'Fijo', 'Activo'),
('Compensación', 'Variable', 'Activo'),
('Otros Ingresos', 'Variable', 'Activo');

SELECT * FROM [dbo].[Tipos de ingreso]
