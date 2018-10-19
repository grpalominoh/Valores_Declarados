using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace SiniestrosSeguros.Web.Controllers
{
    public class AutorizacionController : Controller
    {
        // GET: Autorizacion
        public ActionResult Index()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpGet]
        public async Task<ActionResult> Autorize(string Id, int? IdValorDeclarado)
        {
            string parameters = string.Format("id={0}&IdValorDeclarado={1}", Id, IdValorDeclarado);
            HttpClient client = new HttpClient(new HttpClientHandler());
            HttpResponseMessage response = await client.GetAsync("http://" + ConfigurationManager.AppSettings["Dominio"].ToString() + "//Services/Autorizacion.asmx/ProcesarAutorizacion?" + parameters);
            if (response.IsSuccessStatusCode)
            {
                var valor = await response.Content.ReadAsStringAsync();
                if (valor != "")
                    return View();
                else
                    return HttpNotFound();
            }
            else
            {
                return HttpNotFound();
            }

        }
    }
}