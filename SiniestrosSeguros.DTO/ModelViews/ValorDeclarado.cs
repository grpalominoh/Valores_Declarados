using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class ValorDeclarado
    {
        public class BusquedaValorDeclaradoModelView
        {
            public int IdValorDeclarado { get; set; }

            [Display(Name = "Empresa")]
            public short? IdEmpresa { get; set; }

            [Display(Name = "Empresa")]
            public string DescEmpresa { get; set; }

            [Display(Name = "Fecha de Inicio")]
            public DateTime? FechaVigenciaIni { get; set; }

            [Display(Name = "Fecha de Inicio")]
            public string FechaVigenciaIniText { get; set; }

            [Display(Name = "Fecha Fin")]
            public DateTime? FechaVigenciaFin { get; set; }

            [Display(Name = "Fecha Fin")]
            public string FechaVigenciaFinText { get; set; }

            [Display(Name = "Ruta Archivo")]
            public string RutaArchivo { get; set; }

            [Display(Name = "Moneda")]
            public short? IdMoneda { get; set; }

            [Display(Name = "Moneda")]
            public string DescMoneda { get; set; }

            [Display(Name = "Tipo de Cambio")]
            public decimal? TipoCambio { get; set; }

            [Display(Name = "Estado")]
            public short? IdEstado { get; set; }

            [Display(Name = "Estado")]
            public string DescEstado { get; set; }

            [Display(Name = "Rol")]
            public short? RolUsuario { get; set; }

            [Display(Name = "Empresa")]
            public string NombreCortoEmpresa { get; set; }
            public int iPagina { get; set; }
            public int iTamaño { get; set; }
            public short? totalFiltrados { get; set; }
        }

        public class ValorDeclaradoModalModelView
        {
            public class importeAjustadoCantidadAjustadaViewModel
            {
                public Nullable<int> error { get; set; }
                public string mensaje { get; set; }
            }

            public class CrearValorDeclaradoModelView
            {
                public int IdValorDeclarado { get; set; }



                [Required, Display(Name = "Fecha de Inicio")]
                [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:d}")]
                public DateTime? FechaVigenciaIniModal { get; set; }

                [Display(Name = "Fecha Fin")]
                [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:d}")]
                public DateTime? FechaVigenciaFinModal { get; set; }

                [Display(Name = "Ruta Archivo")]
                public string RutaArchivo { get; set; }



                [Display(Name = "Tipo de Cambio")]

                public decimal? TipoCambio { get; set; }

                [Display(Name = "Id Estado")]
                public short? IdEstado { get; set; }

                [Display(Name = "DescEstado")]
                public string DescEstado { get; set; }

                public string ValorDeclaradoDetalle { get; set; }

                public string ValorDeclaradoDetalleEliminado { get; set; }

                public string ListaArchivo { get; set; }

                public string ListaArchivoEliminado { get; set; }

                public String Archivo { get; set; }
            }

            public class CrearValorDeclaradoDetalleModelView
            {
                public int IdValorDeclaradoDetalle { get; set; }

                public int IdValorDeclarado { get; set; }

                [Required, Display(Name = "Tipo de Valor Declarado")]
                public short IdTipoValorDeclarado { get; set; }

                [Display(Name = "Tipo de Valor Declarado")]
                public string TipoValorDeclaradoDesc { get; set; }

                [Display(Name = "Moneda")]
                public short? IdMoneda { get; set; }

                [Display(Name = "Moneda")]
                public string MonedaDesc { get; set; }

                [Display(Name = "Importe Real")]
                public decimal? ImporteValorDeclarado { get; set; }

                [Display(Name = "Unidad de Medida")]
                public short? IdUnidadMedida { get; set; }

                [Display(Name = "Unidad de Medida")]
                public string UnidadMedidaDesc { get; set; }

                [Display(Name = "Cantidad")]
                public decimal? Cantidad { get; set; }

                [Display(Name = "Acción")]
                public string Accion { get; set; }

                public int FlagEdicion { get; set; }

            }

            public class VerValorDeclaradoModelView
            {
                public int IdValorDeclarado { get; set; }

                [Required, Display(Name = "Empresa")]
                public short IdEmpresa { get; set; }

                [Required, Display(Name = "Fecha de Inicio")]
                public DateTime? FechaVigenciaIniModal { get; set; }

                [Display(Name = "Fecha Fin")]
                public DateTime? FechaVigenciaFinModal { get; set; }

                [Display(Name = "Ruta Archivo")]
                public string RutaArchivo { get; set; }

                [Display(Name = "Moneda")]
                public short? IdMoneda { get; set; }

                [Display(Name = "Tipo de Cambio")]
                public decimal? TipoCambio { get; set; }

                [Display(Name = "Id Estado")]
                public short? IdEstado { get; set; }

                [Display(Name = "DescEstado")]
                public string DescEstado { get; set; }
            }

            public class ArchivoModelView
            {
                public int IdValorDeclarado { get; set; }

                public int IdArchivo { get; set; }

                [Display(Name = "Nombre Archivo")]
                public string NombreArchivo { get; set; }

                [Display(Name = "Nombre Asignado")]
                public string NombreAsignado { get; set; }

                [Display(Name = "Formato")]
                public string Formato { get; set; }

                [Display(Name = "Ruta Archivo")]
                public string RutaArchivo { get; set; }

                [Display(Name = "Id Estado")]
                public short? IdEstado { get; set; }
            }

            public class ValorDeclaradoDetalleComplementoModalView
            {
                public int IdValorDeclaradoDetalleComplemento { get; set; }
                public int IdValorDeclaradoDetalle { get; set; }
                public short IdTipoBien { get; set; }
                public int IdElementoElectrico { get; set; }
                public int IdTrabajador { get; set; }
                public int IdInstalacion { get; set; }
                public short? IdCentroCosto { get; set; }
                public short IdArea { get; set; }
                public short IdCargo { get; set; }
                public short? IdUUNN { get; set; }
                public short IdTipoPlanilla { get; set; }
                public short IdNivelRiesgo { get; set; }
                public decimal? ValorDeclarado { get; set; }
                public decimal ImporteMensual { get; set; }
                public decimal ImporteGratificacion { get; set; }
                public short IdEstado { get; set; }
                public string NombreOrigen { get; set; }
                public string NombreAsignado { get; set; }
                public string Ruta { get; set; }

                public int IdVehiculo { get; set; }
                public short IdEmpresa { get; set; }
                public string NroPlaca { get; set; }
                public string NroChasis { get; set; }
                public short IdMarca { get; set; }
                public short AnoFabricacion { get; set; }
                public short Clase { get; set; }
                public short NroAsientos { get; set; }
                public short TimonCambiado { get; set; }
                public DateTime FechaInicio { get; set; }
                public DateTime FechaFin { get; set; }
                public short IdMoneda { get; set; }
                public string NroMotor { get; set; }
                public int IdModelo { get; set; }

                public string ApellidoPaterno { get; set; }
                public string ApellidoMaterno { get; set; }
                public string Nombre { get; set; }
                public string DNI { get; set; }
                public DateTime FechaNacimiento { get; set; }
                public DateTime FechaIngreso { get; set; }
                public decimal RemuneracionMensual { get; set; }
                public decimal SubvencionMensual { get; set; }
                public decimal Graficiaciones { get; set; }
            }

            public class VDDCModalView
            {
                public short? IdUUNN { get; set; }
                [Display(Name = "Unidad Negocio")]
                public string UnidadNegocio { get; set; }
                public string IdCentroCosto { get; set; }
                [Display(Name = "Centro Costo")]
                public string CentroCosto { get; set; }
                public string NroPlaca { get; set; }
                public string SerieMotor { get; set; }
                [Display(Name = "Chasis")]
                public string SerieCarroceria { get; set; }
                [Display(Name = "idMarca")]
                public int? idMarca { get; set; }
                public string Marca { get; set; }
                [Display(Name = "idModelo")]
                public int? idModelo { get; set; }
                [Display(Name = "Modelo")]
                public string Modelo { get; set; }
                public int? AnoFabricacion { get; set; }
                public string Clase { get; set; }
                public int? Ocupantes { get; set; }
                public string TimonCambiado { get; set; }
                public string FechaInicio { get; set; }
                public string FechaTermino { get; set; }
                public int? idMoneda { get; set; }
                [Display(Name = "Moneda")]
                public string Moneda { get; set; }
                public decimal? ValorDeclarado { get; set; }

            }

            public class VDDCModalTrabajadorView
            {
                public string Nombre { get; set; }
                public String ApellidoPaterno { get; set; }
                public string ApellidoMaterno { get; set; }
                public String DNI { get; set; }
                public string FechaNacimiento { get; set; }
                public string FechaIngreso { get; set; }
                [Display(Name = "idCargo")]
                public int? idCargo { get; set; }
                [Display(Name = "Cargo")]
                public string cargo { get; set; }
                [Display(Name = "idArea")]
                public int? idArea { get; set; }
                [Display(Name = "Area")]
                public string area { get; set; }
                [Display(Name = "idNivelRiesgo")]
                public int? idNivelRiesgo { get; set; }
                [Display(Name = "Nivel Riesgo")]
                public string riesgo { get; set; }
                [Display(Name = "idTipoPlanilla")]
                public int? idTipoPlanilla { get; set; }
                [Display(Name = "Planilla")]
                public string planilla { get; set; }
                [Display(Name = "RemuneracionMensual")]
                public decimal? RemuneracionMensual { get; set; }
                [Display(Name = "Gratificacion")]
                public decimal? Graticiacion { get; set; }
                [Display(Name = "SubvencionMensual")]
                public decimal? SubvencionMensual { get; set; }
            }

            public class GestionRegistrosArchivo
            {
                public int NroRegistro { get; set; }
                public string Campo { get; set; }
                public string mensaje { get; set; }
                public string Valor { get; set; }
            }

            public class InfoArchivos
            {
                public decimal Total { get; set; }
                public int NroRegistrosTotal { get; set; }
                public int NroRegistrosOk { get; set; }
                public int NroRegistrosError { get; set; }
                public String RegistrosError { get; set; }
                public String RegistroVDDC { get; set; }
                public bool ArchivoIncorrecto { get; set; }
                public String Mensaje { get; set; }
                public List<ValorDeclaradoDetalleComplementoModalView> ListRegistroVDDC { get; set; }
                public List<GestionRegistrosArchivo> ListRegistrosError { get; set; }
            }

            public CrearValorDeclaradoModelView ValorDeclaradoCabecera { get; set; }
            public CrearValorDeclaradoDetalleModelView ValorDeclaradoDetalle { get; set; }
            public ArchivoModelView ListaArchivo { get; set; }
            public String ValorDeclaradoDetalleComplementoVH { get; set; }
            public String ValorDeclaradoDetalleComplementoTRAB { get; set; }
            public String ValorDeclaradoDetalleComplementoPRAC { get; set; }
            public int CantidadRegistroError { get; set; }
            public int CantidadRegistroOK { get; set; }
            public GestionRegistrosArchivo Registro { get; set; }

            [Display(Name = "Moneda")]
            public short? IdMoneda { get; set; }

            [Display(Name = "Empresa")]
            public short IdEmpresa { get; set; }

            [Display(Name = "Empresa")]
            public short IdTipoRegistro { get; set; }

            public short IdProceso { get; set; }
        }

        public class AjusteValorDeclaradoModelView
        {
            public class TablaTipoValorDeclaradoModelView
            {
                [Display(Name = "ID")]
                public int IdTipoValorDeclaradoDetalle { get; set; }
                [Display(Name = "Tipo de Valor Declarado")]
                public string TipoValorDeclarado { get; set; }
                [Display(Name = "Moneda")]
                public string Moneda { get; set; }
                [Display(Name = "Importe Real")]
                public decimal? ImporteReal { get; set; }
                [Display(Name = "Importe Ajustado")]
                public decimal? ImporteAjustado { get; set; }
                [Display(Name = "Unidad de Medida")]
                public string UnidadMedida { get; set; }
                [Display(Name = "Cantidad Real")]
                public decimal? CantidadReal { get; set; }
                [Display(Name = "Cantidad Ajustada")]
                public decimal? CantidadAjustada { get; set; }
                [Display(Name = "Tipo de Registro")]
                public string TipoRegistro { get; set; }
                [Display(Name = "Afecta")]
                public string Afecta { get; set; }
                [Display(Name = "Estado")]
                public string Estado { get; set; }
            }

            public class TablaTipoPolizaModelView
            {
                [Display(Name = "")]
                public int IdValorDeclaradoDetalleDisgregado { get; set; }
                [Display(Name = "Ramo de Póliza")]
                public string RamoPoliza { get; set; }
                [Display(Name = "Tipo de Póliza")]
                public string TipoPoliza { get; set; }
                [Display(Name = "Moneda")]
                public string Moneda { get; set; }
                [Display(Name = "Importe Disgregado")]
                public decimal? ImporteValorDeclarado { get; set; }
                [Display(Name = "Importe Ajustado")]
                public decimal? ImporteAjustado { get; set; }
                [Display(Name = "Unidad de Medida")]
                public string UnidadMedida { get; set; }
                [Display(Name = "Cantidad Disgregada")]
                public decimal? Cantidad { get; set; }
                [Display(Name = "Cantidad Ajustada")]
                public decimal? CantidadAjustada { get; set; }
                [Display(Name = "Estado")]
                public string Estado { get; set; }
            }

            public class AjusteValorDeclaradoModalModelView
            {
                public TablaTipoValorDeclaradoModelView TablaTipoValorDeclaradoModelView { get; set; }
                public TablaTipoPolizaModelView TablaTipoPolizaModelView { get; set; }
                public int IdValorDeclaradoDetalle { get; set; }
                public int IdValorDeclaradoDisgredado { get; set; }
                public decimal ImporteAjustado { get; set; }
                public decimal CantidadAjustada { get; set; }
            }

        }

        public class DisgregarValorDeclaradoModelView
        {
            public class TablaTipoPolizaDisgregadoModelView
            {
                public int IdValorDeclaradoDetalleDisgregado { get; set; }
                public int IdValorDeclaradoDetalle { get; set; }
                public short IdTipoValorDeclarado { get; set; }
                [Display(Name = "Tipo de Valor Declarado")]
                public string TipoValorDeclarado { get; set; }
                public short IdRamoPoliza { get; set; }
                [Display(Name = "Ramo de Póliza")]
                public string RamoPoliza { get; set; }
                public short IdTipoPoliza { get; set; }
                [Display(Name = "Tipo de Póliza")]
                public string TipoPoliza { get; set; }
                public short? IdMoneda { get; set; }
                [Display(Name = "Moneda")]
                public string Moneda { get; set; }
                [Display(Name = "Importe")]
                public decimal? Importe { get; set; }
                public short? IdUnidadMedida { get; set; }
                [Display(Name = "Unidad de medida")]
                public string UnidadMedida { get; set; }
                [Display(Name = "Cantidad")]
                public decimal? Cantidad { get; set; }
                [Display(Name = "Acción")]
                public string Accion { get; set; }
            }

            public class TablaArchivoModelView
            {
                public int IdValorDeclarado { get; set; }
                public int IdArchivo { get; set; }
                [Display(Name = "Nombre Archivo")]
                public string NombreArchivo { get; set; }
                [Display(Name = "Nombre Asignado")]
                public string NombreAsignado { get; set; }
                [Display(Name = "Formato")]
                public string Formato { get; set; }
                [Display(Name = "Ruta Archivo")]
                public string RutaArchivo { get; set; }
                [Display(Name = "Id Estado")]
                public short? IdEstado { get; set; }
            }

            public class DisgregaValorDeclaradoModalModelView
            {
                public TablaTipoPolizaDisgregadoModelView TablaTipoPolizaDisgregadoModelView { get; set; }
                public TablaArchivoModelView TablaArchivoModelView { get; set; }
                [Display(Name = "Empresa:")]
                public string Empresa;
                [Display(Name = "Fecha Registro:")]
                public string FechaRegistro { get; set; }
                [Display(Name = "Moneda")]
                public string Moneda { get; set; }
                [Display(Name = "Importe")]
                public decimal? Importe { get; set; }
                [Display(Name = "U.M.")]
                public string UnidadMedida { get; set; }
                [Display(Name = "Cantidad")]
                public decimal? Cantidad { get; set; }
            }

        }


    }
}
