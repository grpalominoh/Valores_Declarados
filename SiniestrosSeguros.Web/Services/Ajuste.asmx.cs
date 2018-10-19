using SiniestrosSeguros.BL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;
using static SiniestrosSeguros.DTO.ModelViews.AjusteValorDeclarado;
using SiniestrosSeguros.DTO.ModelCustoms;
using SiniestrosSeguros.BL.BLogic;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de Ajuste
    /// </summary>
    [WebService(Namespace = "http://distriluz.com.pe/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Ajuste : System.Web.Services.WebService
    {

        AjusteValorDeclarado ajusteValorDeclarado = new AjusteValorDeclarado();

        [WebMethod]
        public string ListarTiposValorDeclarado(int IdValorDeclarado)
        {
            return JsonConvert.SerializeObject(ajusteValorDeclarado.ListarTiposValorDeclaradoPorValorDeclarado(IdValorDeclarado), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ListarTiposPoliza(int IdValorDeclaradoDetalle)
        {
            return JsonConvert.SerializeObject(ajusteValorDeclarado.ListarTiposPolizaPorValorDeclaradoDetalle(IdValorDeclaradoDetalle), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ActualizarAjusteValorDeclaradoDetalleDisgregado(AjusteValorDeclaradoModalModelView ajusteValorDeclaradoModalModelView)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            Mensaje mensaje = ajusteValorDeclarado.ActualizarAjusteValorDeclarado(ajusteValorDeclaradoModalModelView);
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
