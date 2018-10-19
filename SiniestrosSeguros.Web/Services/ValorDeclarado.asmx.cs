using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using static SiniestrosSeguros.DTO.ModelViews.ValorDeclarado;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de ValorDeclarado
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class ValorDeclarado : System.Web.Services.WebService
    {
        BL.BLogic.ValorDeclarado VDeclarado = new BL.BLogic.ValorDeclarado();

        [WebMethod]
        public string ListarValoresDeclarados(int IdEmpresa, string FechaVigenciaIni, string FechaVigenciaFin, int IdEstado)
        {
            BusquedaValorDeclaradoModelView busquedaValorDeclaradoModelView = new BusquedaValorDeclaradoModelView();

            busquedaValorDeclaradoModelView.IdEmpresa = Convert.ToInt16(IdEmpresa);

            if (FechaVigenciaIni != null && !FechaVigenciaIni.Equals("")) {
                busquedaValorDeclaradoModelView.FechaVigenciaIni = DateTime.Parse(FechaVigenciaIni);
            }

            if (FechaVigenciaFin != null && !FechaVigenciaFin.Equals(""))
            {
                busquedaValorDeclaradoModelView.FechaVigenciaFin = DateTime.Parse(FechaVigenciaFin);
            }

            busquedaValorDeclaradoModelView.IdEstado = Convert.ToInt16(IdEstado);


            return JsonConvert.SerializeObject(VDeclarado.ListarValoresDeclarados(busquedaValorDeclaradoModelView), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ListarValoresDeclaradosDetalle(int IdValorDeclarado, short IdEstado)
        {
            return JsonConvert.SerializeObject(VDeclarado.ListarValoresDeclaradosDetalle(IdValorDeclarado, IdEstado), Newtonsoft.Json.Formatting.Indented);
        }

        [WebMethod]
        public string ActualizarValorDeclarado(ValorDeclaradoModalModelView VD)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            if (!VDeclarado.ActualizarValorDeclarado(VD).esError)
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
        public string CrearValorDeclarado(ValorDeclaradoModalModelView VD)
        {
            DTO.ModelCustoms.RespuestaWS respuesta = new DTO.ModelCustoms.RespuestaWS();
            if (!VDeclarado.CrearValorDeclarado(VD).esError)
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
        
    }
}
