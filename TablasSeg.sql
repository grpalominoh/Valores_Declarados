 
/****** Object:  Schema [seg]    Script Date: 11/10/2018 02:15:12 p.m. ******/
CREATE SCHEMA [seg]
GO
/****** Object:  Table [seg].[Ajustador]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[Ajustador](
	[IdAjustador] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NOT NULL,
	[FechaInicioVigencia] [datetime] NOT NULL,
	[FechaFinalVigencia] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Ajustador] PRIMARY KEY CLUSTERED 
(
	[IdAjustador] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[Aseguradora]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[Aseguradora](
	[IdAseguradora] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NOT NULL,
	[FechaInicioVigencia] [datetime] NOT NULL,
	[FechaFinalVigencia] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Aseguradora] PRIMARY KEY CLUSTERED 
(
	[IdAseguradora] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[Broker]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[Broker](
	[IdBroker] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NOT NULL,
	[FechaInicioVigencia] [datetime] NOT NULL,
	[FechaFinalVigencia] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Broker_1] PRIMARY KEY CLUSTERED 
(
	[IdBroker] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[DivisionPoliza]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[DivisionPoliza](
	[IdDivisionPoliza] [smallint] IDENTITY(1,1) NOT NULL,
	[IdTipoPoliza] [smallint] NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[Abreviatura] [varchar](32) NOT NULL,
	[AplicaProveedor] [smallint] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_DivisionPoliza] PRIMARY KEY CLUSTERED 
(
	[IdDivisionPoliza] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[Instalacion]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[Instalacion](
	[IdInstalacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[IdDepartamento] [smallint] NOT NULL,
	[IdProvincia] [smallint] NOT NULL,
	[IdDistrito] [smallint] NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Instalacion] PRIMARY KEY CLUSTERED 
(
	[IdInstalacion] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[Poliza]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[Poliza](
	[IdPoliza] [int] IDENTITY(1,1) NOT NULL,
	[IdAseguradora] [int] NOT NULL,
	[IdBroker] [int] NOT NULL,
	[NroPoliza] [varchar](32) NOT NULL,
	[IdModalidadContratacion] [smallint] NOT NULL,
	[IdTipoPoliza] [smallint] NOT NULL,
	[IdDivisionPoliza] [smallint] NOT NULL,
	[FechaVigenciaInicio] [datetime] NOT NULL,
	[FechaVigenciaTermino] [datetime] NOT NULL,
	[PrimaTotalConcurso] [money] NOT NULL,
	[ImportePrimaActualizado] [money] NOT NULL,
	[IdPeriodoPrimaTotal] [smallint] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Poliza] PRIMARY KEY CLUSTERED 
(
	[IdPoliza] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaCoberturaDeducible]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaCoberturaDeducible](
	[IdPolizaCoberturaDeducible] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[Descripcion] [varchar](1024) NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[Importe] [money] NOT NULL,
	[DescripcionDeducible] [varchar](1024) NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaCoberturaDeducible] PRIMARY KEY CLUSTERED 
(
	[IdPolizaCoberturaDeducible] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaCoberturaSumaAsegurada]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaCoberturaSumaAsegurada](
	[IdPolizaCoberturaSumaAsegurada] [int] IDENTITY(1,1) NOT NULL,
	[IdPolizaCoberturaDeducible] [int] NOT NULL,
	[IdPolizaSumaAsegurada] [int] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaCoberturaSumaAsegurada] PRIMARY KEY CLUSTERED 
(
	[IdPolizaCoberturaSumaAsegurada] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaCronogramaPago]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaCronogramaPago](
	[IdPolizaCronogramaPago] [int] IDENTITY(1,1) NOT NULL,
	[IdPolizaPago] [int] NOT NULL,
	[Cuota] [smallint] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[NroFactura] [varchar](32) NULL,
	[FechaPago] [datetime] NULL,
	[RutaArchivo] [varchar](256) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaCronogramaPago] PRIMARY KEY CLUSTERED 
(
	[IdPolizaCronogramaPago] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaEndoso]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaEndoso](
	[IdPolizaEndoso] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[Descripcion] [varchar](512) NOT NULL,
	[FechaSolicitud] [datetime] NOT NULL,
	[FechaVigenciaInicio] [datetime] NOT NULL,
	[FechaVigenciaTermino] [datetime] NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[Importe] [money] NOT NULL,
	[IdTasaIGV] [smallint] NOT NULL,
	[PorcentajeDerechoAdmision] [decimal](12, 2) NULL,
	[ImporteDerechoAdmision] [money] NOT NULL,
	[ImporteIGV] [money] NOT NULL,
	[ImporteEndosoTotal] [money] NOT NULL,
	[IdTipoEndoso] [smallint] NOT NULL,
	[RutaArchivo] [varchar](256) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
	[IdTipoDocumento] [smallint] NULL,
	[NroDocumento] [varchar](32) NULL,
 CONSTRAINT [PK_PolizaEndoso] PRIMARY KEY CLUSTERED 
(
	[IdPolizaEndoso] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaObservacionAnotacion]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaObservacionAnotacion](
	[IdPolizaObsAno] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[Descripcion] [varchar](512) NOT NULL,
	[IdTipoRegistro] [smallint] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaObservacionAnotacion] PRIMARY KEY CLUSTERED 
(
	[IdPolizaObsAno] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaPago]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaPago](
	[IdPolizaPago] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[Descripcion] [varchar](512) NOT NULL,
	[NroCuotas] [smallint] NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[ImporteCuota] [money] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaPago] PRIMARY KEY CLUSTERED 
(
	[IdPolizaPago] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaPrima]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaPrima](
	[IdPolizaPrima] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[IdTasaIGV] [smallint] NOT NULL,
	[ImportePrimaNeta] [money] NOT NULL,
	[PorcentajeDerechoAdmision] [decimal](12, 2) NULL,
	[ImporteDerechoAdmision] [money] NOT NULL,
	[ImporteIGV] [money] NOT NULL,
	[ImportePrimaTotal] [money] NOT NULL,
	[EsPrimaConcurso] [smallint] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[PorcentajeParticipacion] [decimal](12, 2) NULL,
	[RutaArchivo] [varchar](256) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaPrima] PRIMARY KEY CLUSTERED 
(
	[IdPolizaPrima] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaProveedor]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaProveedor](
	[IdPolizaProveedor] [int] IDENTITY(1,1) NOT NULL,
	[IdAseguradora] [int] NULL,
	[IdContratoOrdenServicio] [int] NOT NULL,
	[IdTipoPoliza] [smallint] NOT NULL,
	[IdDivisionPoliza] [smallint] NOT NULL,
	[FechaVigenciaInicio] [datetime] NULL,
	[FechaVigenciaTermino] [datetime] NULL,
	[FechaVisacion] [datetime] NULL,
	[NumeroPersonal] [smallint] NULL,
	[NumeroListas] [smallint] NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaProveedor] PRIMARY KEY CLUSTERED 
(
	[IdPolizaProveedor] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaSumaAsegurada]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaSumaAsegurada](
	[IdPolizaSumaAsegurada] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[Descripcion] [varchar](1024) NOT NULL,
	[IdUnidadMedida] [smallint] NULL,
	[Cantidad] [decimal](12, 2) NULL,
	[IdMoneda] [smallint] NULL,
	[Importe] [money] NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaSumaAsegurada] PRIMARY KEY CLUSTERED 
(
	[IdPolizaSumaAsegurada] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[PolizaValorDeclarado]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[PolizaValorDeclarado](
	[IdPolizaValorDeclarado] [int] IDENTITY(1,1) NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[IdValorDeclaradoDetalleDisgregado] [int] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PolizaValorDeclarado] PRIMARY KEY CLUSTERED 
(
	[IdPolizaValorDeclarado] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SegurosControlAutorizacion]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seg].[SegurosControlAutorizacion](
	[IdSegurosControlAutorizacion] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[IdUUNN] [smallint] NULL,
	[IdProceso] [smallint] NOT NULL,
	[IdArea] [smallint] NOT NULL,
	[IdCargo] [smallint] NOT NULL,
	[IdTrabajadorSeguros] [int] NULL,
	[IdTrabajadorGAF] [int] NULL,
	[IdTrabajadorGR] [int] NULL,
	[IdTrabajadorGCAF] [int] NULL,
	[IdEstado] [smallint] NOT NULL,
 CONSTRAINT [PK_SegurosControlAutorizacion] PRIMARY KEY CLUSTERED 
(
	[IdSegurosControlAutorizacion] ASC
)  
)  

GO
/****** Object:  Table [seg].[SiniestroAjustador]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroAjustador](
	[IdSiniestroAjustador] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestro] [int] NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[IdPolizaCobertura] [int] NOT NULL,
	[IdAseguradora] [int] NOT NULL,
	[IdBroker] [int] NOT NULL,
	[IdAjustador] [int] NULL,
	[NroSiniestroAseguradora] [varchar](20) NULL,
	[NroSiniestroBroker] [varchar](20) NULL,
	[NroSiniestroAjustador] [varchar](20) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroAjustador] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroAjustador] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroElementoAfectado]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroElementoAfectado](
	[IdSiniestroElementoAfectado] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestro] [int] NOT NULL,
	[IdTipoElementoAfectado] [smallint] NOT NULL,
	[IdSubTipoElementoAfectado] [smallint] NOT NULL,
	[IdVehiculoConductor] [int] NULL,
	[IdTrabajador] [int] NULL,
	[IdElementoElectrico] [int] NULL,
	[IdInstalacion] [int] NULL,
	[IdPersona] [int] NULL,
	[Descripcion] [varchar](2048) NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroElementoAfectado] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroElementoAfectado] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroElementoAfectadoDetalle]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroElementoAfectadoDetalle](
	[IdSiniestroElementoAfectadoDetalle] [int] NOT NULL,
	[IdSiniestroElementoAfectado] [int] NOT NULL,
	[Descripcion] [varchar](1024) NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroElementoAfectadoDetalle] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroElementoAfectadoDetalle] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroLiquidacion]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroLiquidacion](
	[IdSiniestroLiquidacion] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[IdSiniestro] [int] NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroLiquidacion] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroLiquidacion] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroLiquidacionDetalle]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroLiquidacionDetalle](
	[IdSiniestroLiquidacionDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestroLiquidacionDetallePadre] [int] NULL,
	[IdSiniestroLiquidacion] [int] NOT NULL,
	[IdSiniestroPolizaCobertura] [int] NOT NULL,
	[IdPolizaCobertura] [int] NOT NULL,
	[IdAjustador] [int] NOT NULL,
	[FechaVersion] [datetime] NULL,
	[ImportePerdida] [money] NOT NULL,
	[ImporteAjustador] [money] NOT NULL,
	[ImporteLiquida] [money] NOT NULL,
	[ImporteDeducible] [money] NOT NULL,
	[ImporteIndemniza] [money] NOT NULL,
	[RutaFile] [varchar](256) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroLiquidacionDetalle_1] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroLiquidacionDetalle] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroLiquidacionReclamo]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroLiquidacionReclamo](
	[IdSiniestroLiquidacionReclamo] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestroLiquidacionDetalle] [int] NOT NULL,
	[ImportePerdida] [money] NOT NULL,
	[ImporteAjustador] [money] NOT NULL,
	[ImporteLiquida] [money] NOT NULL,
	[ImporteDeducible] [money] NOT NULL,
	[ImporteIndemniza] [money] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroLiquidacionReclamo] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroLiquidacionReclamo] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroPolizaCobertura]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroPolizaCobertura](
	[IdSiniestroPolizaCobertura] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestro] [int] NOT NULL,
	[IdPolizaCobertura] [int] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[ImporteAjustador] [money] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroPolizaCobertura] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroPolizaCobertura] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroRecupero]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroRecupero](
	[IdSiniestroRecupero] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestro] [int] NOT NULL,
	[IdPoliza] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroRecupero_1] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroRecupero] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroRecuperoDetalle]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroRecuperoDetalle](
	[IdSiniestroRecuperoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestroRecupero] [int] NOT NULL,
	[IdSiniestroLiquidacionDetalle] [int] NOT NULL,
	[IdTipoRecupero] [smallint] NOT NULL,
	[IdTipoBeneficiario] [smallint] NULL,
	[IdBanco] [smallint] NULL,
	[NroCheque] [varchar](64) NULL,
	[Descripcion] [varchar](512) NOT NULL,
	[IdMoneda] [smallint] NOT NULL,
	[Importe] [money] NOT NULL,
	[FechaRecepcionCheque] [datetime] NULL,
	[FechaEntregaRRFF] [datetime] NULL,
	[FechaReposicion] [datetime] NULL,
	[RutaFile] [varchar](256) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroRecuperoDetalle] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroRecuperoDetalle] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestroRequerimientoSustento]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestroRequerimientoSustento](
	[IdSiniestroRequerimientoSustento] [int] IDENTITY(1,1) NOT NULL,
	[IdSiniestroRequerimientoSustentoPadre] [int] NULL,
	[IdSiniestro] [int] NOT NULL,
	[Descripcion] [varchar](256) NOT NULL,
	[FechaRequerimiento] [datetime] NOT NULL,
	[PlazoAtencion] [smallint] NOT NULL,
	[FechaAtencion] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
	[RutaFile] [varchar](256) NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestroRequerimientoSustento] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroRequerimientoSustento] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[Siniestros]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[Siniestros](
	[IdSiniestro] [int] IDENTITY(1,1) NOT NULL,
	[Anio] [int] NOT NULL,
	[NroSiniestro] [char](11) NULL,
	[NroSiniestroArea] [varchar](20) NULL,
	[IdModalidadDeclaracion] [smallint] NOT NULL,
	[IdTrabajadorReporta] [int] NULL,
	[IdCargoTrabajadorReporta] [smallint] NULL,
	[IdAreaTrabajadorReporta] [smallint] NULL,
	[IdCentroCostoReporta] [smallint] NULL,
	[IdGerenciaReporta] [smallint] NULL,
	[IdUnidadNegocioReporta] [smallint] NULL,
	[FechaDeclaraUsuario] [datetime] NOT NULL,
	[FechaDeclaracion] [datetime] NULL,
	[IdDepartamento] [smallint] NULL,
	[IdProvincia] [smallint] NULL,
	[IdDistrito] [smallint] NULL,
	[Direccion] [varchar](128) NULL,
	[FechaHoraEvento] [datetime] NOT NULL,
	[DescripcionEvento] [varchar](2048) NOT NULL,
	[IdNivelCriticidad] [smallint] NOT NULL,
	[IdMoneda] [smallint] NULL,
	[ValorEstimado] [money] NULL,
	[PendienteEstimacion] [smallint] NULL,
	[FueReportadoBroker] [smallint] NOT NULL,
	[IdTipoCierre] [smallint] NULL,
	[FechaCierre] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
	[RutaFile] [varchar](256) NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Sinies] PRIMARY KEY CLUSTERED 
(
	[IdSiniestro] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[SiniestrosCorrelativo]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[SiniestrosCorrelativo](
	[IdSiniestroCorrelativo] [smallint] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[Anio] [int] NOT NULL,
	[Valor] [int] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_SiniestrosCorrelativo] PRIMARY KEY CLUSTERED 
(
	[IdSiniestroCorrelativo] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[TipoPolizaTipoValorDeclarado]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[TipoPolizaTipoValorDeclarado](
	[IdRegistro] [smallint] IDENTITY(1,1) NOT NULL,
	[IdTipoPoliza] [smallint] NOT NULL,
	[IdTipoValorDeclarado] [smallint] NOT NULL,
	[FechaVigenciaInicio] [datetime] NOT NULL,
	[FechaVigenciaTermino] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoPolizaTipoValorDeclarado] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[TipoValorDeclarado]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[TipoValorDeclarado](
	[IdTipoValorDeclarado] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Descripcion] [varchar](256) NOT NULL,
	[AfectaImporte] [smallint] NOT NULL,
	[AfectaCantidad] [smallint] NOT NULL,
	[PermiteCargaDetalle] [smallint] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoValorDeclarado] PRIMARY KEY CLUSTERED 
(
	[IdTipoValorDeclarado] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[ValorDeclarado]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[ValorDeclarado](
	[IdValorDeclarado] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [smallint] NOT NULL,
	[FechaVigenciaInicio] [datetime] NOT NULL,
	[FechaVigenciaTermino] [datetime] NULL,
	[RutaArchivo] [varchar](256) NULL,
	[IdMoneda] [smallint] NULL,
	[TipoCambio] [decimal](12, 4) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_ValorDeclarado] PRIMARY KEY CLUSTERED 
(
	[IdValorDeclarado] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[ValorDeclaradoAutorizacion]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seg].[ValorDeclaradoAutorizacion](
	[IdValorDeclaradoAutorizacion] [int] IDENTITY(1,1) NOT NULL,
	[IdValorDeclarado] [int] NOT NULL,
	[IdClaveUnica] [uniqueidentifier] NOT NULL,
	[IdProceso] [smallint] NOT NULL,
	[IdArea] [smallint] NOT NULL,
	[IdCargo] [smallint] NOT NULL,
	[IdTrabajador] [int] NOT NULL,
	[OrdenAutoriza] [smallint] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaAutorizacion] [datetime] NULL,
	[IdEstado] [smallint] NOT NULL,
 CONSTRAINT [PK_ValorDeclaradoAutorizacion] PRIMARY KEY CLUSTERED 
(
	[IdValorDeclaradoAutorizacion] ASC
)  
)  

GO
/****** Object:  Table [seg].[ValorDeclaradoDetalle]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[ValorDeclaradoDetalle](
	[IdValorDeclaradoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdValorDeclarado] [int] NOT NULL,
	[IdTipoValorDeclarado] [smallint] NOT NULL,
	[IdMoneda] [smallint] NULL,
	[ImporteValorDeclarado] [money] NULL,
	[ImporteAjustado] [money] NULL,
	[IdUnidadMedida] [smallint] NULL,
	[Cantidad] [decimal](12, 2) NULL,
	[CantidadAjustada] [decimal](12, 2) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[IdTipoRegistro] [smallint] NOT NULL,
	[IdPolizaEndoso] [int] NULL,
	[Descripcion] [varchar](1024) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_ValorDeclaradoDetalle] PRIMARY KEY CLUSTERED 
(
	[IdValorDeclaradoDetalle] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[ValorDeclaradoDetalleComplemento]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[ValorDeclaradoDetalleComplemento](
	[IdValorDeclaradoDetalleComplemento] [int] IDENTITY(1,1) NOT NULL,
	[IdValorDeclaradoDetalle] [int] NOT NULL,
	[IdTipoBien] [smallint] NOT NULL,
	[IdElementoElectrico] [int] NULL,
	[IdTrabajador] [int] NULL,
	[IdVehiculo] [int] NULL,
	[IdInstalacion] [int] NULL,
	[IdCentroCosto] [int] NULL,
	[IdArea] [smallint] NULL,
	[IdCargo] [smallint] NULL,
	[IdUUNN] [smallint] NULL,
	[IdTipoPlanilla] [smallint] NULL,
	[IdNivelRiesgo] [smallint] NULL,
	[ValorDeclarado] [decimal](12, 2) NULL,
	[ImporteMensual] [decimal](12, 2) NULL,
	[ImporteGratificacion] [decimal](12, 2) NULL,
	[IdEstado] [smallint] NOT NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
	[NombreOrigen] [varchar](255) NULL,
	[NombreAsignado] [varchar](255) NULL,
	[Ruta] [varchar](255) NULL,
 CONSTRAINT [PK_ValorDeclaradoDetalleComplemento] PRIMARY KEY CLUSTERED 
(
	[IdValorDeclaradoDetalleComplemento] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[ValorDeclaradoDetalleDisgregado]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [seg].[ValorDeclaradoDetalleDisgregado](
	[IdValorDeclaradoDetalleDisgregado] [int] IDENTITY(1,1) NOT NULL,
	[IdValorDeclaradoDetalle] [int] NOT NULL,
	[IdTipoPoliza] [smallint] NOT NULL,
	[IdDivisionPoliza] [smallint] NOT NULL,
	[IdUnidadMedida] [smallint] NULL,
	[Cantidad] [decimal](12, 2) NULL,
	[CantidadAjustada] [decimal](12, 2) NULL,
	[IdMoneda] [smallint] NULL,
	[ImporteValorDeclarado] [money] NULL,
	[ImporteAjustado] [money] NULL,
	[IdEstado] [smallint] NULL,
	[osLastLogin] [varchar](32) NOT NULL,
	[osLastDate] [datetime] NOT NULL,
	[osLastApp] [varchar](64) NOT NULL,
	[osFirstLogin] [varchar](32) NOT NULL,
	[osFirstDate] [datetime] NOT NULL,
	[osFirstApp] [varchar](64) NOT NULL,
 CONSTRAINT [PK_ValorDeclaradoDetalleDisgregado] PRIMARY KEY CLUSTERED 
(
	[IdValorDeclaradoDetalleDisgregado] ASC
)  
)  

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [seg].[ValorDeclaradoOcurrencia]    Script Date: 11/10/2018 02:15:12 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [seg].[ValorDeclaradoOcurrencia](
	[IdValorDeclaradoOcurrencia] [int] IDENTITY(1,1) NOT NULL,
	[IdValorDeclarado] [int] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[IdEstadoVDAnterior] [smallint] NOT NULL,
	[IdEstadoVDNuevo] [smallint] NOT NULL,
	[IdTrabajador] [int] NOT NULL,
	[IdEstado] [smallint] NOT NULL,
 CONSTRAINT [PK_ValorDeclaradoOcurrencia] PRIMARY KEY CLUSTERED 
(
	[IdValorDeclaradoOcurrencia] ASC
)  
)  

GO




ALTER TABLE [seg].[Ajustador] ADD  CONSTRAINT [DF_seg_Ajustador_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[Ajustador] ADD  CONSTRAINT [DF_seg_Ajustador_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[Ajustador] ADD  CONSTRAINT [DF_seg_Ajustador_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[Ajustador] ADD  CONSTRAINT [DF_seg_Ajustador_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[Ajustador] ADD  CONSTRAINT [DF_seg_Ajustador_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[Ajustador] ADD  CONSTRAINT [DF_seg_Ajustador_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[Aseguradora] ADD  CONSTRAINT [DF_seg_Aseguradora_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[Aseguradora] ADD  CONSTRAINT [DF_seg_Aseguradora_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[Aseguradora] ADD  CONSTRAINT [DF_seg_Aseguradora_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[Aseguradora] ADD  CONSTRAINT [DF_seg_Aseguradora_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[Aseguradora] ADD  CONSTRAINT [DF_seg_Aseguradora_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[Aseguradora] ADD  CONSTRAINT [DF_seg_Aseguradora_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[Broker] ADD  CONSTRAINT [DF_seg_Broker_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[Broker] ADD  CONSTRAINT [DF_seg_Broker_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[Broker] ADD  CONSTRAINT [DF_seg_Broker_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[Broker] ADD  CONSTRAINT [DF_seg_Broker_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[Broker] ADD  CONSTRAINT [DF_seg_Broker_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[Broker] ADD  CONSTRAINT [DF_seg_Broker_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[DivisionPoliza] ADD  CONSTRAINT [DF_seg_DivisionPoliza_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[DivisionPoliza] ADD  CONSTRAINT [DF_seg_DivisionPoliza_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[DivisionPoliza] ADD  CONSTRAINT [DF_seg_DivisionPoliza_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[DivisionPoliza] ADD  CONSTRAINT [DF_seg_DivisionPoliza_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[DivisionPoliza] ADD  CONSTRAINT [DF_seg_DivisionPoliza_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[DivisionPoliza] ADD  CONSTRAINT [DF_seg_DivisionPoliza_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[Instalacion] ADD  CONSTRAINT [DF_seg_Instalacion_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[Instalacion] ADD  CONSTRAINT [DF_seg_Instalacion_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[Instalacion] ADD  CONSTRAINT [DF_seg_Instalacion_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[Instalacion] ADD  CONSTRAINT [DF_seg_Instalacion_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[Instalacion] ADD  CONSTRAINT [DF_seg_Instalacion_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[Instalacion] ADD  CONSTRAINT [DF_seg_Instalacion_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[Poliza] ADD  CONSTRAINT [DF_seg_Poliza_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[Poliza] ADD  CONSTRAINT [DF_seg_Poliza_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[Poliza] ADD  CONSTRAINT [DF_seg_Poliza_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[Poliza] ADD  CONSTRAINT [DF_seg_Poliza_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[Poliza] ADD  CONSTRAINT [DF_seg_Poliza_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[Poliza] ADD  CONSTRAINT [DF_seg_Poliza_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] ADD  CONSTRAINT [DF_seg_PolizaCoberturaDeducible_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] ADD  CONSTRAINT [DF_seg_PolizaCoberturaDeducible_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] ADD  CONSTRAINT [DF_seg_PolizaCoberturaDeducible_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] ADD  CONSTRAINT [DF_seg_PolizaCoberturaDeducible_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] ADD  CONSTRAINT [DF_seg_PolizaCoberturaDeducible_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] ADD  CONSTRAINT [DF_seg_PolizaCoberturaDeducible_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaCoberturaSumaAsegurada_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaCoberturaSumaAsegurada_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaCoberturaSumaAsegurada_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaCoberturaSumaAsegurada_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaCoberturaSumaAsegurada_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaCoberturaSumaAsegurada_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaCronogramaPago] ADD  CONSTRAINT [DF_seg_PolizaCronogramaPago_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaCronogramaPago] ADD  CONSTRAINT [DF_seg_PolizaCronogramaPago_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaCronogramaPago] ADD  CONSTRAINT [DF_seg_PolizaCronogramaPago_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaCronogramaPago] ADD  CONSTRAINT [DF_seg_PolizaCronogramaPago_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaCronogramaPago] ADD  CONSTRAINT [DF_seg_PolizaCronogramaPago_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaCronogramaPago] ADD  CONSTRAINT [DF_seg_PolizaCronogramaPago_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaEndoso] ADD  CONSTRAINT [DF_seg_PolizaEndoso_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaEndoso] ADD  CONSTRAINT [DF_seg_PolizaEndoso_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaEndoso] ADD  CONSTRAINT [DF_seg_PolizaEndoso_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaEndoso] ADD  CONSTRAINT [DF_seg_PolizaEndoso_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaEndoso] ADD  CONSTRAINT [DF_seg_PolizaEndoso_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaEndoso] ADD  CONSTRAINT [DF_seg_PolizaEndoso_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] ADD  CONSTRAINT [DF_seg_PolizaObservacionAnotacion_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] ADD  CONSTRAINT [DF_seg_PolizaObservacionAnotacion_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] ADD  CONSTRAINT [DF_seg_PolizaObservacionAnotacion_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] ADD  CONSTRAINT [DF_seg_PolizaObservacionAnotacion_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] ADD  CONSTRAINT [DF_seg_PolizaObservacionAnotacion_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] ADD  CONSTRAINT [DF_seg_PolizaObservacionAnotacion_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaPago] ADD  CONSTRAINT [DF_seg_PolizaPago_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaPago] ADD  CONSTRAINT [DF_seg_PolizaPago_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaPago] ADD  CONSTRAINT [DF_seg_PolizaPago_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaPago] ADD  CONSTRAINT [DF_seg_PolizaPago_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaPago] ADD  CONSTRAINT [DF_seg_PolizaPago_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaPago] ADD  CONSTRAINT [DF_seg_PolizaPago_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaPrima] ADD  CONSTRAINT [DF_seg_PolizaPrima_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaPrima] ADD  CONSTRAINT [DF_seg_PolizaPrima_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaPrima] ADD  CONSTRAINT [DF_seg_PolizaPrima_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaPrima] ADD  CONSTRAINT [DF_seg_PolizaPrima_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaPrima] ADD  CONSTRAINT [DF_seg_PolizaPrima_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaPrima] ADD  CONSTRAINT [DF_seg_PolizaPrima_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_PolizaProveedor_NumeroPersonal]  DEFAULT ((0)) FOR [NumeroPersonal]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_PolizaProveedor_NumeroListas]  DEFAULT ((0)) FOR [NumeroListas]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_seg_PolizaProveedor_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_seg_PolizaProveedor_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_seg_PolizaProveedor_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_seg_PolizaProveedor_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_seg_PolizaProveedor_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaProveedor] ADD  CONSTRAINT [DF_seg_PolizaProveedor_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaSumaAsegurada_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaSumaAsegurada_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaSumaAsegurada_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaSumaAsegurada_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaSumaAsegurada_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] ADD  CONSTRAINT [DF_seg_PolizaSumaAsegurada_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[PolizaValorDeclarado] ADD  CONSTRAINT [DF_seg_PolizaValorDeclarado_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[PolizaValorDeclarado] ADD  CONSTRAINT [DF_seg_PolizaValorDeclarado_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[PolizaValorDeclarado] ADD  CONSTRAINT [DF_seg_PolizaValorDeclarado_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[PolizaValorDeclarado] ADD  CONSTRAINT [DF_seg_PolizaValorDeclarado_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[PolizaValorDeclarado] ADD  CONSTRAINT [DF_seg_PolizaValorDeclarado_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[PolizaValorDeclarado] ADD  CONSTRAINT [DF_seg_PolizaValorDeclarado_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroAjustador] ADD  CONSTRAINT [DF_seg_SiniestroAjustador_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroAjustador] ADD  CONSTRAINT [DF_seg_SiniestroAjustador_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroAjustador] ADD  CONSTRAINT [DF_seg_SiniestroAjustador_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroAjustador] ADD  CONSTRAINT [DF_seg_SiniestroAjustador_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroAjustador] ADD  CONSTRAINT [DF_seg_SiniestroAjustador_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroAjustador] ADD  CONSTRAINT [DF_seg_SiniestroAjustador_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectado_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectado_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectado_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectado_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectado_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectado_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectadoDetalle_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectadoDetalle_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectadoDetalle_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectadoDetalle_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectadoDetalle_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroElementoAfectadoDetalle_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroLiquidacion] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacion_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroLiquidacion] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacion_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroLiquidacion] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacion_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroLiquidacion] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacion_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroLiquidacion] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacion_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroLiquidacion] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacion_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionDetalle_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionDetalle_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionDetalle_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionDetalle_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionDetalle_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionDetalle_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionReclamo_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionReclamo_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionReclamo_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionReclamo_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionReclamo_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] ADD  CONSTRAINT [DF_seg_SiniestroLiquidacionReclamo_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] ADD  CONSTRAINT [DF_seg_SiniestroPolizaCobertura_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] ADD  CONSTRAINT [DF_seg_SiniestroPolizaCobertura_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] ADD  CONSTRAINT [DF_seg_SiniestroPolizaCobertura_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] ADD  CONSTRAINT [DF_seg_SiniestroPolizaCobertura_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] ADD  CONSTRAINT [DF_seg_SiniestroPolizaCobertura_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] ADD  CONSTRAINT [DF_seg_SiniestroPolizaCobertura_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroRecupero] ADD  CONSTRAINT [DF_seg_SiniestroRecupero_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroRecupero] ADD  CONSTRAINT [DF_seg_SiniestroRecupero_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroRecupero] ADD  CONSTRAINT [DF_seg_SiniestroRecupero_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroRecupero] ADD  CONSTRAINT [DF_seg_SiniestroRecupero_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroRecupero] ADD  CONSTRAINT [DF_seg_SiniestroRecupero_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroRecupero] ADD  CONSTRAINT [DF_seg_SiniestroRecupero_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroRecuperoDetalle_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroRecuperoDetalle_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroRecuperoDetalle_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroRecuperoDetalle_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroRecuperoDetalle_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] ADD  CONSTRAINT [DF_seg_SiniestroRecuperoDetalle_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] ADD  CONSTRAINT [DF_seg_SiniestroRequerimientoSustento_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] ADD  CONSTRAINT [DF_seg_SiniestroRequerimientoSustento_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] ADD  CONSTRAINT [DF_seg_SiniestroRequerimientoSustento_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] ADD  CONSTRAINT [DF_seg_SiniestroRequerimientoSustento_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] ADD  CONSTRAINT [DF_seg_SiniestroRequerimientoSustento_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] ADD  CONSTRAINT [DF_seg_SiniestroRequerimientoSustento_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[Siniestros] ADD  CONSTRAINT [DF_seg_Siniestros_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[Siniestros] ADD  CONSTRAINT [DF_seg_Siniestros_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[Siniestros] ADD  CONSTRAINT [DF_seg_Siniestros_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[Siniestros] ADD  CONSTRAINT [DF_seg_Siniestros_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[Siniestros] ADD  CONSTRAINT [DF_seg_Siniestros_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[Siniestros] ADD  CONSTRAINT [DF_seg_Siniestros_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] ADD  CONSTRAINT [DF_seg_SiniestrosCorrelativo_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] ADD  CONSTRAINT [DF_seg_SiniestrosCorrelativo_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] ADD  CONSTRAINT [DF_seg_SiniestrosCorrelativo_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] ADD  CONSTRAINT [DF_seg_SiniestrosCorrelativo_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] ADD  CONSTRAINT [DF_seg_SiniestrosCorrelativo_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] ADD  CONSTRAINT [DF_seg_SiniestrosCorrelativo_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoPolizaTipoValorDeclarado_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoPolizaTipoValorDeclarado_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoPolizaTipoValorDeclarado_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoPolizaTipoValorDeclarado_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoPolizaTipoValorDeclarado_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoPolizaTipoValorDeclarado_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[TipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoValorDeclarado_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[TipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoValorDeclarado_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[TipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoValorDeclarado_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[TipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoValorDeclarado_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[TipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoValorDeclarado_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[TipoValorDeclarado] ADD  CONSTRAINT [DF_seg_TipoValorDeclarado_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[ValorDeclarado] ADD  CONSTRAINT [DF_seg_ValorDeclarado_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[ValorDeclarado] ADD  CONSTRAINT [DF_seg_ValorDeclarado_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[ValorDeclarado] ADD  CONSTRAINT [DF_seg_ValorDeclarado_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[ValorDeclarado] ADD  CONSTRAINT [DF_seg_ValorDeclarado_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[ValorDeclarado] ADD  CONSTRAINT [DF_seg_ValorDeclarado_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[ValorDeclarado] ADD  CONSTRAINT [DF_seg_ValorDeclarado_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[ValorDeclaradoAutorizacion] ADD  CONSTRAINT [DF_ValorDeclaradoAutorizacion_IdClaveUnica]  DEFAULT (newid()) FOR [IdClaveUnica]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalle_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalle_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalle_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalle_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalle_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalle_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleComplemento_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleComplemento_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleComplemento_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleComplemento_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleComplemento_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleComplemento_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleDisgregado_osLastLogin]  DEFAULT (suser_sname()) FOR [osLastLogin]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleDisgregado_osLastDate]  DEFAULT (getdate()) FOR [osLastDate]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleDisgregado_osLastApp]  DEFAULT (app_name()) FOR [osLastApp]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleDisgregado_osFirstLogin]  DEFAULT (suser_sname()) FOR [osFirstLogin]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleDisgregado_osFirstDate]  DEFAULT (getdate()) FOR [osFirstDate]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] ADD  CONSTRAINT [DF_seg_ValorDeclaradoDetalleDisgregado_osFirstApp]  DEFAULT (app_name()) FOR [osFirstApp]
GO
ALTER TABLE [seg].[Ajustador]  WITH CHECK ADD  CONSTRAINT [FK_Ajustador_Persona] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Persona] ([IdPersona])
GO
ALTER TABLE [seg].[Ajustador] CHECK CONSTRAINT [FK_Ajustador_Persona]
GO
ALTER TABLE [seg].[Aseguradora]  WITH CHECK ADD  CONSTRAINT [FK_Aseguradora_Persona] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Persona] ([IdPersona])
GO
ALTER TABLE [seg].[Aseguradora] CHECK CONSTRAINT [FK_Aseguradora_Persona]
GO
ALTER TABLE [seg].[Broker]  WITH CHECK ADD  CONSTRAINT [FK_Broker_Persona] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Persona] ([IdPersona])
GO
ALTER TABLE [seg].[Broker] CHECK CONSTRAINT [FK_Broker_Persona]
GO
ALTER TABLE [seg].[DivisionPoliza]  WITH CHECK ADD  CONSTRAINT [FK_DivisionPoliza_Constante] FOREIGN KEY([IdTipoPoliza])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[DivisionPoliza] CHECK CONSTRAINT [FK_DivisionPoliza_Constante]
GO
ALTER TABLE [seg].[Poliza]  WITH NOCHECK ADD  CONSTRAINT [FK_Poliza_Aseguradora] FOREIGN KEY([IdAseguradora])
REFERENCES [seg].[Aseguradora] ([IdAseguradora])
GO
ALTER TABLE [seg].[Poliza] CHECK CONSTRAINT [FK_Poliza_Aseguradora]
GO
ALTER TABLE [seg].[Poliza]  WITH CHECK ADD  CONSTRAINT [FK_Poliza_Broker] FOREIGN KEY([IdBroker])
REFERENCES [seg].[Broker] ([IdBroker])
GO
ALTER TABLE [seg].[Poliza] CHECK CONSTRAINT [FK_Poliza_Broker]
GO
ALTER TABLE [seg].[Poliza]  WITH NOCHECK ADD  CONSTRAINT [FK_Poliza_Constante] FOREIGN KEY([IdModalidadContratacion])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[Poliza] CHECK CONSTRAINT [FK_Poliza_Constante]
GO
ALTER TABLE [seg].[Poliza]  WITH NOCHECK ADD  CONSTRAINT [FK_Poliza_Constante1] FOREIGN KEY([IdTipoPoliza])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[Poliza] CHECK CONSTRAINT [FK_Poliza_Constante1]
GO
ALTER TABLE [seg].[Poliza]  WITH NOCHECK ADD  CONSTRAINT [FK_Poliza_Constante2] FOREIGN KEY([IdPeriodoPrimaTotal])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[Poliza] CHECK CONSTRAINT [FK_Poliza_Constante2]
GO
ALTER TABLE [seg].[Poliza]  WITH CHECK ADD  CONSTRAINT [FK_Poliza_DivisionPoliza] FOREIGN KEY([IdDivisionPoliza])
REFERENCES [seg].[DivisionPoliza] ([IdDivisionPoliza])
GO
ALTER TABLE [seg].[Poliza] CHECK CONSTRAINT [FK_Poliza_DivisionPoliza]
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaCoberturaDeducible_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaCoberturaDeducible] CHECK CONSTRAINT [FK_PolizaCoberturaDeducible_Poliza]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada]  WITH CHECK ADD  CONSTRAINT [FK_PolizaCoberturaSumaAsegurada_PolizaCoberturaDeducible] FOREIGN KEY([IdPolizaCoberturaDeducible])
REFERENCES [seg].[PolizaCoberturaDeducible] ([IdPolizaCoberturaDeducible])
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] CHECK CONSTRAINT [FK_PolizaCoberturaSumaAsegurada_PolizaCoberturaDeducible]
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada]  WITH CHECK ADD  CONSTRAINT [FK_PolizaCoberturaSumaAsegurada_PolizaSumaAsegurada] FOREIGN KEY([IdPolizaSumaAsegurada])
REFERENCES [seg].[PolizaSumaAsegurada] ([IdPolizaSumaAsegurada])
GO
ALTER TABLE [seg].[PolizaCoberturaSumaAsegurada] CHECK CONSTRAINT [FK_PolizaCoberturaSumaAsegurada_PolizaSumaAsegurada]
GO
ALTER TABLE [seg].[PolizaCronogramaPago]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaCronogramaPago_PolizaPago] FOREIGN KEY([IdPolizaPago])
REFERENCES [seg].[PolizaPago] ([IdPolizaPago])
GO
ALTER TABLE [seg].[PolizaCronogramaPago] CHECK CONSTRAINT [FK_PolizaCronogramaPago_PolizaPago]
GO
ALTER TABLE [seg].[PolizaEndoso]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaEndoso_Constante] FOREIGN KEY([IdTipoEndoso])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[PolizaEndoso] CHECK CONSTRAINT [FK_PolizaEndoso_Constante]
GO
ALTER TABLE [seg].[PolizaEndoso]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaEndoso_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO
ALTER TABLE [seg].[PolizaEndoso] CHECK CONSTRAINT [FK_PolizaEndoso_Empresa]
GO
ALTER TABLE [seg].[PolizaEndoso]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaEndoso_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaEndoso] CHECK CONSTRAINT [FK_PolizaEndoso_Poliza]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaObservacionAnotacion_Constante] FOREIGN KEY([IdTipoRegistro])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] CHECK CONSTRAINT [FK_PolizaObservacionAnotacion_Constante]
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaObservacionAnotacion_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaObservacionAnotacion] CHECK CONSTRAINT [FK_PolizaObservacionAnotacion_Poliza]
GO
ALTER TABLE [seg].[PolizaPago]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaPago_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaPago] CHECK CONSTRAINT [FK_PolizaPago_Poliza]
GO
ALTER TABLE [seg].[PolizaPrima]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaPrima_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO
ALTER TABLE [seg].[PolizaPrima] CHECK CONSTRAINT [FK_PolizaPrima_Empresa]
GO
ALTER TABLE [seg].[PolizaPrima]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaPrima_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaPrima] CHECK CONSTRAINT [FK_PolizaPrima_Poliza]
GO
ALTER TABLE [seg].[PolizaPrima]  WITH CHECK ADD  CONSTRAINT [FK_PolizaPrima_ValorTasa] FOREIGN KEY([IdTasaIGV])
REFERENCES [dbo].[ValorTasa] ([IdValor])
GO
ALTER TABLE [seg].[PolizaPrima] CHECK CONSTRAINT [FK_PolizaPrima_ValorTasa]
GO
ALTER TABLE [seg].[PolizaProveedor]  WITH CHECK ADD  CONSTRAINT [FK_PolizaProveedor_Aseguradora] FOREIGN KEY([IdAseguradora])
REFERENCES [seg].[Aseguradora] ([IdAseguradora])
GO
ALTER TABLE [seg].[PolizaProveedor] CHECK CONSTRAINT [FK_PolizaProveedor_Aseguradora]
GO
ALTER TABLE [seg].[PolizaProveedor]  WITH CHECK ADD  CONSTRAINT [FK_PolizaProveedor_Constante] FOREIGN KEY([IdTipoPoliza])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[PolizaProveedor] CHECK CONSTRAINT [FK_PolizaProveedor_Constante]
GO
ALTER TABLE [seg].[PolizaProveedor]  WITH CHECK ADD  CONSTRAINT [FK_PolizaProveedor_ContratoOrdenServicio] FOREIGN KEY([IdContratoOrdenServicio])
REFERENCES [dbo].[ContratoOrdenServicio] ([IdContratoOrdenServicio])
GO
ALTER TABLE [seg].[PolizaProveedor] CHECK CONSTRAINT [FK_PolizaProveedor_ContratoOrdenServicio]
GO
ALTER TABLE [seg].[PolizaProveedor]  WITH CHECK ADD  CONSTRAINT [FK_PolizaProveedor_DivisionPoliza] FOREIGN KEY([IdDivisionPoliza])
REFERENCES [seg].[DivisionPoliza] ([IdDivisionPoliza])
GO
ALTER TABLE [seg].[PolizaProveedor] CHECK CONSTRAINT [FK_PolizaProveedor_DivisionPoliza]
GO
ALTER TABLE [seg].[PolizaSumaAsegurada]  WITH CHECK ADD  CONSTRAINT [FK_PolizaSumaAsegurada_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaSumaAsegurada] CHECK CONSTRAINT [FK_PolizaSumaAsegurada_Poliza]
GO
ALTER TABLE [seg].[PolizaValorDeclarado]  WITH NOCHECK ADD  CONSTRAINT [FK_PolizaValorDeclarado_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[PolizaValorDeclarado] CHECK CONSTRAINT [FK_PolizaValorDeclarado_Poliza]
GO
ALTER TABLE [seg].[PolizaValorDeclarado]  WITH CHECK ADD  CONSTRAINT [FK_PolizaValorDeclarado_ValorDeclaradoDetalleDisgregado] FOREIGN KEY([IdValorDeclaradoDetalleDisgregado])
REFERENCES [seg].[ValorDeclaradoDetalleDisgregado] ([IdValorDeclaradoDetalleDisgregado])
GO
ALTER TABLE [seg].[PolizaValorDeclarado] CHECK CONSTRAINT [FK_PolizaValorDeclarado_ValorDeclaradoDetalleDisgregado]
GO
ALTER TABLE [seg].[SiniestroAjustador]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroAjustador_Siniestros] FOREIGN KEY([IdSiniestro])
REFERENCES [seg].[Siniestros] ([IdSiniestro])
GO
ALTER TABLE [seg].[SiniestroAjustador] CHECK CONSTRAINT [FK_SiniestroAjustador_Siniestros]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroElementoAfectado_ArbolElectrico] FOREIGN KEY([IdElementoElectrico])
REFERENCES [dbo].[ArbolElectrico] ([IdElementoElectrico])
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] CHECK CONSTRAINT [FK_SiniestroElementoAfectado_ArbolElectrico]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroElementoAfectado_Instalacion] FOREIGN KEY([IdInstalacion])
REFERENCES [seg].[Instalacion] ([IdInstalacion])
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] CHECK CONSTRAINT [FK_SiniestroElementoAfectado_Instalacion]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroElementoAfectado_Siniestros] FOREIGN KEY([IdSiniestro])
REFERENCES [seg].[Siniestros] ([IdSiniestro])
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] CHECK CONSTRAINT [FK_SiniestroElementoAfectado_Siniestros]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroElementoAfectado_Trabajador] FOREIGN KEY([IdTrabajador])
REFERENCES [dbo].[Trabajador] ([IdTrabajador])
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] CHECK CONSTRAINT [FK_SiniestroElementoAfectado_Trabajador]
GO
ALTER TABLE [seg].[SiniestroElementoAfectado]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroElementoAfectado_VehiculoConductor] FOREIGN KEY([IdVehiculoConductor])
REFERENCES [dbo].[VehiculoConductor] ([IdVehiculoConductor])
GO
ALTER TABLE [seg].[SiniestroElementoAfectado] CHECK CONSTRAINT [FK_SiniestroElementoAfectado_VehiculoConductor]
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroElementoAfectadoDetalle_SiniestroElementoAfectado] FOREIGN KEY([IdSiniestroElementoAfectado])
REFERENCES [seg].[SiniestroElementoAfectado] ([IdSiniestroElementoAfectado])
GO
ALTER TABLE [seg].[SiniestroElementoAfectadoDetalle] CHECK CONSTRAINT [FK_SiniestroElementoAfectadoDetalle_SiniestroElementoAfectado]
GO
ALTER TABLE [seg].[SiniestroLiquidacion]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroLiquidacion_Siniestros] FOREIGN KEY([IdSiniestro])
REFERENCES [seg].[Siniestros] ([IdSiniestro])
GO
ALTER TABLE [seg].[SiniestroLiquidacion] CHECK CONSTRAINT [FK_SiniestroLiquidacion_Siniestros]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroLiquidacionDetalle_SiniestroLiquidacion] FOREIGN KEY([IdSiniestroLiquidacion])
REFERENCES [seg].[SiniestroLiquidacion] ([IdSiniestroLiquidacion])
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] CHECK CONSTRAINT [FK_SiniestroLiquidacionDetalle_SiniestroLiquidacion]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroLiquidacionDetalle_SiniestroLiquidacionDetalle] FOREIGN KEY([IdSiniestroLiquidacionDetallePadre])
REFERENCES [seg].[SiniestroLiquidacionDetalle] ([IdSiniestroLiquidacionDetalle])
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] CHECK CONSTRAINT [FK_SiniestroLiquidacionDetalle_SiniestroLiquidacionDetalle]
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroLiquidacionDetalle_SiniestroPolizaCobertura1] FOREIGN KEY([IdSiniestroPolizaCobertura])
REFERENCES [seg].[SiniestroPolizaCobertura] ([IdSiniestroPolizaCobertura])
GO
ALTER TABLE [seg].[SiniestroLiquidacionDetalle] CHECK CONSTRAINT [FK_SiniestroLiquidacionDetalle_SiniestroPolizaCobertura1]
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroLiquidacionReclamo_SiniestroLiquidacionDetalle] FOREIGN KEY([IdSiniestroLiquidacionDetalle])
REFERENCES [seg].[SiniestroLiquidacionDetalle] ([IdSiniestroLiquidacionDetalle])
GO
ALTER TABLE [seg].[SiniestroLiquidacionReclamo] CHECK CONSTRAINT [FK_SiniestroLiquidacionReclamo_SiniestroLiquidacionDetalle]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroPolizaCobertura_PolizaCoberturaDeducible] FOREIGN KEY([IdPolizaCobertura])
REFERENCES [seg].[PolizaCoberturaDeducible] ([IdPolizaCoberturaDeducible])
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] CHECK CONSTRAINT [FK_SiniestroPolizaCobertura_PolizaCoberturaDeducible]
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroPolizaCobertura_Siniestros] FOREIGN KEY([IdSiniestro])
REFERENCES [seg].[Siniestros] ([IdSiniestro])
GO
ALTER TABLE [seg].[SiniestroPolizaCobertura] CHECK CONSTRAINT [FK_SiniestroPolizaCobertura_Siniestros]
GO
ALTER TABLE [seg].[SiniestroRecupero]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroRecupero_Poliza] FOREIGN KEY([IdPoliza])
REFERENCES [seg].[Poliza] ([IdPoliza])
GO
ALTER TABLE [seg].[SiniestroRecupero] CHECK CONSTRAINT [FK_SiniestroRecupero_Poliza]
GO
ALTER TABLE [seg].[SiniestroRecupero]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroRecupero_Siniestros] FOREIGN KEY([IdSiniestro])
REFERENCES [seg].[Siniestros] ([IdSiniestro])
GO
ALTER TABLE [seg].[SiniestroRecupero] CHECK CONSTRAINT [FK_SiniestroRecupero_Siniestros]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroRecuperoDetalle_Banco] FOREIGN KEY([IdBanco])
REFERENCES [dbo].[Banco] ([IdBanco])
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] CHECK CONSTRAINT [FK_SiniestroRecuperoDetalle_Banco]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroRecuperoDetalle_SiniestroLiquidacionDetalle] FOREIGN KEY([IdSiniestroLiquidacionDetalle])
REFERENCES [seg].[SiniestroLiquidacionDetalle] ([IdSiniestroLiquidacionDetalle])
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] CHECK CONSTRAINT [FK_SiniestroRecuperoDetalle_SiniestroLiquidacionDetalle]
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_SiniestroRecuperoDetalle_SiniestroRecupero] FOREIGN KEY([IdSiniestroRecupero])
REFERENCES [seg].[SiniestroRecupero] ([IdSiniestroRecupero])
GO
ALTER TABLE [seg].[SiniestroRecuperoDetalle] CHECK CONSTRAINT [FK_SiniestroRecuperoDetalle_SiniestroRecupero]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroRequerimientoSustento_SiniestroRequerimientoSustento] FOREIGN KEY([IdSiniestroRequerimientoSustentoPadre])
REFERENCES [seg].[SiniestroRequerimientoSustento] ([IdSiniestroRequerimientoSustento])
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] CHECK CONSTRAINT [FK_SiniestroRequerimientoSustento_SiniestroRequerimientoSustento]
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento]  WITH NOCHECK ADD  CONSTRAINT [FK_SiniestroSustento_Siniestros] FOREIGN KEY([IdSiniestro])
REFERENCES [seg].[Siniestros] ([IdSiniestro])
GO
ALTER TABLE [seg].[SiniestroRequerimientoSustento] CHECK CONSTRAINT [FK_SiniestroSustento_Siniestros]
GO
ALTER TABLE [seg].[Siniestros]  WITH NOCHECK ADD  CONSTRAINT [FK_Siniestros_Trabajador] FOREIGN KEY([IdTrabajadorReporta])
REFERENCES [dbo].[Trabajador] ([IdTrabajador])
GO
ALTER TABLE [seg].[Siniestros] CHECK CONSTRAINT [FK_Siniestros_Trabajador]
GO
ALTER TABLE [seg].[SiniestrosCorrelativo]  WITH CHECK ADD  CONSTRAINT [FK_SiniestrosCorrelativo_Estado] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([IdRegistro])
GO
ALTER TABLE [seg].[SiniestrosCorrelativo] CHECK CONSTRAINT [FK_SiniestrosCorrelativo_Estado]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado]  WITH CHECK ADD  CONSTRAINT [FK_TipoPolizaTipoValorDeclarado_Constante] FOREIGN KEY([IdTipoPoliza])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] CHECK CONSTRAINT [FK_TipoPolizaTipoValorDeclarado_Constante]
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado]  WITH CHECK ADD  CONSTRAINT [FK_TipoPolizaTipoValorDeclarado_TipoValorDeclarado] FOREIGN KEY([IdTipoValorDeclarado])
REFERENCES [seg].[TipoValorDeclarado] ([IdTipoValorDeclarado])
GO
ALTER TABLE [seg].[TipoPolizaTipoValorDeclarado] CHECK CONSTRAINT [FK_TipoPolizaTipoValorDeclarado_TipoValorDeclarado]
GO
ALTER TABLE [seg].[ValorDeclarado]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclarado_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO
ALTER TABLE [seg].[ValorDeclarado] CHECK CONSTRAINT [FK_ValorDeclarado_Empresa]
GO
ALTER TABLE [seg].[ValorDeclarado]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclarado_Moneda] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Moneda] ([IdMoneda])
GO
ALTER TABLE [seg].[ValorDeclarado] CHECK CONSTRAINT [FK_ValorDeclarado_Moneda]
GO
ALTER TABLE [seg].[ValorDeclaradoAutorizacion]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoAutorizacion_ValorDeclarado] FOREIGN KEY([IdValorDeclarado])
REFERENCES [seg].[ValorDeclarado] ([IdValorDeclarado])
GO
ALTER TABLE [seg].[ValorDeclaradoAutorizacion] CHECK CONSTRAINT [FK_ValorDeclaradoAutorizacion_ValorDeclarado]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalle_Moneda] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[Moneda] ([IdMoneda])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] CHECK CONSTRAINT [FK_ValorDeclaradoDetalle_Moneda]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalle_PolizaEndoso] FOREIGN KEY([IdPolizaEndoso])
REFERENCES [seg].[PolizaEndoso] ([IdPolizaEndoso])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] CHECK CONSTRAINT [FK_ValorDeclaradoDetalle_PolizaEndoso]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalle_TipoValorDeclarado] FOREIGN KEY([IdTipoValorDeclarado])
REFERENCES [seg].[TipoValorDeclarado] ([IdTipoValorDeclarado])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] CHECK CONSTRAINT [FK_ValorDeclaradoDetalle_TipoValorDeclarado]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalle_UnidadMedida] FOREIGN KEY([IdUnidadMedida])
REFERENCES [dbo].[UnidadMedida] ([IdUnidadMedida])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] CHECK CONSTRAINT [FK_ValorDeclaradoDetalle_UnidadMedida]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalle_ValorDeclarado] FOREIGN KEY([IdValorDeclarado])
REFERENCES [seg].[ValorDeclarado] ([IdValorDeclarado])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalle] CHECK CONSTRAINT [FK_ValorDeclaradoDetalle_ValorDeclarado]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_ArbolElectrico] FOREIGN KEY([IdElementoElectrico])
REFERENCES [dbo].[ArbolElectrico] ([IdElementoElectrico])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_ArbolElectrico]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_CentroCosto] FOREIGN KEY([IdCentroCosto])
REFERENCES [dbo].[CentroCosto] ([IdCentroCosto])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_CentroCosto]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Constante] FOREIGN KEY([IdTipoBien])
REFERENCES [dbo].[Constante] ([IdConstante])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Constante]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Instalacion] FOREIGN KEY([IdInstalacion])
REFERENCES [seg].[Instalacion] ([IdInstalacion])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Instalacion]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Trabajador] FOREIGN KEY([IdTrabajador])
REFERENCES [dbo].[Trabajador] ([IdTrabajador])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Trabajador]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_ValorDeclaradoDetalle] FOREIGN KEY([IdValorDeclaradoDetalle])
REFERENCES [seg].[ValorDeclaradoDetalle] ([IdValorDeclaradoDetalle])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_ValorDeclaradoDetalle]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento]  WITH NOCHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Vehiculo] FOREIGN KEY([IdVehiculo])
REFERENCES [dbo].[Vehiculo] ([IdVehiculo])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleComplemento] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleComplemento_Vehiculo]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleDisgregado_DivisionPoliza] FOREIGN KEY([IdDivisionPoliza])
REFERENCES [seg].[DivisionPoliza] ([IdDivisionPoliza])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleDisgregado_DivisionPoliza]
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoDetalleDisgregado_ValorDeclaradoDetalle] FOREIGN KEY([IdValorDeclaradoDetalle])
REFERENCES [seg].[ValorDeclaradoDetalle] ([IdValorDeclaradoDetalle])
GO
ALTER TABLE [seg].[ValorDeclaradoDetalleDisgregado] CHECK CONSTRAINT [FK_ValorDeclaradoDetalleDisgregado_ValorDeclaradoDetalle]
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([IdRegistro])
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia] CHECK CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado]
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado1] FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([IdRegistro])
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia] CHECK CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado1]
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado2] FOREIGN KEY([IdEstadoVDAnterior])
REFERENCES [dbo].[Estado] ([IdRegistro])
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia] CHECK CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado2]
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado3] FOREIGN KEY([IdEstadoVDNuevo])
REFERENCES [dbo].[Estado] ([IdRegistro])
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia] CHECK CONSTRAINT [FK_ValorDeclaradoOcurrencia_Estado3]
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia]  WITH CHECK ADD  CONSTRAINT [FK_ValorDeclaradoOcurrencia_ValorDeclarado] FOREIGN KEY([IdValorDeclarado])
REFERENCES [seg].[ValorDeclarado] ([IdValorDeclarado])
GO
ALTER TABLE [seg].[ValorDeclaradoOcurrencia] CHECK CONSTRAINT [FK_ValorDeclaradoOcurrencia_ValorDeclarado]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza', @level2type=N'COLUMN',@level2name=N'IdDivisionPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el ramo de poliza al cual pertenece el registro, se asocia con la tabla dbo.Constantes, para los registros del grupo : TIPOLIZA' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza', @level2type=N'COLUMN',@level2name=N'IdTipoPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripcion o nombre de la poliza.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Abreviatura de la poliza.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza', @level2type=N'COLUMN',@level2name=N'Abreviatura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que permite almacenar la propiedad si la poliza corresponde a proveedor, por el momento no se considera.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza', @level2type=N'COLUMN',@level2name=N'AplicaProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que contiene el maestro de las divisiones de poliza que actualmente se les denomina Poliza.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'DivisionPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Instalación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'IdInstalacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción de la Instalación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Empresa' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'IdEmpresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Departamento' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'IdDepartamento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Provincia' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'IdProvincia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Distrito' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'IdDistrito'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección de la Instalación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Registro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena las instalaciones físicas de la Empresa' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Instalacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de vigencia inicial del contrato, para el caso de una OS se debe de considerar la fecha de Creación de la OS.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'PolizaProveedor', @level2type=N'COLUMN',@level2name=N'FechaVigenciaInicio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de vigencia final del contrato, para el caso de una OS se debe de considerar la fecha de entrega del trabajo.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'PolizaProveedor', @level2type=N'COLUMN',@level2name=N'FechaVigenciaTermino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica el registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdSegurosControlAutorizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Id de la empresa a la cual representa el control de autorización.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdEmpresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Id de la UU.NN., de ser necesario, a la cual representa el control de autorización.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdUUNN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Proceso al cual esta asociada el control de autorización, se relaciona con la tabla dbo.Constante con el IdPadre = 380.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdProceso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica al area del trabajador que podra realizar la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica el cargo del trabajador que podra realizar la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdCargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que contendra el ID del trabajador autorizador por parte del area de seguros.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdTrabajadorSeguros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que contendra el ID del trabajador autorizador, por parte de la GAF regional.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdTrabajadorGAF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que contendra el ID del trabajador autorizador, por parte de la GR regional.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdTrabajadorGR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que contendra el ID del trabajador autorizador, por parte de la GAF corporativa.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdTrabajadorGCAF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el IdEstado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que contiene los responsables de las autorizaciones por empresa y por proceso de todo el flujo de Seguros Patrimoniales.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SegurosControlAutorizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro Siniestro Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdSiniestroAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Poliza' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Cobertura asociada a una poliza' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdPolizaCobertura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la empresa aseguradra' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdAseguradora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Broker de la Empresa' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdBroker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Ajustador de la Empresa' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro de Siniestro de la Aseguradora' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'NroSiniestroAseguradora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro de Siniestro del Broker' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'NroSiniestroBroker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro de Siniestro del Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'NroSiniestroAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena la relación Siniestro con Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Elemento Afectado del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdSiniestroElementoAfectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Tipo Elemento Afectado (Tabla Constante 33)' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdTipoElementoAfectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Subtipo de Elemento Afectado(Tabla constante 82 = Sub Tipo Bien, 84= Sub Tipo Instalación, 97= Sub Tipo Servicio)' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdSubTipoElementoAfectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Vehiculo Asociado al C onductor' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdVehiculoConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Trabjador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdTrabajador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Elemento Electrico' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdElementoElectrico'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Instalación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdInstalacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Persona' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdPersona'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del Elemento Afectado' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Elemento Afectado' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena los elementos afectados del siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroElementoAfectado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Liquidación del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacion', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de la Liquidación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacion', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacion', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Moneda' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacion', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacion', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena las liquidaciones del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Detalle de la liquidación del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacionDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Detalle de la liquidación del Siniestro Padre' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacionDetallePadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Liquidación del Siniestro ' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Cobertura de la Poliza asociada ' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroPolizaCobertura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Cobertura de la Poliza' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdPolizaCobertura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de Versión del detalle de la liquidación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'FechaVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe de la Perdida' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'ImportePerdida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'ImporteAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe de la Liquidación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'ImporteLiquida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del Deducible' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'ImporteDeducible'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe a Indemnizar' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'ImporteIndemniza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ruta de los Files Adjuntos' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'RutaFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID Estado del Detalle de la Liquidación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena el detalle de la liquidación del siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Reclamo de la Liquidación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacionReclamo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Detalle de la Liquidación que se reclama' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacionDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe de la Perdida que se reclama' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'ImportePerdida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del Ajustador aceptado como acordado' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'ImporteAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe de la Liquidación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'ImporteLiquida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del Deducible' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'ImporteDeducible'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe de la Indemnización' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'ImporteIndemniza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Estado' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena los reclamos de las liquidaciones del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroLiquidacionReclamo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Registro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'IdSiniestroPolizaCobertura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Cobertura de una Poliza' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'IdPolizaCobertura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que registra la asociación' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'FechaRegistro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Moneda' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del Ajustador' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'ImporteAjustador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Registro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena la relación del Siniestro con las Coberturas de las Polizas' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroPolizaCobertura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Recupero del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecupero', @level2type=N'COLUMN',@level2name=N'IdSiniestroRecupero'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecupero', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Poliza' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecupero', @level2type=N'COLUMN',@level2name=N'IdPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha del Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecupero', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecupero', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena los recuperos de un siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecupero'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Registro del detalle del Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroRecuperoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Recupero del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroRecupero'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Detalle de la liquidación del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdSiniestroLiquidacionDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Tipo Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdTipoRecupero'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Tipo Beneficiario en caso de Cheques' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdTipoBeneficiario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Banco ' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdBanco'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro de Cheque' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'NroCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del detalle del Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Moneda del Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del Recupero' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'Importe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha Recepción del Cheque' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'FechaRecepcionCheque'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de Entrega del Cheque a RRFF' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'FechaEntregaRRFF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de Reporsición del Bien Recuperado' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'FechaReposicion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ruta File de los Archivos Adjuntos' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'RutaFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Registro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena el detalle de los Recuperos' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRecuperoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Requerimiento Sustento del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'IdSiniestroRequerimientoSustento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Requerimiento Sustento del Siniestro Padre' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'IdSiniestroRequerimientoSustentoPadre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del Requerimiento Sustento' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de Requerimiento' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'FechaRequerimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Plazo para atender el requerimiento sustento' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'PlazoAtencion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que se atendió el Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'FechaAtencion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Requerimiento Sustento' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ruta de los Files Adjuntos' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento', @level2type=N'COLUMN',@level2name=N'RutaFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla de Requerimientos Sustentos del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestroRequerimientoSustento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año en que ocurrión el Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'Anio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro del Siniestro generado a partir de la tabla de Correlativos' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'NroSiniestro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro Siniestro del Area Usuaria' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'NroSiniestroArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Modalidad de Declaración' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdModalidadDeclaracion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Trabajador Reporta' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdTrabajadorReporta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Cargo Trabajador Reporta' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdCargoTrabajadorReporta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Area Trabajador Reporta' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdAreaTrabajadorReporta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Centro Costos del Trabajador que reporta' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdCentroCostoReporta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Gerencia del Trabajador que Reporta' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdGerenciaReporta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Unidad de Negocio al que pertenece la persona que reporta' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdUnidadNegocioReporta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que el Usuario registro la Declaración' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'FechaDeclaraUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que el Area de Seguros registra la Declaración para la compañia de Seguros' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'FechaDeclaracion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Departamento' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdDepartamento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Provincia' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdProvincia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IdDistrito' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdDistrito'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección donde ocurrio el siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'Direccion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha y Hora del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'FechaHoraEvento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'DescripcionEvento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Nivel de Criticidad' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdNivelCriticidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Moneda' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Valor Estimado de la Perdida' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'ValorEstimado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estado que indica si el siniestro está pendiente de Estimar' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'PendienteEstimacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fue Reportado al Broker' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'FueReportadoBroker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id tipo Cierre del Siniestro (Tabla Constante 6)' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdTipoCierre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que se realiza el cierre del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'FechaCierre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Estado del Siniestro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ruta de los Files Adjuntos' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros', @level2type=N'COLUMN',@level2name=N'RutaFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena los Siniestros' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'Siniestros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Correlativo de Siniestros por Empresa y Año' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestrosCorrelativo', @level2type=N'COLUMN',@level2name=N'IdSiniestroCorrelativo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Empresa a la que pertenece el correlativo' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestrosCorrelativo', @level2type=N'COLUMN',@level2name=N'IdEmpresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que se define el correlativo' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestrosCorrelativo', @level2type=N'COLUMN',@level2name=N'Anio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ultimo Valor del Correlativo' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestrosCorrelativo', @level2type=N'COLUMN',@level2name=N'Valor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id Estado del Registro' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestrosCorrelativo', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena el ultimo correlativo emitido de un siniestro por empresa' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'SiniestrosCorrelativo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdRegistro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id que identifica tipo de poliza, se relaciona con la tabla dbo.Constantes, para el grupo TIPOLIZA.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdTipoPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo identifica al tipo de valor declarado, se relaciona con la tabla seg.TipoValorDeclarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdTipoValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la fecha de inicio de la relacion Poliza / Tipo Valor Declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'FechaVigenciaInicio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la fecha de termino de la relacion Poliza / Tipo Valor Declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'FechaVigenciaTermino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica el estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que permite relacionar el tipo de poliza y el tipo de valor declarado y con ello brindar una informacion mas precisa al usuario al momento de registrar la disgregacion de los valores declarados.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoPolizaTipoValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Id del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdTipoValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el nombre del tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'Nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la descripcion del tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica si el tipo de valor declarado permitira registrar un valor monetario al momento de registrar el valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'AfectaImporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica si el tipo de valor declarado permitira registrar una cantidad de personas o de algun bien al momento de registrar el valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'AfectaCantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica si el tipo de valor declarado requiere cargar a la aplicacion el detalla del valor monetario o de la cantidad ingresada.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'PermiteCargaDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena los tipos de valores declarados y su respectiva configuracion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'TipoValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la empresa a la cual esta asociada el valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdEmpresa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de vigencia inicial del valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'FechaVigenciaInicio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de vigencia final del valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'FechaVigenciaTermino'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ruta donde se almacena las imagenes.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'RutaArchivo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el tipo de moneda que se va a considerar para el VD en la vigencia ingresada.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el tipo de cambio si se trata de la moneda Dolares, si la moneda es SOLES se considera valor 1.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'TipoCambio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena los valores declarados por empresa y vigencia.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que representa al registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoAutorizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica a que Valor Declarado pertenece la autorización registrada.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo unico que identifica al registro y que sirve para las URLs de autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdClaveUnica'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el tipo de proceso que se va a configurar las autorizaciones, se relaciona con la tabla dbo.Constante, IdPadre = 380.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdProceso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica al area del trabajador que podra realizar la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica el cargo del trabajador que podra realizar la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdCargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del trabajador que realizara la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdTrabajador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que identifica el orden de autorizacion que van a realizar los trabajadores.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'OrdenAutoriza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que se realiza el regstro de la peticion de la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'FechaRegistro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que se realiza la autorizacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'FechaAutorizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que permite tener el control de las autorizaciónes para un valor declarado específico.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoAutorizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro por tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del valor declarado al cual estan asociados los detalles.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id que identifica el tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdTipoValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el ID de la Moneda, debe de ser el mismo valor que se registra en la tabla seg.ValorDeclarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe del tipo de valor declarado, el cual se debe de llenar al momento de registrar el valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'ImporteValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe ajustado del tipo de valor declarado, este campo debera de llenarse al momento que se registra los valores ajustados de los elementos disgregados, en teoria debera de ser igual al campos ImporteValorDeclarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'ImporteAjustado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Id de la UU.MM.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la Cantidad del tipo de valor declarado, este campo se llena cuando se registra el Valor Declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'Cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad ajustada del tipo de valor declarado, este campo debera de llenarse al momento que se registra los valores ajustados de los elementos disgregados, en teoria debera de ser igual al campo Cantidad.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'CantidadAjustada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de registro según el tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'FechaRegistro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del tipo de Registro, se relaciona con la tabla dbo.Constantes y los valores son los que se grupan con "TIREVADE", sin embargo cuando se registra los valores declarados solo se debe de considerar el codigo = 56. ' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdTipoRegistro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que asocia a los endozos por las altas y bajas en las polizas, para efecto de registro de valor declarado se considera valor NULL.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdPolizaEndoso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la descripcion de un valor declarado, esto cuando se selecciona como tipo de valor declarado OTROS.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'Descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estado del Registro, en este punto deben de ser 1 o 0.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que contiene el detalla de un valor declarado, aqui se maneja por tipo de valor declarado y su posible dependencia con un Endoso.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoDetalleComplemento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena del valor declarado detalle al cual se le esta cargando el detalle.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que registra el tipo de bien que se esta registrando, el cual puede ser: Elemento Electrico, Trabajador, Vehiculo o Instalación, este campo se relaciona con la tabla dbo.Constantes para el grupo : TIBITVDD.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdTipoBien'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Elemento Electrico del detalle.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdElementoElectrico'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el código del trabajador.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdTrabajador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el codigo del vehiculo.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdVehiculo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el codigo de la instalacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdInstalacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el centro costo para los casos que la plantilla lo contenga.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdCentroCosto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del área donde se ubica el bien, se asocia con la tabla dbo.Area, solo se debe de llenar cuando se carga planilla de Trabajadores y Practicantes.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del cargo que tiene el trabajador al momento de la carga el XLS, este campo se relaciona con la tabla dbo.Constantes para el IdPadre = 71, solo se debe de llenar cuando se carga planilla de Trabajadores y Practicantes.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdCargo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la UU.NN. donde se ubica el vehiculo, se relaciona con la tabla dbo.UnidadNegocio.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdUUNN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el tipo de planilla al cual esta relacionado el trabajador, este campo se relaciona con la tabla dbo.Constantes, para el IdPadre =  370, solo se debe de llenar cuando se carga planilla de Trabajadores y Practicantes.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdTipoPlanilla'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el nivel de riesgo al cual esta relacionado el trabajador, este campo se relaciona con la tabla dbo.Constantes, para el IdPadre =  360, solo se debe de llenar cuando se carga planilla de Trabajadores y Practicantes.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdNivelRiesgo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el valor declarado para los tipos de bien: elemento electrico, vehiculo e instalacion.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'ValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacenara el valor del ingreso mensual para los trabajadores fijos y practicantes. ' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'ImporteMensual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacenara el importe por gratificacion solo para los trabajadores, para los practicantes no.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'ImporteGratificacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que contiene el detalle de los bienes o personal que esta involucrado en un tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleComplemento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro por tipo de valor declarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoDetalleDisgregado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Valor Declarado Detalle.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el Ramo Poliza, el cual se obtiene de la tabla dbo.Constante, del grupo "TIPOLIZA"' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdTipoPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el IdPoliza de la tabla seg.DivisionPoliza.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdDivisionPoliza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el ID de la UU.MM.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena la Cantidad del tipo de valor declarado disgregado por Poliza, este campo se llena cuando se registra el proceso de Disgregación.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'Cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad ajustada del tipo de valor declarado disgregado por Poliza, este campo debera de llenarse al momento que se registra los valores ajustados de los elementos disgregados.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'CantidadAjustada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el ID de la Moneda, debe de ser el mismo valor que se registra en la tabla seg.ValorDeclarado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdMoneda'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Campo que almacena el importe del tipo de valor declarado disgregado por Poliza, este campo se llena cuando se registra el proceso de Disgregación.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'ImporteValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Importe ajustado del tipo de valor declarado disgregado, este campo debera de llenarse al momento que se registra los valores ajustados de los elementos disgregados.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'ImporteAjustado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del estado del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena el disgregado de los tipos de valores declarados por Ramo Poliza (IdTipoPoliza) y Poliza(division de poliza).' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoDetalleDisgregado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del registro.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'IdValorDeclaradoOcurrencia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del valor declararo al cual le sirve la ocurrncia.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'IdValorDeclarado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha que se realizó el cambio de estado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'FechaRegistro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del estado anterior.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'IdEstadoVDAnterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del estado actual.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'IdEstadoVDNuevo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Trabajador que realizo el cambio del estado.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'IdTrabajador'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del estado del registro, puede ser 1 o 0.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia', @level2type=N'COLUMN',@level2name=N'IdEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabla que almacena las ocurrenias de los cambios de estado por la que transcurre una valor declarado, grabando el trabajador que realizo el cambio, la fecha, el estado anterior y el estado actual.' , @level0type=N'SCHEMA',@level0name=N'seg', @level1type=N'TABLE',@level1name=N'ValorDeclaradoOcurrencia'
GO
