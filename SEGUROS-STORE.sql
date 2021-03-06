USE [SegurosDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_D_ArchivoValorDeclaradoPorId]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_D_ArchivoValorDeclaradoPorId]
(	
	@IdArchivo int,
	@IdEstado smallint
)
AS
BEGIN

	UPDATE dbo.Archivos
	SET 
		Estado = @IdEstado
	WHERE 
		IdArchivo = @IdArchivo
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_D_ValorDeclaradoDetalleDisgregado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_D_ValorDeclaradoDetalleDisgregado]
(
@IdValorDeclaradoDetalleDisgregado int
)
AS
	UPDATE seg.ValorDeclaradoDetalleDisgregado
	   SET IdEstado = 0
	 WHERE IdValorDeclaradoDetalleDisgregado = @IdValorDeclaradoDetalleDisgregado
GO
/****** Object:  StoredProcedure [dbo].[SP_D_ValorDeclaradoDetallePorId]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_D_ValorDeclaradoDetallePorId]
(
	@IdValorDeclaradoDetalle int,
	@IdEstado smallint
)
AS
BEGIN

	UPDATE seg.ValorDeclaradoDetalle
	SET 
		IdEstado = @IdEstado
	WHERE 
		IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_I_ArchivoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ArchivoValorDeclarado]
(
	@IdValorDeclarado int,
	@IdArchivo int out,
	@NombreOrigen varchar(255),
	@NombreAsignado varchar(255),
	@Ruta varchar(255),
	@Formato varchar(10),
	@IdEstado smallint
)
AS
BEGIN

	INSERT INTO [dbo].[Archivos]
           ([IdValorDeclarado]
           ,[NombreOrigen]
           ,[NombreAsignado]
           ,[Ruta]
           ,[Formato]
           ,[Estado])
     VALUES
           (@IdValorDeclarado,
			@NombreOrigen,
			@NombreAsignado,
			@Ruta,
			@Formato,
			@IdEstado)

	SET @IdArchivo = @@IDENTITY

END;

GO
/****** Object:  StoredProcedure [dbo].[SP_I_Constante]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 CREATE PROCEDURE [dbo].[SP_I_Constante]
@IdPadre SMALLINT,
@Constante VARCHAR(128),
@Descripcion VARCHAR(256),
@CodigoAgrupador CHAR(8),
@Orden SMALLINT,
@Tag VARCHAR(32),
@IdEstado BIT
AS
DECLARE
@SI_IdEstado SMALLINT
BEGIN
	DECLARE @IdConstante smallint
	
	SET @IdConstante = (SELECT MAX(IdConstante) FROM Constante with(nolock)) + 1

	IF (@IdEstado=0) SET @SI_IdEstado=2
	ELSE SET @SI_IdEstado=1

	INSERT INTO dbo.Constante 
		(
		IdConstante,
		IdPadre,
		Constante,
		Descripcion,
		CodigoAgrupador,
		Orden,
		Tag,
		IdEstado)
	VALUES 
		(
		@IdConstante,
		@IdPadre,
		@Constante,
		@Descripcion,
		@CodigoAgrupador,
		@Orden,
		@Tag,
		@SI_IdEstado)
END



GO
/****** Object:  StoredProcedure [dbo].[SP_I_DivisionPoliza]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_DivisionPoliza]
(@IdTipoPoliza smallint,
@Descripcion varchar(128),
@Abreviatura varchar(32),
@AplicaProveedor bit,
@IdEstado smallint)
AS
	INSERT INTO seg.DivisionPoliza(IdTipoPoliza,Descripcion,Abreviatura,AplicaProveedor,IdEstado)
	VALUES(@IdTipoPoliza,@Descripcion,@Abreviatura,@AplicaProveedor,@IdEstado)

GO
/****** Object:  StoredProcedure [dbo].[SP_I_Persona]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_Persona]
(	   @IdPersona int out
      ,@Nombres varchar(128)
      ,@ApellidoPaterno varchar(32)
      ,@ApellidoMaterno varchar(32)
      ,@Apellidos varchar(64)
      ,@IdTipoIdentidad smallint
      ,@NroIdentidad varchar(20)
      ,@IdEstado smallint
)
AS
BEGIN

	INSERT INTO [dbo].[Persona]
           (   Nombres 
			  ,ApellidoPaterno 
			  ,ApellidoMaterno 
			  ,Apellidos 
			  ,IdTipoIdentidad 
			  ,NroIdentidad 
			  ,IdEstado  )
     VALUES
			  (@Nombres 
			  ,@ApellidoPaterno 
			  ,@ApellidoMaterno 
			  ,@Apellidos 
			  ,@IdTipoIdentidad 
			  ,@NroIdentidad 
			  ,@IdEstado )

	SET @IdPersona = @@IDENTITY
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_i_personacomplemento]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_i_personacomplemento]
@idPersona int,
@sexo int,
@idGradoInstruccion int,
@FechaNacimiento datetime
as
insert into PersonaComplemento
			(IdPersona
			,Sexo
			,IdGradoInstruccion
			,FechaNacimiento)
			values(@idPersona
					,@sexo
					,@idGradoInstruccion
					,@FechaNacimiento)
					
GO
/****** Object:  StoredProcedure [dbo].[SP_I_TipoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_TipoValorDeclarado]
(
	@IdTipoValorDeclarado smallint out,
	@Nombre varchar(64),
	@Descripcion varchar(256),
	@AfectaImporte smallint,
	@AfectaCantidad smallint,
	@PermiteCargaDetalle smallint,
	@IdEstado smallint
)
AS
BEGIN

	INSERT INTO [seg].[TipoValorDeclarado]
           ([Nombre]
           ,[Descripcion]
           ,[AfectaImporte]
           ,[AfectaCantidad]
           ,[PermiteCargaDetalle]
           ,[IdEstado])
     VALUES
           (@Nombre,
			@Descripcion,
			@AfectaImporte,
			@AfectaCantidad,
			@PermiteCargaDetalle,
			@IdEstado)

	SET @IdTipoValorDeclarado = @@IDENTITY
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_I_Trabajador]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_Trabajador]
(
	   @IdTrabajador int out
	  ,@IdPersona int 
      ,@IdArea smallint
      ,@IdEmpresa smallint
      ,@IdUnidadNegocio smallint
      ,@IdCentroServicio smallint
      ,@EsPlanillado smallint
      ,@IdCargo smallint
      ,@IdClasificacionCargo smallint
      ,@Email varchar(96)
      ,@CodigoSAP varchar(32)
      ,@IdEstado smallint
      ,@FechaIngreso nchar(10)
)
AS
BEGIN

	INSERT INTO [dbo].[Trabajador]
           (  IdPersona 
			  ,IdArea 
			  ,IdEmpresa 
			  ,IdUnidadNegocio 
			  ,IdCentroServicio 
			  ,EsPlanillado 
			  ,IdCargo 
			  ,IdClasificacionCargo 
			  ,Email 
			  ,CodigoSAP 
			  ,IdEstado 
			  ,FechaIngreso   )
     VALUES
			 (@IdPersona 
			  ,@IdArea 
			  ,@IdEmpresa 
			  ,@IdUnidadNegocio 
			  ,@IdCentroServicio 
			  ,@EsPlanillado 
			  ,@IdCargo 
			  ,@IdClasificacionCargo 
			  ,@Email 
			  ,@CodigoSAP 
			  ,@IdEstado 
			  ,@FechaIngreso )

	SET @IdTrabajador = @@IDENTITY
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_I_ValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ValorDeclarado]
(
	@IdValorDeclarado smallint out,
	@IdEmpresa smallint,
	@FechaVigenciaInicio datetime,
	@FechaVigenciaTermino datetime,
	@IdMoneda smallint,
	@TipoCambio decimal(12,2)
)
AS
BEGIN

	INSERT INTO [seg].[ValorDeclarado]
           ([IdEmpresa]
           ,[FechaVigenciaInicio]
           ,[FechaVigenciaTermino]
           ,[IdMoneda]
           ,[TipoCambio]
           ,[IdEstado])
     VALUES
           (@IdEmpresa,
			@FechaVigenciaInicio,
			@FechaVigenciaTermino,
			@IdMoneda,
			@TipoCambio,
			21)

	SET @IdValorDeclarado = @@IDENTITY

END;
GO
/****** Object:  StoredProcedure [dbo].[SP_I_ValorDeclaradoDetalle]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ValorDeclaradoDetalle]
(	
	@IdValorDeclaradoDetalle int out,
	@IdValorDeclarado int,
	@IdTipoValorDeclarado smallint,
	@IdUnidadMedida smallint,
	@Cantidad decimal(12,2),
	@ImporteValorDeclarado money,
	@IdMoneda smallint,
	@IdTipoRegistro smallint
)
AS
BEGIN
  
   	
  
	INSERT INTO [seg].[valorDeclaradoDetalle]
           ([IdValorDeclarado]
           ,[IdTipoValorDeclarado]
           ,[IdUnidadMedida]
           ,[Cantidad]
           ,[ImporteValorDeclarado]
           ,[IdMoneda]
           ,[IdEstado]
           ,[FechaRegistro]
           ,[IdTipoRegistro])
     VALUES
           (@IdValorDeclarado,
			@IdTipoValorDeclarado,
			@IdUnidadMedida,
			@Cantidad,
			@ImporteValorDeclarado,
			@IdMoneda,
			1,
			GETDATE(),
			@IdTipoRegistro)
			
	
			
	SET @IdValorDeclaradoDetalle = @@IDENTITY
	

	

END


GO
/****** Object:  StoredProcedure [dbo].[SP_I_ValorDeclaradoDetalleComplemento]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ValorDeclaradoDetalleComplemento]
(
	  @IdValorDeclaradoDetalleComplemento  int out,
	  @IdValorDeclaradoDetalle int,
	  @IdTipoBien smallint,
	  @IdElementoElectrico int, 
	  @IdTrabajador int,
	  @IdVehiculo int,
	  @IdInstalacion int,
	  @IdCentroCosto smallint,
	  @IdArea smallint,
	  @IdCargo smallint,
	  @IdUUNN smallint,
	  @IdTipoPlanilla smallint,
	  @IdNivelRiesgo smallint,
	  @ValorDeclarado decimal(12,2),
	  @ImporteMensual decimal(12,2),
	  @ImporteGratificacion decimal(12,2),
	  @IdEstado smallint,
	  @NombreOrigen varchar(255),
	  @NombreAsignado varchar(255),
	  @Ruta varchar(255)
)
AS
BEGIN

	INSERT INTO [seg].[ValorDeclaradoDetalleComplemento]           (     
			  IdValorDeclaradoDetalle 
			  ,IdTipoBien 
			  ,IdElementoElectrico 
			  ,IdTrabajador 
			  ,IdVehiculo 
			  ,IdInstalacion 
			  ,IdCentroCosto 
			  ,IdArea 
			  ,IdCargo 
			  ,IdUUNN 
			  ,IdTipoPlanilla 
			  ,IdNivelRiesgo 
			  ,ValorDeclarado 
			  ,ImporteMensual 
			  ,ImporteGratificacion 
			  ,IdEstado 
			  ,NombreOrigen 
			  ,NombreAsignado 
			  ,Ruta )
     VALUES
           (   @IdValorDeclaradoDetalle 
			  ,@IdTipoBien 
			  ,@IdElementoElectrico 
			  ,@IdTrabajador 
			  ,@IdVehiculo 
			  ,@IdInstalacion 
			  ,@IdCentroCosto 
			  ,@IdArea 
			  ,@IdCargo 
			  ,@IdUUNN 
			  ,@IdTipoPlanilla 
			  ,@IdNivelRiesgo 
			  ,@ValorDeclarado 
			  ,@ImporteMensual 
			  ,@ImporteGratificacion 
			  ,@IdEstado 
			  ,@NombreOrigen 
			  ,@NombreAsignado 
			  ,@Ruta )

	SET @IdValorDeclaradoDetalleComplemento = @@IDENTITY

END;

GO
/****** Object:  StoredProcedure [dbo].[SP_I_ValorDeclaradoDetalleComplemento_trabajador_excel_writer]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ValorDeclaradoDetalleComplemento_trabajador_excel_writer]  
(  
   @IdValorDeclaradoDetalleComplemento  int out,  
   @IdValorDeclaradoDetalle int,  
   @IdTipoBien smallint,  
   @IdElementoElectrico int,   
   @IdTrabajador int,  
   @IdVehiculo int,  
   @IdInstalacion int,  
   @IdCentroCosto smallint,  
   @IdArea smallint,  
   @IdCargo smallint,  
   @IdUUNN smallint,  
   @IdTipoPlanilla smallint,  
   @IdNivelRiesgo smallint,  
   @ValorDeclarado decimal(12,2),  
   @ImporteMensual decimal(12,2),  
   @ImporteGratificacion decimal(12,2),  
   @IdEstado smallint,  
   @NombreOrigen varchar(255),  
   @NombreAsignado varchar(255),  
   @Ruta varchar(255)  ,
   @DNI varchar(8),
   @Nombres varchar(60),
   @ApellidoPaterno varchar(120),
   @ApellidoMaterno varchar(120),
   @FechaNacimiento date,
   @FechaIngreso date
)  
AS  
BEGIN  
  
 declare @iCodigoPersona int,
		 @iCodigodTrabajador int,
		 @iCodigoPersonaComplemento int
  
 SELECT  @iCodigoPersona=per.IdPersona
 FROM dbo.Persona   per
 WHERE IdEstado = 1 
	and NroIdentidad=@DNI
	and NroIdentidad is not null
  
 SELECT   @iCodigodTrabajador=IdTrabajador		 
 FROM dbo.Trabajador  
 WHERE IdPersona = @iCodigoPersona
   AND IdEstado=1
 
select @iCodigoPersonaComplemento=IdPersona
from PersonaComplemento
where IdPersona=@iCodigoPersona

 -- Persona
 if(@iCodigoPersona is null)
 begin
 			INSERT INTO [dbo].[Persona]
				   (   Nombres 
					  ,ApellidoPaterno 
					  ,ApellidoMaterno 
					  ,Apellidos 
					  ,IdTipoIdentidad 
					  ,NroIdentidad 
					  ,IdEstado  )
			 VALUES (@Nombres 
					  ,@ApellidoPaterno 
					  ,@ApellidoMaterno 
					  ,@ApellidoPaterno+SPACE(1) +@ApellidoMaterno
					  ,1
					  ,@DNI 
					  ,1 )
 
 set @iCodigoPersona=(select MAX(IdPersona) 
						from dbo.Persona )	
 END
 ELSE
 BEGIN
		 UPDATE dbo.Persona SET Nombres=@Nombres
							,ApellidoPaterno=@ApellidoPaterno
							,ApellidoMaterno=@ApellidoMaterno
							,Apellidos=@ApellidoPaterno+SPACE(1) +@ApellidoMaterno
							,IdTipoIdentidad=1
							,NroIdentidad=@DNI
							,IdEstado=1
						where IdPersona=@iCodigoPersona
 end
 
 -- Persona Complemento
 if(@iCodigoPersonaComplemento  is null)
 begin
 
		 insert into PersonaComplemento
					(IdPersona
					,Sexo
					,IdGradoInstruccion
					,FechaNacimiento)
					values(@iCodigoPersona
							,null
							,null
							,@FechaNacimiento)
							
 
 end
 else
 begin
	    update PersonaComplemento set FechaNacimiento=@FechaNacimiento
								 where IdPersona=@iCodigoPersona								  
 end
 
 
 
 -- Trabajador
 if(@iCodigodTrabajador is null)
 begin
		 INSERT INTO [dbo].[Trabajador]
				   (  IdPersona 
					  ,IdArea 					  
					  ,EsPlanillado 
					  ,IdCargo  
					  ,IdEstado 
					  ,FechaIngreso   )
			 VALUES
					 (@iCodigoPersona 
					  ,@IdArea 
					  ,0 
					  ,@IdCargo 
					  ,1 
					  ,@FechaIngreso )

 set @iCodigodTrabajador=(select MAX(IdTrabajador) 
							from  Trabajador)
 end
 ELSE
 begin
 		UPDATE Trabajador SET IdArea=@IdArea
							,EsPlanillado=0
							,IdCargo=@IdCargo
							,IdEstado=1
							,FechaIngreso=@FechaIngreso
				where IdTrabajador=@iCodigodTrabajador
 END 
 
		 INSERT INTO [seg].[ValorDeclaradoDetalleComplemento]           (       
			 IdValorDeclaradoDetalle   
			 ,IdTipoBien   
			 ,IdElementoElectrico   
			 ,IdTrabajador   
			 ,IdVehiculo   
			 ,IdInstalacion   
			 ,IdCentroCosto   
			 ,IdArea   
			 ,IdCargo   
			 ,IdUUNN   
			 ,IdTipoPlanilla   
			 ,IdNivelRiesgo   
			 ,ValorDeclarado   
			 ,ImporteMensual   
			 ,ImporteGratificacion   
			 ,IdEstado   
			 ,NombreOrigen   
			 ,NombreAsignado   
			 ,Ruta )  
			 VALUES  
				   (   @IdValorDeclaradoDetalle   
			 ,@IdTipoBien   
			 ,@IdElementoElectrico   
			 ,@iCodigodTrabajador   
			 ,@IdVehiculo   
			 ,@IdInstalacion   
			 ,@IdCentroCosto   
			 ,@IdArea   
			 ,@IdCargo   
			 ,@IdUUNN   
			 ,@IdTipoPlanilla   
			 ,@IdNivelRiesgo   
			 ,@ValorDeclarado   
			 ,@ImporteMensual   
			 ,@ImporteGratificacion   
			 ,@IdEstado   
			 ,@NombreOrigen   
			 ,@NombreAsignado   
			 ,@Ruta )  
  
 SET @IdValorDeclaradoDetalleComplemento = @@IDENTITY  
  
END

GO
/****** Object:  StoredProcedure [dbo].[SP_I_ValorDeclaradoDetalleComplemento_vehiculo_excel_writer]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ValorDeclaradoDetalleComplemento_vehiculo_excel_writer]  
(  
   @IdValorDeclaradoDetalleComplemento  int out,  
   @IdValorDeclaradoDetalle int,  
   @IdTipoBien smallint,  
   @IdVehiculo int,  
   @IdCentroCosto smallint,  
   @IdArea smallint,  
   @IdCargo smallint,  
   @IdUUNN smallint,  
   @IdTipoPlanilla smallint,  
   @IdNivelRiesgo smallint,  
   @ValorDeclarado decimal(12,2),  
   @ImporteMensual decimal(12,2),  
   @ImporteGratificacion decimal(12,2),  
   @IdEstado smallint,  
   @NombreOrigen varchar(255),  
   @NombreAsignado varchar(255),  
   @Ruta varchar(255)  
   ,@IdEmpresa smallint
   ,@IdUnidadNegocio smallint
   ,@IdTipoVehiculo smallint
  ,@IdMarca smallint
  ,@IdModelo int
  ,@PlacaAnterior varchar(10)
  ,@Placa varchar(10)
  ,@SerieCarroceria varchar(64)
  ,@SerieMotor varchar(64)
  ,@Clase varchar(64)
  ,@AnoFabricado smallint
  ,@IdColor smallint
  ,@NroAsientos smallint
  ,@TimonCambiado smallint
  ,@IdMoneda smallint
  ,@ValorComercial money
  ,@dtFechaInicio datetime
  ,@dtFechaTermino datetime
)  
AS  
 
   declare @iCodigoVehiculo int 
   
   select @iCodigoVehiculo=IdVehiculo
   from Vehiculo
   where Placa=@Placa
    AND IdEstado=1
    
   IF(@iCodigoVehiculo IS NULL)
   BEGIN
	INSERT INTO [dbo].[Vehiculo]
           (   
			  IdEmpresa 
			  ,IdUnidadNegocio 
			  ,IdCentroCosto 
			  ,IdTipoVehiculo 
			  ,IdMarca 
			  ,IdModelo 
			  ,PlacaAnterior 
			  ,Placa 
			  ,SerieCarroceria 
			  ,SerieMotor 
			  ,Clase 
			  ,AnoFabricado 
			  ,IdColor 
			  ,NroAsientos 
			  ,TimonCambiado 
			  ,IdMoneda 
			  ,ValorComercial 
			  ,IdEstado
			  ,dtFechaInicio
			  ,dtFechaTermino )
     VALUES
           (    
			  @IdEmpresa 
			  ,@IdUnidadNegocio 
			  ,@IdCentroCosto 
			  ,@IdTipoVehiculo 
			  ,@IdMarca 
			  ,@IdModelo 
			  ,@PlacaAnterior 
			  ,@Placa 
			  ,@SerieCarroceria 
			  ,@SerieMotor 
			  ,@Clase 
			  ,@AnoFabricado 
			  ,@IdColor 
			  ,@NroAsientos 
			  ,@TimonCambiado 
			  ,@IdMoneda 
			  ,@ValorComercial 
			  ,@IdEstado
			  ,@dtFechaInicio
			  ,@dtFechaTermino)
	 SET @iCodigoVehiculo = @@IDENTITY
  END
  ELSE
  BEGIN
  
	UPDATE [dbo].[Vehiculo]
	SET      
		   IdEmpresa        = @IdEmpresa      
		  ,IdUnidadNegocio  = @IdUnidadNegocio
		  ,IdCentroCosto    = @IdCentroCosto  
		  ,IdTipoVehiculo   = @IdTipoVehiculo 
		  ,IdMarca          = @IdMarca        
		  ,IdModelo         = @IdModelo       
		  ,Placa            = @Placa          
		  ,SerieCarroceria  = @SerieCarroceria
		  ,SerieMotor       = @SerieMotor     
		  ,Clase            = @Clase          
		  ,AnoFabricado     = @AnoFabricado         
		  ,NroAsientos      = @NroAsientos    
		  ,TimonCambiado    = @TimonCambiado  
		  ,IdMoneda         = @IdMoneda       
		  ,ValorComercial   = @ValorComercial 
		  ,dtFechaInicio=@dtFechaInicio
		  ,dtFechaTermino=@dtFechaTermino
	WHERE IdVehiculo = @IdVehiculo
	
  END
  
 
		 INSERT INTO [seg].[ValorDeclaradoDetalleComplemento]  (       
			 IdValorDeclaradoDetalle   
			 ,IdTipoBien   
			 ,IdElementoElectrico   
			 ,IdTrabajador   
			 ,IdVehiculo   
			 ,IdInstalacion   
			 ,IdCentroCosto   
			 ,IdArea   
			 ,IdCargo   
			 ,IdUUNN   
			 ,IdTipoPlanilla   
			 ,IdNivelRiesgo   
			 ,ValorDeclarado   
			 ,ImporteMensual   
			 ,ImporteGratificacion   
			 ,IdEstado   
			 ,NombreOrigen   
			 ,NombreAsignado   
			 ,Ruta )  
			 VALUES  
			 ( @IdValorDeclaradoDetalle   
			 ,@IdTipoBien   
			 ,NULL   
			 ,NULL
			 ,@iCodigoVehiculo   
			 ,NULL
			 ,@IdCentroCosto   
			 ,@IdArea   
			 ,@IdCargo   
			 ,@IdUUNN   
			 ,@IdTipoPlanilla   
			 ,@IdNivelRiesgo   
			 ,@ValorDeclarado   
			 ,@ImporteMensual   
			 ,@ImporteGratificacion   
			 ,@IdEstado   
			 ,@NombreOrigen   
			 ,@NombreAsignado   
			 ,@Ruta )  
  
 
GO
/****** Object:  StoredProcedure [dbo].[SP_I_ValorDeclaradoDetalleDisgregado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_I_ValorDeclaradoDetalleDisgregado]
(
@IdValorDeclaradoDetalle int,
@IdTipoPoliza smallint,
@IdDivisionPoliza smallint,
@IdUnidadMedida smallint,
@Cantidad decimal,
@IdMoneda smallint,
@ImporteValorDeclarado money
)
AS
	INSERT INTO seg.ValorDeclaradoDetalleDisgregado(IdValorDeclaradoDetalle, IdTipoPoliza, IdDivisionPoliza, IdUnidadMedida, Cantidad, IdMoneda, ImporteValorDeclarado, IdEstado)
	VALUES(@IdValorDeclaradoDetalle, @IdTipoPoliza, @IdDivisionPoliza, @IdUnidadMedida, @Cantidad, @IdMoneda, @ImporteValorDeclarado, 1)
 
GO
/****** Object:  StoredProcedure [dbo].[SP_I_Vehiculo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_I_Vehiculo]
(
	   @IdVehiculo int out
	  ,@IdEmpresa smallint
	  ,@IdUnidadNegocio smallint
	  ,@IdCentroCosto smallint
	  ,@IdTipoVehiculo smallint
	  ,@IdMarca smallint
	  ,@IdModelo int
	  ,@PlacaAnterior varchar(10)
	  ,@Placa varchar(10)
	  ,@SerieCarroceria varchar(64)
	  ,@SerieMotor varchar(64)
	  ,@Clase varchar(64)
	  ,@AnoFabricado smallint
	  ,@IdColor smallint
	  ,@NroAsientos smallint
	  ,@TimonCambiado smallint
	  ,@IdMoneda smallint
	  ,@ValorComercial money
	  ,@IdEstado smallint
	  ,@dtFechaInicio datetime
	  ,@dtFechaTermino datetime
)
AS
BEGIN

	INSERT INTO [dbo].[Vehiculo]
           (   
			  IdEmpresa 
			  ,IdUnidadNegocio 
			  ,IdCentroCosto 
			  ,IdTipoVehiculo 
			  ,IdMarca 
			  ,IdModelo 
			  ,PlacaAnterior 
			  ,Placa 
			  ,SerieCarroceria 
			  ,SerieMotor 
			  ,Clase 
			  ,AnoFabricado 
			  ,IdColor 
			  ,NroAsientos 
			  ,TimonCambiado 
			  ,IdMoneda 
			  ,ValorComercial 
			  ,IdEstado
			  ,dtFechaInicio
			  ,dtFechaTermino )
     VALUES
           (    
			  @IdEmpresa 
			  ,@IdUnidadNegocio 
			  ,@IdCentroCosto 
			  ,@IdTipoVehiculo 
			  ,@IdMarca 
			  ,@IdModelo 
			  ,@PlacaAnterior 
			  ,@Placa 
			  ,@SerieCarroceria 
			  ,@SerieMotor 
			  ,@Clase 
			  ,@AnoFabricado 
			  ,@IdColor 
			  ,@NroAsientos 
			  ,@TimonCambiado 
			  ,@IdMoneda 
			  ,@ValorComercial 
			  ,@IdEstado
			  ,@dtFechaInicio
			  ,@dtFechaTermino)

	SET @IdVehiculo = @@IDENTITY
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminaAcuerdo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_EliminaAcuerdo]
(
			@IdAcuerdosxComite int
)
as begin
update		AcuerdosxComite
set			IdEstado = 0
where		IdAcuerdosxComite=@IdAcuerdosxComite
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminaAgenda]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_EliminaAgenda]
(
			@IdAgenda int,
			@IdPersona int
)
as begin
delete 
from		agenda
where		IdAgenda=@IdAgenda 
and			IdPersona = @IdPersona 
end 

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminaPersona]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_Previsor_EliminaPersona]
(
				@IdPersona int
)
as
update			dbo.Persona
set				IdEstado='0'
where			idPersona = @IdPersona


GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminaPersonaAsistencia]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_EliminaPersonaAsistencia]
(

			@IdRegistro int
)
as set nocount on
begin
update		registropersonalxcomite 
set			IdEstado='0'
where		idregistropersonalxcomite=@IdRegistro
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminaResponsable]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_EliminaResponsable]
(
			@IdResponsable int,
			@IdPersona int
)
as begin
update		responsable
set			IdEstado='0'
where		idresponsable =@IdResponsable 
and			idpersona=@IdPersona
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminarPersonaComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_EliminarPersonaComite]
(
				@IdRegistroPersonalxComite int,
				@IdPersona int
)
as
begin
update			RegistroPersonalxComite
set				IdEstado2=0
where			IdRegistroPersonalxComite = @IdRegistroPersonalxComite and IdPersona = @IdPersona
end



GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_EliminarProgramacionComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_EliminarProgramacionComite]
(
		@IdProgramacionComite int
)
as
update ProgramacionComite 
set		IdEstado=0
where	@IdProgramacionComite = IdProgramacionComite

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_InsertaProgramacionComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_InsertaProgramacionComite]
(
	@FechaReunion datetime,
	@Duracion int,
	@FechaFinReunion datetime,
	@TipoReunionComite int,
	@LugarReunion int,
	@FechaRegistro datetime,
	@FechaModificacion datetime,
	@Usuario varchar(20)
)
as
begin
insert into ProgramacionComite(FechaInicioReunion,TiempoDuracion,FechaFinReunion,IdTipoReunionComite,IdLugarReunion,FechaRegistro,FechaModificacion,Usuario,IdEstado)
values
(
	@FechaReunion,
	@Duracion,
	@FechaFinReunion,
	@TipoReunionComite,
	@LugarReunion,
	@FechaRegistro,
	@FechaModificacion,
	@Usuario,
	1
)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListaAcuerdo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListaAcuerdo]
(
				@IdProgramacionComite int	
)
as
select 
				a.IdAcuerdosxComite as Codigo,
				a.numeroacuerdo as NumAcuerdo,
				a.descripcion as Descripcion,
				convert(varchar,a.fechacomprometida,103) as Fecha,
				e.detalle as Estado
from			acuerdosxcomite a
inner join		estado e
on				a.idregistro = e.idregistro
where			a.IdProgramacionComite = @IdProgramacionComite
and				a.idestado='1'


GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarAgenda]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
--> Objetivo		: Listar agenda de comite
----------------------------------------------------------------------------------
-- Creacion 01		: 02/08/2018
-- Responsable		: Jean Salazar
-- Descripcion		: Sp para Listar la agenda del comite
----------------------------------------------------------------------------------

CREATE procedure [dbo].[SP_Previsor_ListarAgenda]
(
	@IdProgramacionComite int	
)
as
select 
		a.IdAgenda as Codigo,
		a.Descripcion as Descripcion,
		p.Nombres + ' ' + p.Apellidos as NomApe,
		a.idpersona as CodPer
from Agenda a
inner join Persona p
on a.IdPersona = p.IdPersona
where IdProgramacionComite = @IdProgramacionComite

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarAnioComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[SP_Previsor_ListarAnioComite]
as
select 
			DATEPART(YEAR,FechaInicioReunion) as Anio
from		ProgramacionComite
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarArea]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
--> Objetivo		: Obtiene lista de areas
----------------------------------------------------------------------------------
-- Creacion 01		: 01/08/2018
-- Responsable		: Jean Salazar
-- Descripcion		: Sp para obtener lista de areas
----------------------------------------------------------------------------------
Create Procedure [dbo].[SP_Previsor_ListarArea]
as
select 
			idconstante,
			constante 
from		constante 
where		codigoagrupador ='980'
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarAsistencia]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarAsistencia]
as
select 
		p.IdProgramacionComite as Codigo,
		ti.Descripcion as Tipo,
		t.Descripcion as TipoReunion,
		convert(varchar,FechaInicioReunion,103) as FechaReunion,
		RIGHT(CONVERT(DATETIME, FechaInicioReunion,108),8) as HoraReunion,
		(select count(IdRegistroPersonalxComite) from registropersonalxcomite r where r.IdProgramacionComite = p.IdProgramacionComite and r.idestado2=1) as Personal,
		(select count(a.IdAsistencia) from Asistencia a where a.IdProgramacionComite = p.IdProgramacionComite) as Asistencia				
from	programacioncomite p
		inner join TipoReunionComite t
		on p.IdTipoReunionComite = t.IdTipoReunionComite
		inner join TipoComite ti
		on t.IdTipoComite = ti.IdTipoComite
where	p.IdEstado=1

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarCargo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
--> Objetivo		: Listar cargo 
----------------------------------------------------------------------------------
-- Creacion 01		: 02/08/2018
-- Responsable		: Jean Salazar
-- Descripcion		: Sp para Listar cargo
----------------------------------------------------------------------------------
Create Procedure [dbo].[SP_Previsor_ListarCargo]
as
select 
			IdConstante,
			Constante 
from		Constante 
where		CodigoAgrupador = 'CARGOTRA'
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarCentroServicio]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_ListarCentroServicio]
(
		@IdUnidadNegocio int
)
as
select 
		IdCentroServicio,
		Nombre
from	centroservicio
where	IdUnidadNegocio=@IdUnidadNegocio
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarComitePersonal]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
--> Objetivo		: Obtiene Programacion de comite por personal de asistencia
----------------------------------------------------------------------------------
-- Creacion 01		: 01/08/2018
-- Responsable		: Jean Salazar
-- Descripcion		: Sp para obtener la programacion de comite por personal de asistencia.
----------------------------------------------------------------------------------

CREATE procedure [dbo].[SP_Previsor_ListarComitePersonal]
as
select 
		p.IdProgramacionComite as Codigo,
		ti.Descripcion as Tipo,
		t.Descripcion as TipoReunion,
		DATEPART(YEAR,FechaInicioReunion) as Anio,
		case
		when DATEPART(MONTH,FechaInicioReunion) = '1' then 'Enero'
		when DATEPART(MONTH,FechaInicioReunion) = '2' then 'Febrero'
		when DATEPART(MONTH,FechaInicioReunion) = '3' then 'Marzo'
		when DATEPART(MONTH,FechaInicioReunion) = '4' then 'Abril'
		when DATEPART(MONTH,FechaInicioReunion) = '5' then 'Mayo'
		when DATEPART(MONTH,FechaInicioReunion) = '6' then 'Junio'
		when DATEPART(MONTH,FechaInicioReunion) = '7' then 'Julio'
		when DATEPART(MONTH,FechaInicioReunion) = '8' then 'Agosto'
		when DATEPART(MONTH,FechaInicioReunion) = '9' then 'Septiembre'
		when DATEPART(MONTH,FechaInicioReunion) = '10' then 'OCtubre'
		when DATEPART(MONTH,FechaInicioReunion) = '11' then 'Noviembre'
		when DATEPART(MONTH,FechaInicioReunion) = '12' then 'Diciembre'
		end as Mes,
		RIGHT(CONVERT(DATETIME, FechaInicioReunion,108),8) as HoraReunion,
		(select count(IdRegistroPersonalxComite) from registropersonalxcomite r where r.IdProgramacionComite = p.IdProgramacionComite and r.IdEstado2=1) as Personal				
from	programacioncomite p
		inner join TipoReunionComite t
		on p.IdTipoReunionComite = t.IdTipoReunionComite
		inner join TipoComite ti
		on t.IdTipoComite = ti.IdTipoComite
where	p.IdEstado=1

	
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarEmpEx]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_ListarEmpEx]
as
select 
			IdEmpresaExterna,
			Descripcion
from		EmpresaExterna
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarEmpresa]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_Previsor_ListarEmpresa]
as
select 
		IdEmpresa,
		NombreCorto
from	Empresa
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarEstado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarEstado]
as
select 
			IdRegistro as Codigo,
			Detalle as Detalle
from Estado
where IdRegistro in('4','5')
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarMesComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[SP_Previsor_ListarMesComite]
as
select 
			case 
			when DATEPART(MONTH,FechaInicioReunion)=1 then 'Enero' 
			when DATEPART(MONTH,FechaInicioReunion)=2 then 'Febrero' 
			when DATEPART(MONTH,FechaInicioReunion)=3 then 'Marzo' 
			when DATEPART(MONTH,FechaInicioReunion)=4 then 'Abril' 
			when DATEPART(MONTH,FechaInicioReunion)=5 then 'Mauo' 
			when DATEPART(MONTH,FechaInicioReunion)=6 then 'Junio' 
			when DATEPART(MONTH,FechaInicioReunion)=7 then 'Julio' 
			when DATEPART(MONTH,FechaInicioReunion)=8 then 'Agosto' 
			when DATEPART(MONTH,FechaInicioReunion)=9 then 'Septiembre' 
			when DATEPART(MONTH,FechaInicioReunion)=10 then 'Octubre' 
			when DATEPART(MONTH,FechaInicioReunion)=11 then 'Noviembre' 
			when DATEPART(MONTH,FechaInicioReunion)=12 then 'diciembre' 
			end
			as Mes
from		ProgramacionComite
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarOficinaxUnidadNegocio]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_Previsor_ListarOficinaxUnidadNegocio]
(
		@IdLugarReunion int
)
as
select 
		l.IdLugarReunion,
		l.Descripcion
from	unidadNegocio u
		inner join centroservicio c
on		u.IdUnidadNegocio = c.IdUnidadNegocio
		inner join LugarReunion l
on		c.IdCentroServicio = l.IdCentroServicio
where	u.IdUnidadNegocio=@IdLugarReunion
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersona]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersona]
as
select
		IdPersona,
		  Nombres + ' ' + Apellidos as  NomApe
from Persona
where Nombres is not null
and Apellidos is not null
and Idestado =1

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaAgenda]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonaAgenda]
(
			@IdProgramacionComite int
)
as
select 
			p.IdPersona as Codigo,
			p.Nombres +' '+p.Apellidos as NomApe
from		RegistroPersonalxComite r
inner join	persona p
on			r.IdPersona = p.IdPersona
where		r.IdProgramacionComite= @IdProgramacionComite
and			r.idestado2=1
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaAsistencia]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonaAsistencia]
(
			@IdProgramacionComite int
)
as
select 
				r.IdRegistroPersonalxComite as CodReg,
				p.idpersona as Codigo,
				p.Nombres + ' ' + p.Apellidos as NomApe,
				c.Constante
from			RegistroPersonalxComite r
inner join		persona p
on				r.IdPersona = p.IdPersona
left join		constante c
on				r.idcargo = c.idconstante
where			r.IdProgramacionComite = @IdProgramacionComite
and				r.IdEstado='0'
and				r.idestado2=1


GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaAsistenciaAcuerdo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_Previsor_ListarPersonaAsistenciaAcuerdo]
(
				@IdProgramacionComite int
)
as
select 
				p.idpersona as Codigo,
				p.Nombres +' ' + p.Apellidos as NomApe
from			Asistencia a
inner join		RegistroPersonalxComite r
on				a.IdRegistroPersonalxComite = r.IdRegistroPersonalxComite
inner join		persona p
on				r.IdPersona = p.IdPersona
where			r.IdProgramacionComite =@IdProgramacionComite
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaAsistenciaOk]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonaAsistenciaOk]
(
				@IdProgramacionComite int	
)
as
select
				r.idregistropersonalxcomite as CodReg,
				pr.IdProgramacionComite as CodCom,
				p.Nombres +' '+ p.Apellidos as NomApe 
from			asistencia a
inner join		RegistroPersonalxComite r
on				a.IdRegistroPersonalxComite = r.IdRegistroPersonalxComite
inner join		persona p
on				r.idpersona = p.IdPersona
inner join		programacioncomite pr
on				a.IdProgramacionComite = pr.IdProgramacionComite
where			pr.idprogramacioncomite = @IdProgramacionComite
and				r.idestado='1'



GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaComitexId]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonaComitexId]
(
		@IdProgramacionComite int
)
as
select 
			r.IdRegistroPersonalxComite as CodigoCom,			
			p.Nombres +' '+p.Apellidos as NomApe,
			p.IdPersona as Codigo		

from persona p
inner join	RegistroPersonalxComite r
on			p.idpersona = r.idpersona
where		r.IdProgramacionComite = @IdProgramacionComite
and			r.IdEstado2=1
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaEx]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonaEx]
@IdEmpresaEx int
as
select 
		p.idpersona as Codigo,
		p.nombres +' '+ p.Apellidos as NomApe,
		c.Constante as Cargo,
		e.idcargo as CodCargo
from persona p
full outer join trabajador t
on p.idpersona = t.idpersona
full outer join constante c
on t.idcargo = c.idconstante
full outer join Externo e
on p.IdPersona = e.IdPersona
inner join EmpresaExterna ex
on e.idempresaexterna = ex.IdEmpresaExterna
where  P.Tipo ='e' and ex.IdEmpresaExterna = @IdEmpresaEx
and p.IdEstado='1'
and p.idprogramacion=1
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonaInternaExterna]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonaInternaExterna]
as
select 
		p.idPersona as Codigo,
		case
		when p.Tipo='I' then e.NombreCorto
		when p.Tipo='E' then emp.Descripcion
		end
		as NomEmp,		
		case
		when p.Tipo='I' then u.nombre
		when p.Tipo='E' then 'Externo'
		end
		as NomUn,
		case 
		when p.tipo='I' then 'Interno'
		when p.tipo='E' then 'Externo'
		end
		as Tipo,
		p.Nombres +' '+ p.apellidos as NomApe,
		c.constante as Cargo
from	empresa e
		full outer join trabajador t
		on	e.idempresa = t.idempresa
		full outer join UnidadNegocio u
		on	u.Idunidadnegocio = t.idunidadnegocio
		full outer join persona p
		on	t.IdPersona = p.IdPersona
		full outer join constante c
		on	c.idconstante = t.idcargo
		full outer join externo ex
		on	p.IdPersona = ex.IdPersona
		full outer join EmpresaExterna emp
		on	ex.IdEmpresaExterna = emp.IdEmpresaExterna
where	p.tipo in ('I' ,'E')
and		p.idestado='1'


GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarPersonalCargoIn]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarPersonalCargoIn]
@IdEmpresa int,
@IdUnidadNegocio int,
@IdCentroServicio int
as
select 
		p.idpersona as Codigo,
		p.nombres +' '+ p.Apellidos as NomApe,
		c.Constante as Cargo,
		t.idcargo as CodCargo
from persona p
full outer join trabajador t
on p.idpersona = t.idpersona
full outer join constante c
on t.idcargo = c.idconstante
where  P.Tipo ='I' and t.IdEmpresa=@IdEmpresa and t.IdUnidadNegocio=@IdUnidadNegocio and t.IdCentroServicio = @IdCentroServicio
and p.idestado='1'
and p.idprogramacion=1

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarProgramacionComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Previsor_ListarProgramacionComite]
as
select 
		p.IdProgramacionComite as Codigo,
		e.NombreCorto as Empresa,
		u.Nombre as Un,
		ti.Descripcion as Tipo,
		t.Descripcion as TipoReunion,
		convert(varchar,FechaInicioReunion,103) as FechaReunion,
		RIGHT(CONVERT(DATETIME, FechaInicioReunion,108),8) as HoraReunion,
		l.Descripcion as LugarReunion
from programacioncomite p
		inner join TipoReunionComite t
		on p.IdTipoReunionComite = t.IdTipoReunionComite
		inner join TipoComite ti
		on t.IdTipoComite = ti.IdTipoComite
		inner join LugarReunion l
		on p.IdLugarReunion = l.IdLugarReunion
		inner join CentroServicio c
		on l.IdCentroServicio=c.IdCentroServicio
		inner join UnidadNegocio u
		on c.IdUnidadNegocio = u.IdUnidadNegocio
		inner join Empresa e
		on u.IdEmpresa = e.IdEmpresa
where   p.idestado=1
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarProgramacionComitePrueba]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Previsor_ListarProgramacionComitePrueba]
(
		@IdTipoComite int,
		@FechaReunion datetime
)
as
select 
		p.IdProgramacionComite as Codigo,
		e.NombreCorto as Empresa,
		u.Nombre as Un,
		ti.Descripcion as Tipo,
		t.Descripcion as TipoReunion,
		convert(varchar,FechaInicioReunion,103) as FechaReunion,
		RIGHT(CONVERT(DATETIME, FechaInicioReunion,108),8) as HoraReunion,
		l.Descripcion as LugarReunion
from programacioncomite p
		inner join TipoReunionComite t
		on p.IdTipoReunionComite = t.IdTipoReunionComite
		inner join TipoComite ti
		on t.IdTipoComite = ti.IdTipoComite
		inner join LugarReunion l
		on p.IdLugarReunion = l.IdLugarReunion
		inner join CentroServicio c
		on l.IdCentroServicio=c.IdCentroServicio
		inner join UnidadNegocio u
		on c.IdUnidadNegocio = u.IdUnidadNegocio
		inner join Empresa e
		on u.IdEmpresa = e.IdEmpresa
where	p.FechaInicioReunion= @FechaReunion
and		ti.IdTipoComite like '%'+(case when @IdTipoComite=0 then '' else @IdTipoComite end) +'%'

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarProgramacionComitexFechayTipo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_Previsor_ListarProgramacionComitexFechayTipo]
(
		@FechaReunion as datetime,
		@Tipo int
)
as
select 
		p.IdProgramacionComite as Codigo,
		e.NombreCorto as Empresa,
		u.Nombre as Un,
		ti.Descripcion as Tipo,
		t.Descripcion as TipoReunion,
		convert(varchar,FechaInicioReunion,103) as FechaReunion,
		RIGHT(CONVERT(DATETIME, FechaInicioReunion,108),8) as HoraReunion,
		l.Descripcion as LugarReunion
from programacioncomite p
		inner join TipoReunionComite t
		on p.IdTipoReunionComite = t.IdTipoReunionComite
		inner join TipoComite ti
		on t.IdTipoComite = ti.IdTipoComite
		inner join LugarReunion l
		on p.IdLugarReunion = l.IdLugarReunion
		inner join CentroServicio c
		on l.IdCentroServicio=c.IdCentroServicio
		inner join UnidadNegocio u
		on c.IdUnidadNegocio = u.IdUnidadNegocio
		inner join Empresa e
		on u.IdEmpresa = e.IdEmpresa
where   convert(varchar,FechaInicioReunion,103) = @FechaReunion and ti.idTipoComite = @Tipo

 

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarResponsableAcuerdo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarResponsableAcuerdo]
(
				@IdAcuerdosxComite int
)
as
select 
				r.IdResponsable as CodRes,
				p.nombres+' ' +p.apellidos as NomApe,		
				r.idAcuerdosxComite as CodAcu,
				p.IdPersona as CodPer
from			Responsable r
inner join		persona p
on				r.idpersona = p.IdPersona
where			r.IdAcuerdosxComite=@IdAcuerdosxComite
				and r.IdEstado='1'
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarSubArea]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
--> Objetivo		: Obtiene lista de sub areas
----------------------------------------------------------------------------------
-- Creacion 01		: 01/08/2018
-- Responsable		: Jean Salazar
-- Descripcion		: Sp para obtener lista de sub areas
----------------------------------------------------------------------------------
create procedure [dbo].[SP_Previsor_ListarSubArea]
as
select 
			IdConstante,
			constante 
from		constante 
where		CodigoAgrupador ='GERENCIA'
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarTipoComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Previsor_ListarTipoComite]
AS
Select 
			idTipoComite,
			Descripcion,
			FechaRegistro 
from Tipocomite

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarTipoPersonal]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
--> Objetivo		: Obtiene lista de tipo de Personal
----------------------------------------------------------------------------------
-- Creacion 01		: 01/08/2018
-- Responsable		: Jean Salazar
-- Descripcion		: Sp para obtener lista de tipo de Personal
----------------------------------------------------------------------------------

create procedure [dbo].[SP_Previsor_ListarTipoPersonal]
as
select 
			IdConstante,
			Constante 
from		constante 
where		CodigoAgrupador = '370'
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarTipoReunion]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_ListarTipoReunion]
(
	@IdTipoComite int
)
as
select 
		r.IdTipoReunionComite,
		r.descripcion 
from	tipocomite t
		inner join TipoReunionComite r
on		t.IdTipoComite = r.IdTipoComite
where	t.idTipoComite = @IdTipoComite
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_ListarUnidadNegocioxEmpresa]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_Previsor_ListarUnidadNegocioxEmpresa]
(
		@IdUnidadNegocio int
)
as
select
		u.IdUnidadNegocio,
		u.Nombre
from	empresa e
		inner join UnidadNegocio u
on		e.IdEmpresa = u.IdEmpresa
where	e.IdEmpresa= @IdUnidadNegocio
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistraAcuerdos]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_RegistraAcuerdos]
(
				@NumeroAcuerdo varchar(20),
				@FechaComprometida datetime,
				@Dias int,
				@IdRegistro int,
				@IdProgramacionComite int,
				@Descripcion varchar(255),
				@IdEstado int
)
as begin
insert into AcuerdosxComite
				(NumeroAcuerdo,
				FechaComprometida,
				DiasAviso,
				IdRegistro,
				IdProgramacionComite,
				Descripcion,
				IdEstado)
				values
				(@NumeroAcuerdo,
				@FechaComprometida,
				@Dias,
				@IdRegistro,
				@IdProgramacionComite,
				@Descripcion,
				@IdEstado)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistraAgenda]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_RegistraAgenda]
(
					@Descripcion varchar(255),
					@IdPersona int,
					@IdProgramacionComite int
)
as begin
insert into Agenda(	Descripcion,
					IdPersona,
					IdProgramacionComite)
			values(@Descripcion,
				   @IdPersona,
				   @IdProgramacionComite)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistraPersona]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_RegistraPersona]
				(@IdPersona int output,
				@Nombres varchar(128),
				@Apellidopat varchar(32),
				@ApellidoMat varchar(32),
				@ApellidoPatMat varchar(64),
				@IdTipoIdentidad smallint,
				@NroIdentidad varchar(20),
				@IdEstado smallint,
				@IdArea int,
				@IdEmpresa int,
				@IdUnidadNegocio int,
				@IdCentroServicio int,
				@EsPlanillado int,
				@IdCargo int,
				@IdClasificacionCargo int,
				@Email varchar(100),
				@IdEstadoT int,
				@Tipo char(1),
				--==================
				@Sexo int,
				@Apela varchar(30),
				--==================
				@Foto image,
				@Firma image
				)
as 
begin 	
		insert into Persona
				(
				Nombres,
				ApellidoPaterno,
				ApellidoMaterno,
				Apellidos,
				IdTipoIdentidad,
				NroIdentidad,
				IdEstado,
				Tipo,
				IdProgramacion)
				values
				(
				@Nombres,
				@Apellidopat,
				@ApellidoMat,
				@ApellidoPatMat,
				@IdTipoIdentidad,
				@NroIdentidad,
				@IdEstado,
				@Tipo,
				1) 
set				@IdPersona = @@IDENTITY
if				@Tipo = 'I'
begin			
				insert into Trabajador
				(IdPersona,
				IdArea,
				IdEmpresa,
				IdUnidadNegocio,
				IdCentroServicio,
				EsPlanillado,
				IdCargo,
				IdClasificacionCargo,
				Email,
				IdEstado)
				values
				(@IdPersona,
				@IdArea,
				@IdEmpresa,
				@IdUnidadNegocio,
				@IdCentroServicio,
				@EsPlanillado,
				@IdCargo,
				@IdClasificacionCargo,
				@Email,
				@IdEstadoT)


				insert into dbo.personacomplemento
				(IdPersona,
				Sexo,
				Apelativo)
				values
				(@IdPersona,
				@Sexo,
				@Apela)


			--======================================
				Insert into dbo.personaimagen
				(IdPersona,
				Imagen,
				Firma,
				Idestado)
				values
				(@IdPersona,
				@Foto,
				@Firma,
				1)				
end
else If			@Tipo='E'
begin
				insert into dbo.Externo
				(IdPersona,
				IdEmpresaExterna,
				IdCargo,
				Email)
				values
				(@IdPersona,
				@IdEmpresa,
				@IdCargo,
				@Email)

				insert into dbo.personacomplemento
				(IdPersona,
				Sexo,
				Apelativo)
				values
				(@IdPersona,
				@Sexo,
				@Apela)
end				 
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistraPersona_prueba]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_RegistraPersona_prueba]
				(@IdPersona int output,
				@Nombres varchar(128),
				@Apellidopat varchar(32),
				@ApellidoMat varchar(32),
				@ApellidoPatMat varchar(64),
				@IdTipoIdentidad smallint,
				@NroIdentidad varchar(20),
				@IdEstado smallint,
				@IdArea int,
				@IdEmpresa int,
				@IdUnidadNegocio int,
				@IdCentroServicio int,
				@EsPlanillado int,
				@IdCargo int,
				@IdClasificacionCargo int,
				@Email varchar(100),
				@IdEstadoT int,
				@IdEmpresaex int,
				@Tipo char(1))
as 
begin 	
		insert into Persona
				(
				Nombres,
				ApellidoPaterno,
				ApellidoMaterno,
				Apellidos,
				IdTipoIdentidad,
				NroIdentidad,
				IdEstado,
				Tipo)
				values
				(
				@Nombres,
				@Apellidopat,
				@ApellidoMat,
				@ApellidoPatMat,
				@IdTipoIdentidad,
				@NroIdentidad,
				@IdEstado,
				@Tipo
				) 
set				@IdPersona = @@IDENTITY
if				@Tipo = 'I'
begin			
				insert into Trabajador
				(IdPersona,
				IdArea,
				IdEmpresa,
				IdUnidadNegocio,
				IdCentroServicio,
				EsPlanillado,
				IdCargo,
				IdClasificacionCargo,
				Email,
				IdEstado)
				values
				(@IdPersona,
				@IdArea,
				@IdEmpresa,
				@IdUnidadNegocio,
				@IdCentroServicio,
				@EsPlanillado,
				@IdCargo,
				@IdClasificacionCargo,
				@Email,
				@IdEstadoT)
end
else If			@Tipo='E'
begin
				insert into Externo(IdPersona,IdEmpresaExterna,IdCargo)
				values(@IdPersona,@IdEmpresaEx,@IdCargo)
end				 
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistrarAgenda]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_RegistrarAgenda]
(
	@Descripcion varchar(255),
	@IdPersona int,
	@IdProgramacionComite int,
	@FechaRegistro datetime,
	@FechaModificacion datetime,
	@Usuario varchar(20)
)
as
begin
insert into Agenda(Descripcion,IdPersona,IdProgramacionComite,FechaRegistro,FechaModificacion,Usuario)
values
(
	@Descripcion,
	@IdPersona,
	@IdProgramacionComite,
	@FechaRegistro,
	@FechaModificacion,
	@Usuario
)
end 

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistrarAsistencia]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_Previsor_RegistrarAsistencia]
(
			@IdProgramacionComite int,
			@IdRegistroPersonalxComite int
)
as begin
insert into Asistencia
					(
					IdProgramacionComite,
					IdRegistroPersonalxComite
					) values
					(
					@IdProgramacionComite,
					@IdRegistroPersonalxComite
					)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistrarPersonalxComite]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_RegistrarPersonalxComite]
(
		@IdProgramacionComite int,
		@IdPersona int,
		@IdCargo int		
)
as
begin
insert into RegistroPersonalxComite(IdProgramacionComite,IdPersona,IdCargo,IdEstado,IdEstado2)
values
(
		@IdProgramacionComite,
		@IdPersona,
		@IdCargo,
		0,
		1
)
end 

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistrarResponsable]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Previsor_RegistrarResponsable]
(
				@IdAcuerdosxComite int,
				@IdPersona int,
				@IdEstado int
)
as begin
insert into Responsable
				(IdAcuerdosxComite,
				IdPersona,
				IdEstado)
				values
				(@IdAcuerdosxComite,
				@IdPersona,
				@IdEstado)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_Previsor_RegistraTrabajador]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_Previsor_RegistraTrabajador]
(
				@IdPersona int,
				@IdArea int,
				@IdEmpresa int,
				@IdUnidadNegocio int,
				@IdCentroServicio int,
				@EsPlanillado int,
				@IdCargo int,
				@IdClasificacioncargo int,
				@Email varchar(96),
				@IdEstado int
)
as begin
				set nocount on
				insert into Trabajador
						(IdPersona,
						IdArea,
						IdEmpresa,
						IdUnidadNegocio,
						IdCentroServicio,
						EsPlanillado,
						IdCargo,
						idclasificacioncargo,
						email,
						IdEstado)
						values
						(@IdPersona,
						@IdArea,
						@IdEmpresa,
						@IdUnidadNegocio,
						@IdCentroServicio,
						@EsPlanillado,
						@IdCargo,
						@IdClasificacioncargo,
						@Email,
						@IdEstado
						)
end

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ArchivoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ArchivoValorDeclarado]
(
	@IdValorDeclarado int,
	@IdEstado smallint
)
AS
BEGIN

	SELECT [IdArchivo]
      ,[IdValorDeclarado]
      ,[NombreOrigen]
      ,[NombreAsignado]
      ,[Ruta]
      ,[Formato]
      ,[Estado]
  FROM [dbo].[Archivos]
  WHERE IdValorDeclarado = @IdValorDeclarado and Estado = @IdEstado
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_Area]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Area]
(
	@IdEstado smallint
)
AS
BEGIN

	SELECT *FROM dbo.Area
	WHERE IdEstado = @IdEstado
 
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_BUSCAR_PERSONA_POR_ESTADO_Y_DNI]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_S_BUSCAR_PERSONA_POR_ESTADO_Y_DNI]
(  
 @IdEstado smallint ,
 @DNI VARCHAR(8) =null
)  
AS  
BEGIN  
  
 SELECT Nombres
		,IdPersona
 FROM dbo.Persona  
 WHERE IdEstado = @IdEstado  
	and NroIdentidad=@DNI
   
END;  

GO
/****** Object:  StoredProcedure [dbo].[sp_s_buscar_personacomplemento_codigo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_s_buscar_personacomplemento_codigo]
@idPersona int
as
declare @result int

select @result=COUNT(*)  
from PersonaComplemento
where IdPersona=@idPersona

select @result

GO
/****** Object:  StoredProcedure [dbo].[SP_S_CentroCosto]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_S_CentroCosto]
(
	@IdEstado smallint
)
AS
BEGIN

SELECT [IdCentroCosto]
      ,[IdEmpresa]
      ,isnull([IdUUNN],0)IdUUNN
      ,[Codigo]
      ,[Nombre]
      ,[IdEstado]
      ,[osLastLogin]
      ,[osLastDate]
      ,[osLastApp]
      ,[osFirstLogin]
      ,[osFirstDate]
      ,[osFirstApp]
  FROM [SegurosDB].[dbo].[CentroCosto]
 WHERE IdEstado = @IdEstado
 
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_Constante]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Constante]
@IdConstante SMALLINT
AS
BEGIN
	IF(@IdConstante=0)
	BEGIN
		SELECT 
			IdConstante,
			IdPadre,
			Constante,
			Descripcion,
			CodigoAgrupador,
			Orden,
			Tag,
			CASE IdEstado
				WHEN 2
				THEN CONVERT(BIT,0)
			ELSE CONVERT(BIT,IdEstado)
			END IdEstado,
			'' ConstantePadre
		FROM 
			dbo.Constante
		WHERE IdPadre IS NULL
	END
	ELSE
	BEGIN
		SELECT 
			C1.IdConstante,
			C1.IdPadre,
			C1.Constante,
			C1.Descripcion,
			C1.CodigoAgrupador,
			CASE 
				WHEN C1.IdPadre IS NULL
				THEN CONVERT(SMALLINT,(SELECT COUNT(C2.Orden) 
										FROM Constante C2 
										WHERE C2.IdPadre=C1.IdConstante)+1)
			ELSE
				C1.Orden
			END Orden,
			C1.Tag,
			CASE C1.IdEstado
				WHEN 2
				THEN CONVERT(BIT,0)
			ELSE CONVERT(BIT,C1.IdEstado)
			END IdEstado,
			(SELECT C3.Constante FROM Constante C3 WHERE C3.IdConstante=C1.IdPadre) ConstantePadre
		FROM 
			dbo.Constante C1
		WHERE C1.IdConstante=@IdConstante
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_S_Constante_Hijo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Constante_Hijo]
@IdPadre SMALLINT,
@Constante VARCHAR(128)
AS
BEGIN
	SELECT 
		IdConstante,
		IdPadre,
		Constante,
		Descripcion,
		CodigoAgrupador,
		Orden,
		Tag,
		E.Detalle
	FROM 
		dbo.Constante C
INNER JOIN dbo.Estado E
	  ON C.IdEstado = E.IdRegistro
	WHERE IdPadre=@IdPadre
	AND (Constante LIKE '%' + @Constante + '%')
END
GO
/****** Object:  StoredProcedure [dbo].[SP_S_Constante_PorCodigoAgrupador]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Constante_PorCodigoAgrupador]
(@CodigoAgrupador VARCHAR(8))
AS
	SELECT IdConstante, IdPadre, Constante, Descripcion, CodigoAgrupador,
		   Orden, Tag
	  FROM dbo.Constante
	 WHERE CodigoAgrupador = @CodigoAgrupador
	   AND IdPadre is not null

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ConstantePorEstado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[SP_S_ConstantePorEstado]
(
	@IdEstado smallint   
)
AS
BEGIN

	SELECT [IdConstante]
      ,[IdPadre]
      ,[Constante]
      ,[Descripcion]
      ,[CodigoAgrupador]
      ,[Orden]
      ,[IdEstado]
  FROM [SegurosDB].[dbo].[Constante]
  where IdEstado = @IdEstado;
  
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_DevuelveValorDeclarado_PorTipoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_DevuelveValorDeclarado_PorTipoValorDeclarado]
(
	@IdTipoValorDeclarado smallint 
)
AS
BEGIN

	SELECT 
	  COUNT(b.IdValorDeclarado)   
  FROM seg.[ValorDeclarado] a with(nolock)
  INNER JOIN seg.[ValorDeclaradoDetalle] 	b with(nolock)
  on a.IdValorDeclarado = b.IdValorDeclarado
  WHERE 
		b.IdTipoValorDeclarado = @IdTipoValorDeclarado and a.IdEstado = 0 and b.IdEstado = 1
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_DivisionPoliza_PorTipoPoliza]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_DivisionPoliza_PorTipoPoliza]
(@IdTipoPoliza smallint)
AS
	SELECT IdDivisionPoliza, Descripcion, Abreviatura, AplicaProveedor,
		   DP.IdEstado, E.Detalle
	  FROM seg.DivisionPoliza DP
INNER JOIN Estado E 
		ON DP.IdEstado = E.IdRegistro
	 WHERE DP.IdTipoPoliza = @IdTipoPoliza
GO
/****** Object:  StoredProcedure [dbo].[SP_S_Empresa]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_Empresa]
AS
BEGIN

	SELECT [IdEmpresa], NombreCorto
	FROM [dbo].[Empresa] 
END;

 

GO
/****** Object:  StoredProcedure [dbo].[SP_S_Estado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Estado]
AS
BEGIN
	SELECT [IdRegistro], [Detalle]
	FROM [dbo].[Estado]
	WHERE [IdEstado] = 1
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_S_Marca]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[SP_S_Marca]
(
	@IdEstado smallint   
)
AS
BEGIN

	SELECT [IdMarca]
      ,[Descripcion]
      ,[Abreviatura]
      ,[IdTipo]
      ,[IdEstado]
  FROM [SegurosDB].[dbo].[Marca]
  where IdEstado = @IdEstado;
  
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_Modelo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[SP_S_Modelo]
(
	@IdEstado smallint   
)
AS
BEGIN

	SELECT [IdModelo]
      ,[IdMarca]
      ,[Descripcion]
      ,[Abreviatura]
      ,[IdEstado]
  FROM [SegurosDB].[dbo].[Modelo]
  where IdEstado = @IdEstado;
  
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_Moneda]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Moneda]

AS
BEGIN

	SELECT [IdMoneda], [Moneda]
	FROM [dbo].[Moneda]
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_NotificarAutorizacion]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_NotificarAutorizacion]
(
	@IdValorDeclarado	INT,
	@IdProceso			INT,
	@Dominio 			VARCHAR(100)
)
AS

BEGIN

SET NOCOUNT ON
		
-- ====================================================================================================
-- VARIABLES
-- ====================================================================================================
DECLARE @HTML				NVARCHAR(MAX)	= '',
		@BodyHTML			NVARCHAR(MAX)	= '',
		@HeadHTML			NVARCHAR(MAX)	= N'<head><style>h1{color:#0000A8;}span{font-size:24px;}div,table{color:#000080;}table,td{border:1px solid #800000;}table{font-family:tahoma;font-size:12;}th{background-color:#CC0000;color:white;font-weight:bold;height:20px;padding:3px;text-align:right;}td{padding:5px;text-align:left;}.red{color:#bc0000}.horizontal{width:100%;}.horizontal th,.horizontal td{text-align:center;}tr:hover{background-color:#f5f5f5;cursor:hand;}</style></head>'--.vertical thead{float:left;}.verticalthead th{display:block;}.vertical tbody{float:right;}
		
DECLARE @IdPersona INT,
		@IdEmpresa SMALLINT,
		@Recipients VARCHAR(MAX),
		@ClaveUnica UNIQUEIDENTIFIER
		
SELECT @IdEmpresa = VD.IdEmpresa
FROM seg.ValorDeclarado VD with (NOLOCK) 
	INNER JOIN Empresa E
		ON E.IdEmpresa = VD.IdEmpresa
WHERE IdValorDeclarado = @IdValorDeclarado
		   
SELECT TOP 1 @ClaveUnica = VDA.IdClaveUnica
	,	@IdPersona = T.IdPersona
	,	@Recipients = T.Email+';'
FROM seg.ValorDeclaradoAutorizacion VDA
	INNER JOIN Trabajador T
			ON VDA.IdTrabajador = T.IdTrabajador
WHERE VDA.IdValorDeclarado = @IdValorDeclarado
AND VDA.IdProceso = @IdProceso
AND VDA.IdEstado = 4
ORDER BY VDA.OrdenAutoriza ASC

 
SELECT @Recipients = @Recipients+M.Valor+';'
FROM dbo.PersonaContacto C(NOLOCK)
INNER JOIN dbo.PersonaContactoComunicacion M(NOLOCK) ON C.IdPersonaContacto = M.IdPersonaContacto
WHERE C.IdPersona = @IdPersona
AND C.IdEstado = 1
AND M.IdEstado = 1
AND M.IdTipoComunicacion = 77

-- ====================================================================================================
-- MAIL
-- ====================================================================================================
BEGIN

-- ====================================================================================================
-- BODY
-- ====================================================================================================
	SET @BodyHTML =	'<H1>Autorización de Valor Declarado</H1>'
	SET	@BodyHTML += '<p>Se solicitó la autorización de la empresa para el siguiente valor declarado:<p>'
	SET	@BodyHTML += '<table>'
	SET @BodyHTML += (SELECT 'tr/th' = 'Empresa',
								'tr/td' = E.NombreCorto,
								'x'		= NULL,
								'tr/th' = 'Fecha Inicio',
								'tr/td' = CONVERT(VARCHAR(10), VD.FechaVigenciaInicio, 103),
								'x'		= NULL,
								'tr/th' = 'Fecha Termino',
								'tr/td' = CONVERT(VARCHAR(10), VD.FechaVigenciaTermino, 103),
								'x'		= NULL,
								'tr/th' = 'Moneda',
								'tr/td' = M.Moneda,
								'x'		= NULL,
								'tr/th' = 'Importe',
								'tr/td' =CONVERT(VARCHAR(50), CAST( CONVERT(decimal(12,2), tblImporte.dbImporteTotal) AS MONEY ),1)  
						FROM seg.ValorDeclarado VD with(nolock) 
					INNER JOIN Moneda M
							ON M.IdMoneda = VD.IdMoneda
					INNER JOIN Empresa E
							ON E.IdEmpresa = VD.IdEmpresa
					CROSS APPLY (select isnull(SUM(vdd.ImporteValorDeclarado) ,0)*isnull(vd.TipoCambio,1) dbImporteTotal
									from  seg.ValorDeclaradoDetalle vdd							 									 
									where vdd.IdValorDeclarado=vd.IdValorDeclarado) tblImporte
						WHERE IdValorDeclarado = @IdValorDeclarado
					 
						FOR XML PATH('')--, ELEMENTS XSINIL
						)
	SET @BodyHTML += '</table>'
	SET @BodyHTML += '<p>Para realizar la autorización debe hacer click en el siguiente enlace:'
	SET @BodyHTML += ' <A href="http://' + @Dominio + '/Autorizacion/Autorize?Id='+CAST(@ClaveUnica AS NVARCHAR(MAX))+'&IdValorDeclarado='+CAST(@IdValorDeclarado AS VARCHAR)+'">Aqui</A>'
	SET @BodyHTML += '<p>'
--	SET @BodyHTML += '<form sttle="font-size: 12px;" method="post" action="http://' + @Dominio + '/Autorizacion/Autorize" name="frmAutorizacionEmail">'
	--SET @BodyHTML +='<input type="text" name="Id" value="'+CAST(@ClaveUnica AS NVARCHAR(MAX))+'" style="display:none"/>'
	--SET @BodyHTML +='<input type="text" name="IdValorDeclarado" value="'+CAST(@IdValorDeclarado AS VARCHAR)+'" style="display:none"/>'
--	SET @BodyHTML += '<p>Para realizar la autorización debe hacer click en el siguiente enlace: '
	--SET @BodyHTML += '<input type="submit" value="'+CAST(@ClaveUnica AS NVARCHAR(MAX))+'" style="color:#0000a8;text-decoration:uderline;background:transparent;border:0;text-decoration:underline;"/><p>'
--	SET @BodyHTML += '<input type="submit" value="Aquí" style="color:#0000a8;text-decoration:uderline;background:transparent;border:0;text-decoration:underline;"/><p>'
--	SET @BodyHTML +='</form>'
-- ====================================================================================================
-- VALIDA SI HAY DATA
-- ====================================================================================================
	IF @BodyHTML IS NULL GOTO FIN

-- ====================================================================================================
-- HTML
-- ====================================================================================================
	SET @HTML = '<html>' + @HeadHTML + @BodyHTML + '</html>'

-- ====================================================================================================
	--SEND MAIL
	--====================================================================================================
	EXEC dbo.Notificacion_EnviarEmail_pa
			@p_Destinatarios           		= @Recipients,
			@p_Mensaje                      = @HTML,
			@p_IdProceso					= @Idproceso,
			@p_IdEmpresa					= @IdEmpresa,
			@p_IdUnidadNegocio				= 57

END

FIN:		
		SELECT @@ROWCOUNT
END


GO
/****** Object:  StoredProcedure [dbo].[SP_S_PendienteAutorizacion]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_PendienteAutorizacion]
@IdValorDeclarado int
AS
	SELECT TOP 1 IdValorDeclaradoAutorizacion,
			 IdValorDeclarado,
		     IdArea,
		     IdCargo,
		     IdTrabajador,
		     OrdenAutoriza
	  FROM seg.ValorDeclaradoAutorizacion (NOLOCK)
	 WHERE IdValorDeclarado = @IdValorDeclarado
	   AND IdEstado = 4
  ORDER BY OrdenAutoriza ASC
GO
/****** Object:  StoredProcedure [dbo].[SP_S_Persona]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_Persona]
(
	@IdEstado smallint
)
AS
BEGIN

	SELECT *FROM dbo.Persona
	WHERE IdEstado = @IdEstado
 
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_RamoPoliza_PorCodigoAgrupador]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_RamoPoliza_PorCodigoAgrupador]
(@CodigoAgrupador VARCHAR(8))
AS
	SELECT IdConstante, IdPadre, Constante, Descripcion, CodigoAgrupador,
		   Orden, Tag
	  FROM dbo.Constante
	 WHERE CodigoAgrupador = @CodigoAgrupador
	   AND IdPadre is not null

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ReportePatrimonial]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ReportePatrimonial]  
@IdTipoPoliza smallint,  
@IdEmpresa smallint,  
@FechaVigenciaInicio date,  
@FechaVigenciaFin date  
AS  
-- se cambio 107 por 24   
 SELECT VDDD.IdDivisionPoliza,  
     DP.Descripcion,  
     TMP_EXT.IdEmpresa,  
     TMP_EXT.NombreCorto,  
     TMP_EXT.IdTipoValorDeclarado,  
       case when TVD.Nombre='Cantidad de Practicantes'
			THEN 'Practicantes'
		 when TVD.Nombre='Cantidad de Trabajadores'
			THEN 'Trabajadores'
		 when TVD.Nombre='Cantidad de Vehículos'
			THEN 'Vehiculos'
		else 
			TVD.Nombre
		end Nombre,    
     ISNULL(SUM(VDDD.Cantidad),0) AS Cantidad,  
     SUM(VDDD.ImporteValorDeclarado*isnull(TMP_EXT.TipoCambio,1)) AS Importe
   FROM seg.ValorDeclaradoDetalleDisgregado VDDD  
INNER JOIN (  
   SELECT TMP_INT.IdEmpresa,  
       TMP_INT.NombreCorto,  
       VDD.IdValorDeclarado,  
       TMP_INT.TipoCambio,  
       VDD.IdValorDeclaradoDetalle,  
       VDD.IdTipoValorDeclarado  ,
       VDD.ImporteValorDeclarado,
       VDD.Cantidad
     FROM seg.ValorDeclaradoDetalle VDD  
  INNER JOIN(  
     SELECT VD.IdValorDeclarado,  
         ISNULL(VD.TipoCambio,1) AS TipoCambio,  
         E.IdEmpresa,   
         E.NombreCorto  
       FROM seg.ValorDeclarado VD  
    INNER JOIN dbo.Empresa E  
      ON VD.IdEmpresa = E.IdEmpresa  
      WHERE VD.IdEstado in( 107,106,105,24)
        AND E.IdEstado = 1  
        AND(
		(@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR 
		convert(Date, VD.FechaVigenciaInicio, 103) 
		BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103)
		)
		) TMP_INT   
      ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado  
   WHERE VDD.IdEstado = 1  
     AND VDD.IdTipoRegistro = 56) TMP_EXT  
  ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle  
INNER JOIN seg.TipoValorDeclarado TVD  
  ON TVD.IdTipoValorDeclarado = TMP_EXT.IdTipoValorDeclarado    
INNER JOIN seg.DivisionPoliza DP  
  ON VDDD.IdDivisionPoliza = DP.IdDivisionPoliza  
  WHERE VDDD.IdTipoPoliza = @IdTipoPoliza  
		AND VDDD.IdEstado=1
		AND (CONVERT(VARCHAR(13),TMP_EXT.IdEmpresa) LIKE '%'+CASE WHEN @IdEmpresa=0 THEN ''
															ELSE CONVERT(VARCHAR(30), @IdEmpresa )
															END	
														+'%')
  GROUP BY TMP_EXT.IdEmpresa, TMP_EXT.NombreCorto, TMP_EXT.IdTipoValorDeclarado, TVD.Nombre,  
     VDDD.IdDivisionPoliza, DP.Descripcion 
--  UNION  
--   SELECT VDDD.IdDivisionPoliza,  
--     DP.Descripcion,  
--       TMP_EXT.IdEmpresa,  
--     TMP_EXT.NombreCorto,  
--     TMP_EXT.IdTipoValorDeclarado,  
--     TVD.Nombre,  
--     SUM(VDDD.CantidadAjustada) AS Cantidad,  
--     SUM(VDDD.ImporteAjustado*TMP_EXT.TipoCambio) AS Importe  
--   FROM seg.ValorDeclaradoDetalleDisgregado VDDD  
--INNER JOIN (  
--   SELECT TMP_INT.IdEmpresa,  
--       TMP_INT.NombreCorto,  
--       VDD.IdValorDeclarado,  
--       TMP_INT.TipoCambio,  
--       VDD.IdValorDeclaradoDetalle,  
--       VDD.IdTipoValorDeclarado  
--     FROM seg.ValorDeclaradoDetalle VDD  
--  INNER JOIN(  
--     SELECT VD.IdValorDeclarado,  
--         ISNULL(VD.TipoCambio,1) AS TipoCambio,  
--         E.IdEmpresa,   
--         E.NombreCorto  
--       FROM seg.ValorDeclarado VD  
--    INNER JOIN dbo.Empresa E  
--      ON VD.IdEmpresa = E.IdEmpresa  
--      WHERE VD.IdEstado = 106  
--        AND E.IdEstado = 1  
--        AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))) TMP_INT   
--      ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado  
--   WHERE VDD.IdEstado = 1  
--     AND VDD.IdTipoRegistro = 56) TMP_EXT  
--  ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle  
--INNER JOIN seg.TipoValorDeclarado TVD  
--  ON TVD.IdTipoValorDeclarado = TMP_EXT.IdTipoValorDeclarado   
--INNER JOIN seg.DivisionPoliza DP  
--  ON VDDD.IdDivisionPoliza = DP.IdDivisionPoliza   
--  WHERE VDDD.IdTipoPoliza = @IdTipoPoliza  
--  GROUP BY TMP_EXT.IdEmpresa, TMP_EXT.NombreCorto, TMP_EXT.IdTipoValorDeclarado, TVD.Nombre,  
--     VDDD.IdDivisionPoliza, DP.Descripcion

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ReportePersonal]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ReportePersonal]
@IdTipoPoliza smallint,
@IdEmpresa smallint,
@FechaVigenciaInicio date,
@FechaVigenciaFin date
AS
-- SE REEMPLAZO EL 107 POR 24 
select tmp.Empresa
		,SUM(tmp.CantidadPracticantes)CantidadPracticantes
		,SUM(tmp.CantidadTrabajadores)CantidadTrabajadores
		,SUM(tmp.ImportePracticantes)ImportePracticantes
		,SUM(tmp.ImporteTrabajadores)ImporteTrabajadores
from(
	SELECT (CASE 
			WHEN EMPR.NombreCorto IS NULL THEN EMPR.NombreCorto 
			ELSE EMPR.NombreCorto END) AS Empresa
			,EMPR.IdEmpresa
			,ISNULL(cast(TRAB.iCantidadTrabajador as decimal(12,2)),0) CantidadTrabajadores
			,ISNULL(TRAB.fImporteMensual ,0)*ISNULL(VD.TipoCambio,1) ImporteTrabajadores
			,isnull(cast(pract.iCantidadTrabajador as decimal(12,2)),0) CantidadPracticantes
			,isnull(pract.fImporteMensual,0)*ISNULL(VD.TipoCambio,1) ImportePracticantes
	FROM seg.ValorDeclarado VD
	INNER JOIN Empresa EMPR
	ON VD.IdEmpresa=EMPR.IdEmpresa
	OUTER APPLY(SELECT  SUM(VDDD.Cantidad) iCantidadTrabajador
						,SUM(VDDD.ImporteValorDeclarado) fImporteMensual
				FROM  seg.ValorDeclaradoDetalle VDD			 
				INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
				ON VDD.IdValorDeclaradoDetalle=VDDD.IdValorDeclaradoDetalle
				WHERE VDD.IdValorDeclarado=VD.IdValorDeclarado
					  AND VDD.IdTipoValorDeclarado=2
					  --AND VDD.IdTipoRegistro=56
					  AND VDDD.IdTipoPoliza=@IdTipoPoliza
					  AND VDDD.IdEstado=1) TRAB
	OUTER APPLY(SELECT  SUM(VDDD.Cantidad) iCantidadTrabajador
						,SUM(VDDD.ImporteValorDeclarado) fImporteMensual
				FROM  seg.ValorDeclaradoDetalle VDD			 
				INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
				ON VDD.IdValorDeclaradoDetalle=VDDD.IdValorDeclaradoDetalle
				WHERE VDD.IdValorDeclarado=VD.IdValorDeclarado
					  AND VDD.IdTipoValorDeclarado=1
					  --AND VDD.IdTipoRegistro=56
					  AND VDDD.IdTipoPoliza=@IdTipoPoliza
					  AND VDDD.IdEstado=1) pract				  
	WHERE ((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' )
	 OR convert(Date, VD.FechaVigenciaInicio, 103) 
	 BETWEEN convert(Date, @FechaVigenciaInicio, 103) 
	 AND convert(Date, @FechaVigenciaFin, 103)) 
	 AND VD.IdEstado in( 107,106,105,24)
 ) tmp 
 WHERE CONVERT(varchar(13),tmp.IdEmpresa) like (case when @IdEmpresa=0 
													   then '%%'
													   else ''+CONVERT(varchar(30),@IdEmpresa)+''
													   end)
 group by tmp.Empresa 
 having SUM(tmp.CantidadPracticantes)<>0 or SUM(tmp.CantidadTrabajadores)<>0
--SELECT (CASE 
--		WHEN TMP_TRAB.NombreCorto IS NULL THEN TMP_PRACT.NombreCorto 
--		ELSE TMP_TRAB.NombreCorto END) AS Empresa,
--	   TMP_TRAB.CantidadTrabajadores,
--	   TMP_TRAB.ImporteTrabajadores,
--	   TMP_PRACT.CantidadPracticantes,
--	   TMP_PRACT.ImportePracticantes
--  FROM	
--	   (SELECT TMP_EXT.IdEmpresa,
--			   TMP_EXT.NombreCorto,
--			   SUM(VDDD.Cantidad) AS CantidadPracticantes,
--			   SUM(VDDD.ImporteValorDeclarado*TMP_EXT.TipoCambio) AS ImportePracticantes
--		  FROM seg.ValorDeclaradoDetalleDisgregado VDDD
--	INNER JOIN	(
--				SELECT TMP_INT.IdEmpresa,
--					   TMP_INT.NombreCorto,
--					   VDD.IdValorDeclarado,
--					   TMP_INT.TipoCambio,
--					   VDD.IdValorDeclaradoDetalle,
--					   VDD.IdTipoValorDeclarado
--				  FROM seg.ValorDeclaradoDetalle VDD
--			INNER JOIN(
--						SELECT VD.IdValorDeclarado,
--							   ISNULL(VD.TipoCambio,1) AS TipoCambio,
--							   E.IdEmpresa, 
--							   E.NombreCorto
--						  FROM seg.ValorDeclarado VD
--					INNER JOIN dbo.Empresa E
--							ON VD.IdEmpresa = E.IdEmpresa
--						 WHERE VD.IdEstado = 24
--						   AND E.IdEstado = 1
--						   AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))) TMP_INT 
--				   ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado
--				WHERE VDD.IdEstado = 1
--				  AND VDD.IdTipoValorDeclarado = 1 -- PRACTICANTES
--				  AND VDD.IdTipoRegistro = 56) TMP_EXT
--			ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle	 
--		 WHERE VDDD.IdTipoPoliza = @IdTipoPoliza
--	  GROUP BY TMP_EXT.IdEmpresa, TMP_EXT.NombreCorto
--	  UNION
--  		SELECT TMP_EXT.IdEmpresa,
--  			   TMP_EXT.NombreCorto,
--			   SUM(VDDD.CantidadAjustada) AS CantidadPracticantes,
--			   SUM(VDDD.ImporteAjustado*TMP_EXT.TipoCambio) AS ImportePracticantes
--		  FROM seg.ValorDeclaradoDetalleDisgregado VDDD
--	INNER JOIN	(
--				SELECT TMP_INT.IdEmpresa,
--					   TMP_INT.NombreCorto,
--					   VDD.IdValorDeclarado,
--					   TMP_INT.TipoCambio,
--					   VDD.IdValorDeclaradoDetalle,
--					   VDD.IdTipoValorDeclarado
--				  FROM seg.ValorDeclaradoDetalle VDD
--			INNER JOIN(
--						SELECT VD.IdValorDeclarado,
--							   ISNULL(VD.TipoCambio,1) AS TipoCambio,
--							   E.IdEmpresa, 
--							   E.NombreCorto
--						  FROM seg.ValorDeclarado VD
--					INNER JOIN dbo.Empresa E
--							ON VD.IdEmpresa = E.IdEmpresa
--						 WHERE VD.IdEstado = 106
--						   AND E.IdEstado = 1
--						   AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))) TMP_INT 
--				   ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado
--				WHERE VDD.IdEstado = 1
--				  AND VDD.IdTipoValorDeclarado = 1 -- PRACTICANTES
--				  AND VDD.IdTipoRegistro = 56) TMP_EXT
--			ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle	 
--		 WHERE VDDD.IdTipoPoliza = @IdTipoPoliza 
--	  GROUP BY TMP_EXT.IdEmpresa, TMP_EXT.NombreCorto) TMP_PRACT
--	FULL JOIN  
--	   (SELECT TMP_EXT.IdEmpresa,
--  			   TMP_EXT.NombreCorto,
--			   SUM(VDDD.Cantidad) AS CantidadTrabajadores,
--			   SUM(VDDD.ImporteValorDeclarado) AS ImporteTrabajadores
--		  FROM seg.ValorDeclaradoDetalleDisgregado VDDD
--	INNER JOIN	(
--				SELECT TMP_INT.IdEmpresa,
--					   TMP_INT.NombreCorto,
--					   VDD.IdValorDeclarado,
--					   VDD.IdValorDeclaradoDetalle,
--					   VDD.IdTipoValorDeclarado
--				  FROM seg.ValorDeclaradoDetalle VDD
--			INNER JOIN(
--						SELECT VD.IdValorDeclarado,
--							   E.IdEmpresa, 
--							   E.NombreCorto
--						  FROM seg.ValorDeclarado VD
--					INNER JOIN dbo.Empresa E
--							ON VD.IdEmpresa = E.IdEmpresa
--						 WHERE VD.IdEstado = 24
--						   AND E.IdEstado = 1
--						   AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))) TMP_INT 
--				   ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado
--				WHERE VDD.IdEstado = 1
--				  AND VDD.IdTipoValorDeclarado = 2 -- TRABAJADORES
--				  AND VDD.IdTipoRegistro = 56) TMP_EXT
--			ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle	 
--		 WHERE VDDD.IdTipoPoliza = @IdTipoPoliza
--	  GROUP BY TMP_EXT.IdEmpresa, TMP_EXT.NombreCorto
--	  UNION
--  		SELECT TMP_EXT.IdEmpresa,
--  			   TMP_EXT.NombreCorto,
--			   SUM(VDDD.CantidadAjustada) AS CantidadTrabajadores,
--			   SUM(VDDD.ImporteAjustado) AS ImporteTrabajadores
--		  FROM seg.ValorDeclaradoDetalleDisgregado VDDD
--	INNER JOIN	(
--				SELECT TMP_INT.IdEmpresa,
--					   TMP_INT.NombreCorto,
--					   VDD.IdValorDeclarado,
--					   VDD.IdValorDeclaradoDetalle,
--					   VDD.IdTipoValorDeclarado
--				  FROM seg.ValorDeclaradoDetalle VDD
--			INNER JOIN(
--						SELECT VD.IdValorDeclarado,
--							   E.IdEmpresa, 
--							   E.NombreCorto
--						  FROM seg.ValorDeclarado VD
--					INNER JOIN dbo.Empresa E
--							ON VD.IdEmpresa = E.IdEmpresa
--						 WHERE VD.IdEstado = 106
--						   AND E.IdEstado = 1
--						   AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))) TMP_INT 
--				   ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado
--				WHERE VDD.IdEstado = 1
--				  AND VDD.IdTipoValorDeclarado = 2 -- TRABAJADORES
--				  AND VDD.IdTipoRegistro = 56) TMP_EXT
--			ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle	 
--		 WHERE VDDD.IdTipoPoliza = @IdTipoPoliza
--	  GROUP BY TMP_EXT.IdEmpresa, TMP_EXT.NombreCorto) TMP_TRAB
--			ON TMP_PRACT.IdEmpresa = TMP_TRAB.IdEmpresa

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ReporteVehiculo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--COrrige
CREATE PROCEDURE [dbo].[SP_S_ReporteVehiculo]  
@IdTipoPoliza smallint,  
@IdEmpresa smallint,  
@FechaVigenciaInicio date,  
@FechaVigenciaFin date  
AS  
 --107 a 24  
 SELECT TMP_EXT.NombreCorto,  
     SUM(VDDD.Cantidad) AS Cantidad,  
     SUM(VDDD.ImporteValorDeclarado*isnull(TMP_EXT.TipoCambio,1)) AS Importe  
   FROM seg.ValorDeclaradoDetalleDisgregado VDDD  
INNER JOIN (  
   SELECT TMP_INT.IdEmpresa,  
       TMP_INT.NombreCorto,  
       VDD.IdValorDeclarado,  
       TMP_INT.TipoCambio,  
       VDD.IdValorDeclaradoDetalle,  
       VDD.IdTipoValorDeclarado ,
       VDD.ImporteValorDeclarado,
       VDD.Cantidad
     FROM seg.ValorDeclaradoDetalle VDD  
  INNER JOIN(  
     SELECT VD.IdValorDeclarado,  		 
         ISNULL(VD.TipoCambio, 1) AS TipoCambio,  
         E.IdEmpresa,   
         E.NombreCorto 
       FROM seg.ValorDeclarado VD  
    INNER JOIN dbo.Empresa E  
      ON VD.IdEmpresa = E.IdEmpresa  
      WHERE  VD.IdEstado in( 107,106,105,24) 
        AND E.IdEstado = 1  
        AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))
        ) TMP_INT   
      ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado  
   WHERE VDD.IdEstado = 1  
     AND VDD.IdTipoRegistro = 56) TMP_EXT       
  ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle    
 
  WHERE VDDD.IdTipoPoliza = @IdTipoPoliza  -- parametro por reporte(patrimoniales,vehiculo, personales)  
  AND VDDD.IdEstado=1
  and  CONVERT(varchar(13),TMP_EXT.IdEmpresa) like'%'+case when @IdEmpresa=0 
													   then ''
													   else CONVERT(varchar(30),@IdEmpresa)
													   end+'%'
  GROUP BY TMP_EXT.NombreCorto  
			,TMP_EXT.TipoCambio
 

---- 107 a 24  
-- SELECT TMP_EXT.NombreCorto,  
--     SUM(VDDD.Cantidad) AS Cantidad,  
--     SUM(VDDD.ImporteValorDeclarado*isnull(TMP_EXT.TipoCambio,1)) AS Importe  
--   FROM seg.ValorDeclaradoDetalleDisgregado VDDD  
--INNER JOIN (  
--   SELECT TMP_INT.IdEmpresa,  
--       TMP_INT.NombreCorto,  
--       VDD.IdValorDeclarado,  
--       TMP_INT.TipoCambio,  
--       VDD.IdValorDeclaradoDetalle,  
--       VDD.IdTipoValorDeclarado ,
--       VDD.ImporteValorDeclarado,
--       VDD.Cantidad
--     FROM seg.ValorDeclaradoDetalle VDD  
--  INNER JOIN(  
--     SELECT VD.IdValorDeclarado,  		 
--         ISNULL(VD.TipoCambio, 1) AS TipoCambio,  
--         E.IdEmpresa,   
--         E.NombreCorto 
--       FROM seg.ValorDeclarado VD  
--    INNER JOIN dbo.Empresa E  
--      ON VD.IdEmpresa = E.IdEmpresa  
--      WHERE  VD.IdEstado in( 107,106,105,24) 
--        AND E.IdEstado = 1  
--        AND((@FechaVigenciaInicio is null or @FechaVigenciaInicio = '' ) OR convert(Date, VD.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaVigenciaInicio, 103) AND convert(Date, @FechaVigenciaFin, 103))
--        ) TMP_INT   
--      ON TMP_INT.IdValorDeclarado = VDD.IdValorDeclarado  
--   WHERE VDD.IdEstado = 1  
--     AND VDD.IdTipoRegistro = 56) TMP_EXT       
--  ON TMP_EXT.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle    
 
--  WHERE VDDD.IdTipoPoliza = @IdTipoPoliza  -- parametro por reporte(patrimoniales,vehiculo, personales)  
--  AND VDDD.IdEstado=1
--  and  CONVERT(varchar(13),TMP_EXT.IdEmpresa) like'%'+case when @IdEmpresa=0 
--													   then ''
--													   else CONVERT(varchar(30),@IdEmpresa)
--													   end+'%'
--  GROUP BY TMP_EXT.NombreCorto  
--			,TMP_EXT.TipoCambio
 

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ReporteVehiculoDetalle]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ReporteVehiculoDetalle]
@IdEmpresa smallint,
@FechaVigenciaInicio date,
@FechaVigenciaFin date
AS		
    
SELECT  E.NombreCorto
		,tipoVehiculo.Constante Constante
		,COUNT(VDDD.Cantidad) Cantidad
		,SUM(VDDC.ValorDeclarado * ISNULL(vd.Tipocambio,1) ) Importe 
FROM Empresa E
INNER JOIN seg.ValorDeclarado VD
ON E.IdEmpresa=VD.IdEmpresa
INNER JOIN seg.ValorDeclaradoDetalle VDD
ON VD.IdValorDeclarado=VDD.IdValorDeclarado
cross apply (select distinct IdVehiculo,
							ValorDeclarado
			from seg.ValorDeclaradoDetalleComplemento
			where  VDD.IdValorDeclaradoDetalle=IdValorDeclaradoDetalle
			AND IdEstado=1) VDDC
INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
ON VDD.IdValorDeclaradoDetalle=VDDD.IdValorDeclaradoDetalle
INNER JOIN Vehiculo vh
on VDDC.IdVehiculo=vh.IdVehiculo
and vh.IdEstado=1
INNER join  Constante tipoVehiculo
on  tipoVehiculo.IdEstado=1
	and tipoVehiculo.IdConstante=vh.IdTipoVehiculo
CROSS APPLY (select top 1 segvd.TipoCambio 
			 from seg.ValorDeclarado segvd
			 where segvd.IdValorDeclarado=VD.IdValorDeclarado
			 order by segvd.IdValorDeclarado desc) tempTipoCambio	
WHERE E.IdEmpresa=@IdEmpresa
	AND CONVERT(DATE,VD.FechaVigenciaInicio,103) BETWEEN
		CONVERT(DATE,@FechaVigenciaInicio,103)
	AND  CONVERT(DATE,@FechaVigenciaFin,103)	
	AND VDDD.IdTipoPoliza=4
	AND  VD.IdEstado in( 107,106,105,24) 
	AND VDDD.IdEstado=1
 GROUP BY  E.NombreCorto
		,tipoVehiculo.Constante 		 
 
GO
/****** Object:  StoredProcedure [dbo].[SP_S_TipoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_TipoValorDeclarado]
AS
BEGIN

	SET NOCOUNT ON;

    SELECT TVD.[IdTipoValorDeclarado]
		  ,TVD.[Nombre]
		  ,TVD.[Descripcion]
		  ,TVD.[AfectaImporte]
		  ,TVD.[AfectaCantidad]
		  ,TVD.[PermiteCargaDetalle]
		  ,TVD.[IdEstado]
		  ,E.[Detalle] AS [EstadoNombre]
  FROM [seg].[TipoValorDeclarado] TVD with(nolock)
  INNER JOIN [dbo].[Estado] E with(nolock)
  ON TVD.[IdEstado] = E.[IdRegistro]
  --WHERE TVD.[IdEstado] = 1
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_TipoValorDeclarado_PorIdEstado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_TipoValorDeclarado_PorIdEstado]
(
	@IdEstado INT
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT TVD.[IdTipoValorDeclarado]
		  ,TVD.[Nombre]
		  ,TVD.[Descripcion]
		  ,TVD.[AfectaImporte]
		  ,TVD.[AfectaCantidad]
		  ,TVD.[PermiteCargaDetalle]
		  ,TVD.[IdEstado]
		  ,E.[Detalle] AS [EstadoNombre]
  FROM [seg].[TipoValorDeclarado] TVD with(nolock)
  INNER JOIN [dbo].[Estado] E with(nolock) 
  ON TVD.[IdEstado] = E.[IdRegistro]
  WHERE  TVD.[IdEstado] = @IdEstado

END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_TipoValorDeclarado_PorIdTipoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_TipoValorDeclarado_PorIdTipoValorDeclarado]
(
	@IdTipoValorDeclarado INT
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT TVD.[IdTipoValorDeclarado]
		  ,TVD.[Nombre]
		  ,TVD.[Descripcion]
		  ,TVD.[AfectaImporte]
		  ,TVD.[AfectaCantidad]
		  ,TVD.[PermiteCargaDetalle]
		  ,TVD.[IdEstado]
		  ,E.[Detalle] AS [EstadoNombre]
  FROM [seg].[TipoValorDeclarado] TVD with(nolock)
  INNER JOIN [dbo].[Estado] E with(nolock)
   ON TVD.[IdEstado] = E.[IdRegistro]
  WHERE  TVD.[IdTipoValorDeclarado] = @IdTipoValorDeclarado

END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_TipoValorDeclarado_PorValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_TipoValorDeclarado_PorValorDeclarado]
(
@IdValorDeclarado int
)
AS
	SELECT TVD.IdTipoValorDeclarado, TVD.Nombre
	  FROM seg.ValorDeclaradoDetalle VDD with(nolock)
INNER JOIN seg.TipoValorDeclarado TVD with(nolock)
		ON VDD.IdTipoValorDeclarado = TVD.IdTipoValorDeclarado
	 WHERE VDD.IdValorDeclarado = @IdValorDeclarado
	   AND VDD.IdEstado = 1
	   AND TVD.IdEstado = 1
	
	


GO
/****** Object:  StoredProcedure [dbo].[SP_S_trabajador]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_trabajador]
(
	@IdEstado smallint
)
AS
BEGIN

	SELECT *FROM dbo.Trabajador
	WHERE IdEstado = @IdEstado
 
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_trabajador_POR_ID_PERSONA]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_trabajador_POR_ID_PERSONA]  
(  
 @IDPERSONA INT,
 @IDESTADO INT
)  
AS  
BEGIN  
  
 SELECT IdTrabajador
		,IdPersona
 FROM dbo.Trabajador  
 WHERE IdPersona = @IDPERSONA
   AND IdEstado=@IDESTADO
END

GO
/****** Object:  StoredProcedure [dbo].[SP_S_Unidad_Medida]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_Unidad_Medida]

AS
BEGIN

	SELECT [IdUnidadMedida], [Nombre]
	FROM [dbo].[UnidadMedida]  

END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_UnidadNegocio]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_S_UnidadNegocio]
(
	@IdEstado smallint
)
AS
BEGIN

	SELECT *FROM dbo.UnidadNegocio
	WHERE IdEstado = @IdEstado
 
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_S_validar_importe_ajustado_y_cantidad_ajustada]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_validar_importe_ajustado_y_cantidad_ajustada]
(
@IdValorDeclaradoDetalleDisgregado int,
@CantidadAjustada decimal,
@ImporteAjustado decimal(13,2)
)
AS
	DECLARE @ERROR INT=0
	DECLARE @MENSAJE VARCHAR(MAX)
	DECLARE @CANT_REAL decimal(13,2)
	DECLARE @IMP_REAL decimal(13,2)

	IF(@CantidadAjustada IS NOT NULL)
	BEGIN
		SET @CANT_REAL = (SELECT Cantidad 
							FROM seg.ValorDeclaradoDetalleDisgregado
						   WHERE IdValorDeclaradoDetalleDisgregado = @IdValorDeclaradoDetalleDisgregado)

		IF(@CANT_REAL < @CantidadAjustada)
		BEGIN			  
		SET @ERROR=@ERROR+1		
		SET @MENSAJE='El valor de la cantidad ajustada es mayor que la cantidad disgregada'	
		END
	END
	
	IF(@ImporteAjustado IS NOT NULL)
	BEGIN
		SET @IMP_REAL = (SELECT convert(decimal(13,2),ImporteValorDeclarado )
						   FROM seg.ValorDeclaradoDetalleDisgregado
						  WHERE IdValorDeclaradoDetalleDisgregado = @IdValorDeclaradoDetalleDisgregado)
		IF(@IMP_REAL < @ImporteAjustado)
		BEGIN		
		SET @ERROR=@ERROR+1
		set @MENSAJE=CASE WHEN @ERROR>1 THEN @MENSAJE+'|' ELSE '' END
		SET @MENSAJE=@MENSAJE+'El valor del importe ajustado es mayor que el importe disgregado'	
		END
	END

SELECT error=@ERROR,mensaje=@MENSAJE	
GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ValorDeclarado]
(
	@IdEmpresa smallint,
	@FechaIni Datetime,
	@FechaFin Datetime,
	@IdEstado smallint 
)
AS
BEGIN

	SELECT 
	  [IdValorDeclarado]
      ,a.IdEmpresa
      ,c.NombreCorto as DescEmpresa
      ,[FechaVigenciaInicio]
      ,[FechaVigenciaTermino]
      ,a.IdMoneda
      ,d.Moneda as DescMoneda
      ,[TipoCambio]
      , b.Detalle as DescEstado
			,c.NombreCorto as NombreCortoEmpresa
  FROM [seg].[ValorDeclarado] a with(nolock)
		INNER JOIN [dbo].[Estado] b with(nolock) on b.IdRegistro = a.IdEstado
		LEFT JOIN [dbo].[Empresa] c with(nolock) on c.IdEmpresa = a.IdEmpresa
		LEFT JOIN [dbo].[Moneda] d with(nolock) on d.IdMoneda = a.IdMoneda
  WHERE (@FechaIni is null or @FechaIni = '' ) OR convert(Date, a.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaIni, 103) AND convert(Date, @FechaFin, 103)		
		and (@IdEmpresa is null OR a.IdEmpresa = @IdEmpresa)
		and (@IdEstado is null OR a.IdEstado = @IdEstado)
 
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclarado_page_server]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_S_ValorDeclarado_page_server]
	@IdEmpresa smallint,
	@FechaIni Datetime,
	@FechaFin Datetime,
	@IdEstado smallint,
	@iPagina int,
	@iTamaño int
AS

select temp.row
		,temp.IdValorDeclarado
		,temp.IdEmpresa
		,temp.DescEmpresa
        ,[FechaVigenciaInicio]
        ,[FechaVigenciaTermino]
        ,temp.IdMoneda
        ,temp.DescMoneda
        ,temp.[TipoCambio]
        ,temp.DescEstado
	    ,temp.NombreCortoEmpresa
	    ,temp.totalFiltrados
from( 
SELECT 
	   cast(ROW_NUMBER() OVER( ORDER BY idvalordeclarado desc) as int) AS row 
	  ,[IdValorDeclarado]
      ,a.IdEmpresa
      ,c.NombreCorto as DescEmpresa
      ,[FechaVigenciaInicio]
      ,[FechaVigenciaTermino]
      ,a.IdMoneda
      ,d.Moneda as DescMoneda
      ,[TipoCambio]
      , b.Detalle as DescEstado
	  ,c.NombreCorto as NombreCortoEmpresa
	  ,tempFiltros.totalFiltrados
  FROM [seg].[ValorDeclarado] a with(nolock)
		INNER JOIN [dbo].[Estado] b with(nolock) on b.IdRegistro = a.IdEstado
		LEFT JOIN [dbo].[Empresa] c with(nolock) on c.IdEmpresa = a.IdEmpresa
		LEFT JOIN [dbo].[Moneda] d with(nolock) on d.IdMoneda = a.IdMoneda
		Cross apply(select COUNT(temp_int.IdValorDeclarado) totalFiltrados
				from seg.ValorDeclarado temp_int
				where (@FechaIni is null or @FechaIni = '' ) OR
				convert(Date, temp_int.FechaVigenciaInicio, 103) 
						BETWEEN convert(Date, @FechaIni, 103) 
						AND convert(Date, @FechaFin, 103)		
				and (@IdEmpresa is null OR temp_int.IdEmpresa = @IdEmpresa)
				and (@IdEstado is null OR temp_int.IdEstado = @IdEstado)) tempFiltros

  WHERE ((@FechaIni is null or @FechaIni = '' ) OR convert(Date, a.FechaVigenciaInicio, 103) BETWEEN convert(Date, @FechaIni, 103) AND convert(Date, @FechaFin, 103))
		and (@IdEmpresa is null OR a.IdEmpresa = @IdEmpresa)
		and (@IdEstado is null OR a.IdEstado = @IdEstado) 
  ) temp
where row between ((@iPagina-1)*@iTamaño)+1
		  and @iTamaño*@iPagina
		  

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalle]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalle]
(
	@IdValorDeclarado int,
	@IdEstado smallint
)
AS
BEGIN

	SELECT 
	  a.IdValorDeclaradoDetalle as IdValorDeclaradoDetalle
      ,a.IdTipoValorDeclarado as IdTipoValorDeclarado
      ,b.Nombre as TipoValorDeclaradoDesc
      ,a.IdMoneda as IdMoneda
      ,c.Moneda as MonedaDesc
      ,a.ImporteValorDeclarado as ImporteValorDeclarado
      ,a.IdUnidadMedida as IdUnidadMedida
      ,d.Nombre as UnidadMedidaDesc
      ,a.Cantidad as Cantidad
  FROM [seg].[ValorDeclaradoDetalle] a with(nolock)
  INNER JOIN [seg].[TipoValorDeclarado] b with(nolock) on b.IdTipoValorDeclarado = a.IdTipoValorDeclarado
  LEFT JOIN [dbo].[Moneda] c with(nolock) on c.IdMoneda = a.IdMoneda
  LEFT JOIN [dbo].[UnidadMedida] d with(nolock) on d.IdUnidadMedida = a.IdUnidadMedida
  WHERE IdValorDeclarado = @IdValorDeclarado and a.IdEstado = @IdEstado
END;



GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalle_PorIdValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalle_PorIdValorDeclarado]
(
@IdValorDeclarado int
)
AS
	SELECT VDD.IdValorDeclaradoDetalle, TVD.Nombre, M.Moneda, VDD.ImporteValorDeclarado,
		   VDD.ImporteAjustado, UM.Nombre AS UnidadMedida, VDD.Cantidad, VDD.CantidadAjustada,
		   (CASE WHEN TVD.AfectaImporte = 1 AND TVD.AfectaCantidad = 1 THEN 'A' 
				 WHEN TVD.AfectaImporte = 1 THEN 'I'
				 WHEN TVD.AfectaCantidad = 1 THEN 'C' END) AS Afecta,
		   (CASE WHEN VDD.IdTipoRegistro = 56 THEN 'Concurso' ELSE '-' END) AS TipoRegistro, E.Detalle
	  FROM seg.ValorDeclaradoDetalle VDD with(nolock)
INNER JOIN seg.ValorDeclarado VD with(nolock)
		ON VD.IdValorDeclarado = VDD.IdValorDeclarado
INNER JOIN seg.TipoValorDeclarado TVD with(nolock)
		ON TVD.IdTipoValorDeclarado = VDD.IdTipoValorDeclarado
INNER JOIN dbo.Moneda M with(nolock)
	    ON VD.IdMoneda = M.IdMoneda
 LEFT JOIN dbo.UnidadMedida UM with(nolock)
		ON UM.IdUnidadMedida = VDD.IdUnidadMedida
INNER JOIN dbo.Estado E with(nolock)
		ON E.IdRegistro = VDD.IdEstado
	 WHERE VD.IdValorDeclarado = @IdValorDeclarado
	 and vdd.idestado=1

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalle_PorTipoValorDeclarado_ValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalle_PorTipoValorDeclarado_ValorDeclarado]
(
@IdValorDeclarado int,
@IdTipoValorDeclarado smallint
)
AS
	SELECT VDD.IdValorDeclaradoDetalle,
		   VDD.IdUnidadMedida,
		   UM.Nombre,
		   VDD.Cantidad,
		   VDD.ImporteValorDeclarado,
		   TVD.AfectaImporte,
		   TVD.AfectaCantidad
	  FROM seg.ValorDeclaradoDetalle VDD with(nolock)
INNER JOIN seg.ValorDeclarado VD with(nolock)
		ON VDD.IdValorDeclarado = VD.IdValorDeclarado
INNER JOIN seg.TipoValorDeclarado TVD with(nolock)
		ON TVD.IdTipoValorDeclarado = VDD.IdTipoValorDeclarado
 LEFT JOIN dbo.UnidadMedida UM with(nolock)
		ON UM.IdUnidadMedida = VDD.IdUnidadMedida
	 WHERE TVD.IdTipoValorDeclarado = @IdTipoValorDeclarado
	   AND VD.IdValorDeclarado = @IdValorDeclarado
	   AND VDD.IdEstado=1


GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalleComplemento]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalleComplemento] 
(
	 @IdValorDeclaradoDetalle int,	
	 @IdEstado smallint
)
AS

	SELECT 
	  a.IdUUNN  as    IdUUNN 
	  ,UNN.Nombre    UnidadNegocio
	  ,cc.Codigo   IdCentroCosto
	  ,cc.Nombre  CentroCosto
	  ,b.Placa as NroPlaca 
	  ,b.SerieMotor
	  ,b.SerieCarroceria
	  ,b.IdMarca
	  ,m.Descripcion Marca
	  ,md.IdModelo 
	  ,md.Descripcion Modelo
	  ,b.AnoFabricado
	  ,b.Clase
	  ,b.NroAsientos
	  ,b.TimonCambiado
	  ,convert(varchar(10),b.dtFechaInicio,103) fechaInicio
	  ,convert(varchar(10),b.dtFechaTermino,103) fechaTermino
	  ,b.IdMoneda
	  ,mn.Moneda
	  ,a.IdValorDeclaradoDetalleComplemento as IdValorDeclaradoDetalleComplemento
      ,a.IdValorDeclaradoDetalle  as IdValorDeclaradoDetalle        
      ,a.ValorDeclarado as ValorDeclarado  
  FROM [SegurosDB].[seg].[ValorDeclaradoDetalleComplemento] a with(nolock)
  LEFT JOIN dbo.Vehiculo b with(nolock)
   on a.IdVehiculo = b.IdVehiculo
  inner JOIN dbo.UnidadNegocio UNN
    ON b.IdUnidadNegocio=UNN.IdUnidadNegocio
    and b.IdEmpresa=UNN.IdEmpresa
  inner join CentroCosto cc
   on b.IdCentroCosto=cc.IdCentroCosto
  inner join Marca m
  on b.IdMarca=m.IdMarca
  inner join Modelo md
  on b.IdModelo=md.IdModelo
  and b.IdMarca=md.IdMarca
  inner join Moneda mn
  on b.IdMoneda=mn.IdMoneda
  WHERE a.IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle AND a.IdEstado = @IdEstado
 

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalleComplementoTrabajador]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalleComplementoTrabajador]
(
	@IdValorDeclaradoDetalle int,
	@IdEstado smallint
)
As 
	select b.Nombres as Nombre
			, b.ApellidoPaterno as ApellidoPaterno
			, b.ApellidoMaterno as ApellidoMaterno
			, b.NroIdentidad as DNI	
			,pc.FechaNacimiento		
			,c.FechaIngreso	 FechaIngreso
			,a.IdCargo IdCargo
			,cn.Constante cargo
			,a.IdArea IdArea
			,ar.Nombre area
			,a.IdNivelRiesgo IdNivelRiesgo
			,tr.Constante riesgo
			,a.IdTipoPlanilla IdTipoPlanilla
			,tp.Constante planilla
			,a.ImporteMensual ImporteMensual
			,a.ImporteGratificacion ImporteGratificacion
	from seg.ValorDeclaradoDetalleComplemento a
	inner join dbo.Trabajador c on c.IdTrabajador = a.IdTrabajador
	inner join dbo.Persona b on b.IdPersona = c.IdPersona
	left join dbo.PersonaComplemento pc on pc.IdPersona = c.IdPersona
	left join Constante cn
	on a.IdCargo=cn.IdConstante
	and cn.IdPadre=71
	left join Area ar
	on a.IdArea=ar.IdArea
	left join Constante tp
	on   a.IdTipoPlanilla=tp.IdConstante
	and tp.IdPadre=370
	left join Constante tr
	on   a.IdNivelRiesgo=tr.IdConstante
	and tr.IdPadre=360
	where a.IdValorDeclaradoDetalle=@IdValorDeclaradoDetalle and a.IdEstado = @IdEstado

GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclarado]
(
@IdValorDeclarado int
)
AS
	SELECT VDDD.IdValorDeclaradoDetalleDisgregado,
		   VDDD.IdValorDeclaradoDetalle,
		   VDD.IdTipoValorDeclarado,
		   TVD.Nombre AS TipoValorDeclarado,
		   VDDD.IdTipoPoliza,
		   C.Constante AS RamoPoliza,
		   VDDD.IdDivisionPoliza,
		   DP.Descripcion AS DivisionPoliza,
		   VDDD.IdUnidadMedida,
		   UM.Nombre AS UnidadMedida,
		   VDDD.Cantidad,
		   VDDD.IdMoneda,
		   M.Moneda,
		   VDDD.ImporteValorDeclarado
	  FROM seg.ValorDeclaradoDetalleDisgregado VDDD with(nolock)
INNER JOIN seg.ValorDeclaradoDetalle VDD with(nolock)
		ON VDD.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle
INNER JOIN seg.TipoValorDeclarado TVD with(nolock)
		ON TVD.IdTipoValorDeclarado = VDD.IdTipoValorDeclarado
INNER JOIN dbo.Constante C with(nolock)
		ON VDDD.IdTipoPoliza = C.IdConstante
INNER JOIN seg.DivisionPoliza DP with(nolock)
		ON DP.IdDivisionPoliza = VDDD.IdDivisionPoliza
 LEFT JOIN dbo.UnidadMedida UM with(nolock)
		ON UM.IdUnidadMedida = VDDD.IdUnidadMedida
INNER JOIN dbo.Moneda M with(nolock)
		ON M.IdMoneda = VDDD.IdMoneda
	 WHERE VDD.IdValorDeclarado = @IdValorDeclarado
	   AND VDDD.IdEstado = 1


GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclaradoDetalle]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclaradoDetalle]
(
@IdValorDeclaradoDetalle int
)
AS
	SELECT VDDD.IdValorDeclaradoDetalleDisgregado, C.Constante as RamoPoliza, 
		   DP.Descripcion as TipoPoliza, 
		   M.Moneda,
		   VDDD.ImporteAjustado, UM.Nombre, 
		   VDDD.CantidadAjustada, 
		   VDDD.ImporteValorDeclarado,
		   VDDD.Cantidad,
		   E.Detalle
	  FROM seg.ValorDeclaradoDetalle VDD with(nolock)
INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD with(nolock)
		ON VDD.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle
INNER JOIN dbo.Constante C with(nolock)
		ON C.IdConstante = VDDD.IdTipoPoliza
INNER JOIN seg.DivisionPoliza DP with(nolock)
	    ON DP.IdDivisionPoliza = VDDD.IdDivisionPoliza
INNER JOIN dbo.Moneda M with(nolock)
	    ON VDDD.IdMoneda = M.IdMoneda
 LEFT JOIN dbo.UnidadMedida UM with(nolock)
		ON UM.IdUnidadMedida = VDD.IdUnidadMedida
INNER JOIN dbo.Estado E with(nolock)
		ON E.IdRegistro = VDD.IdEstado
	 WHERE VDD.IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
	    AND VDDD.IdEstado = 1



GO
/****** Object:  StoredProcedure [dbo].[SP_S_ValorDeclaradoPorId]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S_ValorDeclaradoPorId]
(
	@IdValorDeclarado smallint
)
AS
BEGIN

	SELECT 
	  [IdValorDeclarado]
      ,[IdEmpresa]
      ,[FechaVigenciaInicio]
      ,[FechaVigenciaTermino]
      ,[RutaArchivo]
      ,[IdMoneda]
      ,convert(decimal(12,2),[TipoCambio] )TipoCambio
      ,[IdEstado]      
  FROM [seg].[ValorDeclarado]
  WHERE IdValorDeclarado = @IdValorDeclarado
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_S_Vehiculo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_S_Vehiculo]
(
	@IdEstado smallint   
)
AS
BEGIN

	SELECT [IdVehiculo]
	   [IdVehiculo]
      ,[IdEmpresa]
      ,[IdUnidadNegocio]
      ,[IdCentroCosto]
      ,[IdTipoVehiculo]
      ,[IdMarca]
      ,[IdModelo]
      ,[PlacaAnterior]
      ,[Placa]
      ,[SerieCarroceria]
      ,[SerieMotor]
      ,[Clase]
      ,[AnoFabricado]
      ,[IdColor]
      ,[NroAsientos]
      ,[TimonCambiado]
      ,[IdMoneda]
      ,[ValorComercial]
      ,[IdEstado]
  FROM [SegurosDB].[dbo].[Vehiculo]
  
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_U_AjustarValoresDeclarados]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_AjustarValoresDeclarados]
(
@IdValorDeclaradoDetalleDisgregado int,
@CantidadAjustada decimal,
@ImporteAjustado decimal(13,2)
)
AS
	DECLARE @CANT_REAL decimal(13,2)
	DECLARE @IMP_REAL decimal(13,2)
	
	IF(@CantidadAjustada IS NOT NULL)
	BEGIN
		SET @CANT_REAL = (SELECT Cantidad 
							FROM seg.ValorDeclaradoDetalleDisgregado
						   WHERE IdValorDeclaradoDetalleDisgregado = @IdValorDeclaradoDetalleDisgregado)
		IF(@CANT_REAL < @CantidadAjustada)
		BEGIN			  
			RAISERROR ('El valor de la cantidad ajustada es mayor que la cantidad disgregada',16, 1)
		END
	END
	
	IF(@ImporteAjustado IS NOT NULL)
	BEGIN
		SET @IMP_REAL = (SELECT convert(decimal(13,2),ImporteValorDeclarado )
						   FROM seg.ValorDeclaradoDetalleDisgregado
						  WHERE IdValorDeclaradoDetalleDisgregado = @IdValorDeclaradoDetalleDisgregado)
		IF(@IMP_REAL < @ImporteAjustado)
		BEGIN			  
			RAISERROR ('El valor del importe ajustado es mayor que el importe disgregado',16, 1)
		END
	END
	
	
	UPDATE seg.ValorDeclaradoDetalleDisgregado
	   SET CantidadAjustada = @CantidadAjustada,
		   ImporteAjustado = @ImporteAjustado
	 WHERE IdValorDeclaradoDetalleDisgregado = @IdValorDeclaradoDetalleDisgregado
GO
/****** Object:  StoredProcedure [dbo].[SP_U_Constante]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 CREATE PROCEDURE [dbo].[SP_U_Constante]
@IdConstante SMALLINT,
@Constante VARCHAR(128),
@Descripcion VARCHAR(256),
@Orden SMALLINT,
@Tag VARCHAR(32),
@IdEstado BIT
AS
DECLARE
@SI_IdEstado SMALLINT
BEGIN
	--IF (@IdEstado=0) SET @SI_IdEstado=2
	--ELSE SET @SI_IdEstado=1

	UPDATE dbo.Constante
	SET
		Constante=@Constante,
		Descripcion=@Descripcion,
		Orden=@Orden,
		Tag=@Tag,
		IdEstado=@IdEstado
	WHERE
		IdConstante=@IdConstante
END


GO
/****** Object:  StoredProcedure [dbo].[SP_U_PERSONA]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_U_PERSONA]
(    @IdPersona int out
      ,@Nombres varchar(128)
      ,@ApellidoPaterno varchar(32)
      ,@ApellidoMaterno varchar(32)
      ,@Apellidos varchar(64)
      ,@IdTipoIdentidad smallint
      ,@NroIdentidad varchar(20)
      ,@IdEstado smallint)
AS

UPDATE dbo.Persona SET Nombres=@Nombres
						,ApellidoPaterno=@ApellidoPaterno
						,ApellidoMaterno=@ApellidoMaterno
						,Apellidos=@Apellidos
						,IdTipoIdentidad=@IdTipoIdentidad
						,NroIdentidad=@NroIdentidad
						,IdEstado=@IdEstado
					where IdPersona=@IdPersona

GO
/****** Object:  StoredProcedure [dbo].[sp_u_personacomplemento]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_u_personacomplemento]
@idPersona int,
@sexo int,
@idGradoInstruccion int,
@FechaNacimiento datetime
as
update PersonaComplemento set Sexo=@sexo
							,IdGradoInstruccion=@idGradoInstruccion
							,FechaNacimiento=@FechaNacimiento
						 where IdPersona=@idPersona										
						 

GO
/****** Object:  StoredProcedure [dbo].[SP_U_TipoPoliza]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_TipoPoliza]
(@IdDivisionPoliza smallint,
@Descripcion varchar(128),
@Abreviatura varchar(32),
@AplicaProveedor bit,
@IdEstado smallint)
AS
	UPDATE seg.DivisionPoliza
	   SET Descripcion = @Descripcion,
		   Abreviatura = @Abreviatura,
		   AplicaProveedor = @AplicaProveedor,
		   IdEstado = @IdEstado
	 WHERE IdDivisionPoliza = @IdDivisionPoliza

GO
/****** Object:  StoredProcedure [dbo].[SP_U_TipoValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_TipoValorDeclarado]
(
	@IdTipoValorDeclarado smallint,
	@Nombre varchar(64),
	@Descripcion varchar(256),
	@AfectaImporte smallint,
	@AfectaCantidad smallint,
	@PermiteCargaDetalle smallint,
	@IdEstado smallint
)
AS
BEGIN

	UPDATE [seg].[TipoValorDeclarado]
	SET [Nombre] = @Nombre
      ,[Descripcion] = @Descripcion
      ,[AfectaImporte] = @AfectaImporte
      ,[AfectaCantidad] = @AfectaCantidad
      ,[PermiteCargaDetalle] = @PermiteCargaDetalle
      ,[IdEstado] = @IdEstado
	WHERE IdTipoValorDeclarado = @IdTipoValorDeclarado
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_U_TRABAJADOR]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_U_TRABAJADOR]
		@IdTrabajador int out
	  ,@IdPersona int 
      ,@IdArea smallint
      ,@IdEmpresa smallint
      ,@IdUnidadNegocio smallint
      ,@IdCentroServicio smallint
      ,@EsPlanillado smallint
      ,@IdCargo smallint
      ,@IdClasificacionCargo smallint
      ,@Email varchar(96)
      ,@CodigoSAP varchar(32)
      ,@IdEstado smallint
      ,@FechaIngreso nchar(10)
AS
		UPDATE Trabajador SET IdArea=@IdArea
							,IdEmpresa=@IdEmpresa
							,IdUnidadNegocio=@IdUnidadNegocio
							,IdCentroServicio=@IdCentroServicio
							,EsPlanillado=@EsPlanillado
							,IdCargo=@IdCargo
							,IdClasificacionCargo=@IdClasificacionCargo
							,Email=@Email
							,CodigoSAP=@CodigoSAP
							,IdEstado=@IdEstado
							,FechaIngreso=@FechaIngreso
				where IdTrabajador=@IdTrabajador
SET @IdTrabajador=@IdTrabajador

GO
/****** Object:  StoredProcedure [dbo].[SP_U_ValorDeclarado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_U_ValorDeclarado]
(
	@IdValorDeclarado int,
	@IdEmpresa smallint,
	@FechaIni Datetime,
	@FechaFin Datetime,
	@IdMoneda smallint,
	@TipoCambio decimal(12,4)
)
AS
BEGIN

	UPDATE seg.ValorDeclarado
	SET 
		IdEmpresa = @IdEmpresa,
		FechaVigenciaInicio = @FechaIni ,
		FechaVigenciaTermino = @FechaFin ,
		IdMoneda = @IdMoneda ,
		TipoCambio = @TipoCambio
	WHERE IdValorDeclarado = @IdValorDeclarado
END;


GO
/****** Object:  StoredProcedure [dbo].[SP_U_ValorDeclarado_CamposAjustados]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_ValorDeclarado_CamposAjustados]
(
@IdValorDeclarado int,
@IdValorDeclaradoDetalle int,
@Afecta char(1)
)
AS
	DECLARE @SUM_VAL_IMP DECIMAL(13,2)
	DECLARE @SUM_VAL_CNT DECIMAL(13,2)
	DECLARE @ERROR_IMP INT = 0
	DECLARE @ERROR_CNT INT = 0
	
	SET @SUM_VAL_IMP = (
							SELECT SUM(VDDD.ImporteAjustado) AS SUMA
							  FROM seg.ValorDeclaradoDetalle VDD
						INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
								ON VDD.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle
						INNER JOIN seg.ValorDeclarado VD
								ON VD.IdValorDeclarado = VDD.IdValorDeclarado
							 WHERE VD.IdValorDeclarado = @IdValorDeclarado
							   AND VDD.IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
							)
	
	SET @SUM_VAL_CNT = (
							SELECT SUM(VDDD.CantidadAjustada) AS SUMA
							  FROM seg.ValorDeclaradoDetalle VDD
						INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
								ON VDD.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle
						INNER JOIN seg.ValorDeclarado VD
								ON VD.IdValorDeclarado = VDD.IdValorDeclarado
							 WHERE VD.IdValorDeclarado = @IdValorDeclarado
							   AND VDD.IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
							)
	
	IF(@SUM_VAL_IMP > (
						SELECT SUM(VDDD.ImporteValorDeclarado) AS SUMA
						  FROM seg.ValorDeclaradoDetalle VDD
					INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
							ON VDD.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle
					INNER JOIN seg.ValorDeclarado VD
							ON VD.IdValorDeclarado = VDD.IdValorDeclarado
						 WHERE VD.IdValorDeclarado = @IdValorDeclarado
						   AND VDD.IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
						))
	BEGIN
		SET @ERROR_IMP = 1
	END
	
	IF(@SUM_VAL_CNT > (
							SELECT SUM(VDDD.Cantidad) AS SUMA
							  FROM seg.ValorDeclaradoDetalle VDD
						INNER JOIN seg.ValorDeclaradoDetalleDisgregado VDDD
								ON VDD.IdValorDeclaradoDetalle = VDDD.IdValorDeclaradoDetalle
						INNER JOIN seg.ValorDeclarado VD
								ON VD.IdValorDeclarado = VDD.IdValorDeclarado
							 WHERE VD.IdValorDeclarado = @IdValorDeclarado
							   AND VDD.IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
							))
	BEGIN
		SET @ERROR_CNT = 1
	END

	IF(@SUM_VAL_CNT <> 0 OR @SUM_VAL_IMP <>0)
	BEGIN
		IF(@ERROR_CNT = 0 AND @ERROR_IMP = 0)
		BEGIN
			IF(@Afecta = 'I')
			BEGIN
				UPDATE seg.ValorDeclaradoDetalle
				   SET ImporteAjustado = @SUM_VAL_IMP
				 WHERE IdValorDeclarado = @IdValorDeclarado
				   AND IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
			END
			ELSE IF(@Afecta = 'C')
			BEGIN	
				UPDATE seg.ValorDeclaradoDetalle
				   SET CantidadAjustada = @SUM_VAL_CNT
				 WHERE IdValorDeclarado = @IdValorDeclarado
				   AND IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
			END
			ELSE
			BEGIN
				UPDATE seg.ValorDeclaradoDetalle
				   SET CantidadAjustada = @SUM_VAL_CNT,
					   ImporteAjustado = @SUM_VAL_IMP
				 WHERE IdValorDeclarado = @IdValorDeclarado
				   AND IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
			END
		END
		ELSE
		BEGIN
			IF(@ERROR_CNT <> 0)
			BEGIN
				RAISERROR ('EL VALOR TOTAL DE LA CANTIDAD AJUSTADA ES MAYOR QUE EL CANTIDAD REAL',16, 1)
			END
			ELSE IF(@ERROR_IMP <> 0)
			BEGIN
				RAISERROR ('EL VALOR TOTAL DEL IMPORTE AJUSTADO ES MAYOR QUE EL IMPORTE REAL',16, 1)
			END
		END
	END


GO
/****** Object:  StoredProcedure [dbo].[SP_U_ValorDeclarado_Estado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_ValorDeclarado_Estado]
(
@IdValorDeclarado int,
@IdEstado smallint
)
AS
	UPDATE seg.ValorDeclarado
	   SET IdEstado = @IdEstado
	 WHERE IdValorDeclarado = @IdValorDeclarado

GO
/****** Object:  StoredProcedure [dbo].[SP_U_ValorDeclaradoAutorizacion]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_ValorDeclaradoAutorizacion]
@IdClaveUnica uniqueidentifier,
@IdEstado smallint
AS
	UPDATE seg.ValorDeclaradoAutorizacion
	   SET IdEstado = @IdEstado,
		   FechaAutorizacion = GETDATE()
	 WHERE IdClaveUnica = @IdClaveUnica
	   AND IdEstado = 4
GO
/****** Object:  StoredProcedure [dbo].[SP_U_ValorDeclaradoDetalle]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_U_ValorDeclaradoDetalle]
(
	@IdValorDeclaradoDetalle int,
	@TipoValorDeclarado smallint,
	@UnidadMedida smallint,
	@IdMoneda smallint,
	@Cantidad decimal(12,2),
	@ImporteValorDeclarado money
)
AS
BEGIN

	UPDATE seg.ValorDeclaradoDetalle
	SET 
		IdTipoValorDeclarado      = @TipoValorDeclarado,
		IdUnidadMedida            = @UnidadMedida ,
		IdMoneda                  = @IdMoneda ,
		Cantidad                  = @Cantidad,
		ImporteValorDeclarado     = @ImporteValorDeclarado
	WHERE 
		IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle
END;	

GO
/****** Object:  StoredProcedure [dbo].[SP_U_ValorDeclaradoDetalleComplementoPorEstado]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_U_ValorDeclaradoDetalleComplementoPorEstado]
(	  
	  @IdValorDeclaradoDetalle int,	  
	  @IdEstado smallint
)
AS
BEGIN

	UPDATE seg.ValorDeclaradoDetalleComplemento
	SET IdEstado = @IdEstado
	WHERE IdValorDeclaradoDetalle = @IdValorDeclaradoDetalle;	

END;


GO
/****** Object:  StoredProcedure [dbo].[SP_U_Vehiculo]    Script Date: 11/10/2018 01:16:09 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_U_Vehiculo]
(
	   @IdVehiculo int
	  ,@IdEmpresa smallint
	  ,@IdUnidadNegocio smallint
	  ,@IdCentroCosto smallint
	  ,@IdTipoVehiculo smallint
	  ,@IdMarca smallint
	  ,@IdModelo int
	  ,@PlacaAnterior varchar(10)
	  ,@Placa varchar(10)
	  ,@SerieCarroceria varchar(64)
	  ,@SerieMotor varchar(64)
	  ,@Clase varchar(64)
	  ,@AnoFabricado smallint
	  ,@IdColor smallint
	  ,@NroAsientos smallint
	  ,@TimonCambiado smallint
	  ,@IdMoneda smallint
	  ,@ValorComercial money
	  ,@IdEstado smallint
	    ,@dtFechaInicio datetime
	  ,@dtFechaTermino datetime
)
AS
BEGIN

	UPDATE [dbo].[Vehiculo]
    SET      
		   IdEmpresa        = @IdEmpresa      
		  ,IdUnidadNegocio  = @IdUnidadNegocio
		  ,IdCentroCosto    = @IdCentroCosto  
		  ,IdTipoVehiculo   = @IdTipoVehiculo 
		  ,IdMarca          = @IdMarca        
		  ,IdModelo         = @IdModelo       
		  ,Placa            = @Placa          
		  ,SerieCarroceria  = @SerieCarroceria
		  ,SerieMotor       = @SerieMotor     
		  ,Clase            = @Clase          
		  ,AnoFabricado     = @AnoFabricado         
		  ,NroAsientos      = @NroAsientos    
		  ,TimonCambiado    = @TimonCambiado  
		  ,IdMoneda         = @IdMoneda       
		  ,ValorComercial   = @ValorComercial 
		  ,dtFechaInicio=@dtFechaInicio
		  ,dtFechaTermino=@dtFechaTermino
	WHERE IdVehiculo = @IdVehiculo

	SET @IdVehiculo = @@IDENTITY
END;
GO
