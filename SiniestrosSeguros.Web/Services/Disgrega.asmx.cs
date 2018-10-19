using SiniestrosSeguros.BL.BLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using System.Web.Services;
using SiniestrosSeguros.DTO.ModelCustoms;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de Disgrega
    /// </summary>
    [WebService(Namespace = "http://distriluz.com.pe/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Disgrega : System.Web.Services.WebService
    {
        DisgregaValorDeclarado disgregaBL = new DisgregaValorDeclarado();
        BL.TipoValorDeclarado tipoValorDeclaradoBL = new BL.TipoValorDeclarado();
        BL.BLogic.TipoPoliza tipoPolizaBL = new BL.BLogic.TipoPoliza();

       [WebMethod]
        public string ObtenerTiposValorDeclaradoEnValorDeclarado(int IdValorDeclarado)
        {
            return JsonConvert.SerializeObject(tipoValorDeclaradoBL.ListaTipoValoresDeclaradosDesdeValorDeclaradoDetalle(IdValorDeclarado), Newtonsoft.Json.Formatting.Indented); 
        }

        [WebMethod]
        public string ListarTiposPoliza(short IdTipoPoliza)
        {
            return JsonConvert.SerializeObject(tipoPolizaBL.ListarTiposPolizaPorRamoPoliza(IdTipoPoliza), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ObtenerDisgregacionesDeValorDeclarado(int IdValorDeclarado)
        {
            return JsonConvert.SerializeObject(disgregaBL.ObtenerDisgregacionesValorDeclarado(IdValorDeclarado), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string InsertarDisgregacionValorDeclarado(string ListaDisgregacion, int IdValorDeclarado,
                                                         string ListaEliminadosDisgregacion, string EstadoValorDeclarado,
                                                         string ListaArchivos, string ListaArchivosEliminados)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            Mensaje mensaje = disgregaBL.InsertarDisgregacionValorDeclarado(ListaDisgregacion, IdValorDeclarado, ListaArchivos, ListaArchivosEliminados);
            if (!mensaje.esError)
            {
                respuesta.codigo = 200;
                respuesta.mensaje = mensaje.mensaje;
            }
            else
            {
                respuesta.codigo = 500;
                respuesta.mensaje = mensaje.mensaje;
            }
            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ActualizarDisgregacionValorDeclarado(string ListaDisgregacion, int IdValorDeclarado,
                                                         string ListaEliminadosDisgregacion, string EstadoValorDeclarado,
                                                         string ListaArchivos, string ListaArchivosEliminados)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            Mensaje mensaje = disgregaBL.ActualizarDisgregacionValorDeclarado(ListaDisgregacion, IdValorDeclarado, ListaEliminadosDisgregacion, ListaArchivos, ListaArchivosEliminados);
            if (!mensaje.esError)
            {
                respuesta.codigo = 200;
                respuesta.mensaje = mensaje.mensaje;
            }
            else
            {
                respuesta.codigo = 500;
                respuesta.mensaje = mensaje.mensaje;
            }
            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

    }
}
