using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SiniestrosSeguros.BL.BLogic;
using Newtonsoft.Json;
using static SiniestrosSeguros.DTO.ModelViews.Constantes;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de Constante
    /// </summary>
    [WebService(Namespace = "http://distriluz.com.pe/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Constante : System.Web.Services.WebService
    {

        BL.BLogic.Constante constanteBL = new BL.BLogic.Constante();

        [WebMethod]
        public string ListarConstantesPadre()
        {
             return JsonConvert.SerializeObject(constanteBL.VerConstantes(), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ListarConstantesHijo(short IdConstante, string Constante)
        {
            return JsonConvert.SerializeObject(constanteBL.VerConstantesHijos(IdConstante, Constante), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string CrearConstanteHijo(VerConstanteModelView Const)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            if (!constanteBL.CrearConstante(Const).esError)
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
        public string ActualizarConstanteHijo(VerConstanteModelView Const)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            if (!constanteBL.EditarConstante(Const).esError)
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
        public string ObtenerConstanteHijo(short IdConstante)
        {
            return JsonConvert.SerializeObject(constanteBL.VerConstantes(IdConstante), Newtonsoft.Json.Formatting.Indented);
        }


    }
}
