using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SiniestrosSeguros.Web.Services
{
    /// <summary>
    /// Descripción breve de Autorizacion
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Autorizacion : System.Web.Services.WebService
    {
        BL.BLogic.ValorDeclarado valorDeclaradoBL = new BL.BLogic.ValorDeclarado();

        [WebMethod]
        public string ProcesarAutorizacion(string Id, int IdValorDeclarado)
        {
            try
            {
                short IdAprobado = Convert.ToInt16(ConfigurationManager.AppSettings["IdAprobado"]);
                short IdProceso = Convert.ToInt16(ConfigurationManager.AppSettings["IdProceso"]);
                short IdAutorizado = Convert.ToInt16(ConfigurationManager.AppSettings["IdAutorizado"]);
                string Dominio = Convert.ToString(ConfigurationManager.AppSettings["Dominio"]);
                valorDeclaradoBL.ActualizarValorDeclaradoAutorizacion(Id, IdAprobado, IdValorDeclarado, IdAutorizado, IdProceso, Dominio);
                return "La autorización se realizó correctamente.";
            }
            catch (Exception ex)
            {
                return "Ocurrió un error inesperado al realizar la autorización. Favor comuniquese con el administrador del sistema." +
                        "Detalle del error:" + ex.Message;
            }

        }
    }
}
