using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de TipoPoliza
    /// </summary>
    [WebService(Namespace = "http://distriluz.com.pe/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class TipoPoliza : System.Web.Services.WebService
    {

        BL.BLogic.Constante constanteBL = new BL.BLogic.Constante();
        BL.BLogic.TipoPoliza tipoPolizaBL = new BL.BLogic.TipoPoliza();

        [WebMethod]
        public string ListarRamoPoliza()
        {
            string filtroPoliza = "TIPOLIZA";
            return JsonConvert.SerializeObject(constanteBL.ListarDetalleConstante(filtroPoliza), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ListaPolizasPorRamo(short IdTipoPoliza)
        {
            return JsonConvert.SerializeObject(tipoPolizaBL.ListarTiposPolizaPorRamoPoliza(IdTipoPoliza), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string CrearTipoPoliza(SiniestrosSeguros.DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView modalTipoPolizaModelView)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            if (!tipoPolizaBL.CrearTiposPolizaPorRamoPoliza(modalTipoPolizaModelView).esError)
            {
                respuesta.codigo = 200;
                respuesta.mensaje = "La operación fue realizada correctamente";
            }else {
                respuesta.codigo = 500;
                respuesta.mensaje = "Ocurrió un error al realizar la operación";
            }
            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ActualizarTipoPoliza(SiniestrosSeguros.DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView modalTipoPolizaModelView)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            if (!tipoPolizaBL.ActualizarTipoPoliza(modalTipoPolizaModelView).esError)
            {
                respuesta.codigo = 200;
                respuesta.mensaje = "La operación fue realizada correctamente";
            }
            else
            {
                respuesta.codigo = 500;
                respuesta.mensaje = "Ocurrió un error al realizar la operación";
            }
            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ObtenerTipoPoliza(DTO.ModelCustoms.TipoPoliza.TipoPolizaParamsModalView paramsModalView)
        {
            return JsonConvert.SerializeObject(tipoPolizaBL.ObtenerTipoPoliza(paramsModalView), Newtonsoft.Json.Formatting.Indented);
        }


    }
}
