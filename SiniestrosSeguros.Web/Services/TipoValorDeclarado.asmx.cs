using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SiniestrosSeguros.BL;
using static SiniestrosSeguros.DTO.ModelViews.TiposValoresDeclarados;
using Newtonsoft.Json;
using SiniestrosSeguros.DTO.ModelCustoms;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de TipoValorDeclarado
    /// </summary>
    [WebService(Namespace = "http://distriluz.com.pe/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class TipoValorDeclarado : System.Web.Services.WebService
    {
        BL.TipoValorDeclarado TVDLogic = new BL.TipoValorDeclarado();

        [WebMethod]
        public string ObtenerTiposValoresDeclarados()
        {
            return JsonConvert.SerializeObject(TVDLogic.VerTiposValoresDeclarados(), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string CrearTipoValorDeclarado(CrearTipoValorDeclaradoModelView TVD)
        {
            RespuestaWS respuestaWS = new RespuestaWS();
            if (TVDLogic.CrearTipoValorDeclarado(TVD) != null)
            {
                respuestaWS.codigo = 200;
                respuestaWS.mensaje = "La operación fue realizada correctamente";
            }
            else
            {
                respuestaWS.codigo = 500;
                respuestaWS.mensaje = "Ocurrió un error al realizar la operación";
            }
            return JsonConvert.SerializeObject(respuestaWS, Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ActualizarTipoValorDeclarado(VerTipoValorDeclaradoModelView TVD)
        {
            RespuestaWS respuestaWS = new RespuestaWS();
            if (TVDLogic.EditarTipoValorDeclarado(TVD) != null)
            {
                respuestaWS.codigo = 200;
                respuestaWS.mensaje = "La operación fue realizada correctamente";
            }
            else
            {
                respuestaWS.codigo = 500;
                respuestaWS.mensaje = "Ocurrió un error al realizar la operación";
            }
            return JsonConvert.SerializeObject(respuestaWS, Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ObtenerTipoValorDeclarado(int IdTipoValorDeclarado)
        {
            return JsonConvert.SerializeObject(TVDLogic.VerTipoValorDeclaradoPorIdTipoValorDeclarado(IdTipoValorDeclarado), Newtonsoft.Json.Formatting.Indented);
        }

    }
}
