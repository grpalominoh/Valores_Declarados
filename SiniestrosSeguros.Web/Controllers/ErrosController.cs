using SiniestrosSeguros.DTO.ModelCustoms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SiniestrosSeguros.Web.Controllers
{
    public class ErrorsController : Controller
    {
        // GET: Erros
        [AllowAnonymous]
        public ActionResult NotFound()
        {
            Mensaje msj = new Mensaje();
            msj.esError = true;
            msj.mensaje = "Error no se encontro la pagina";
            msj.status = System.Net.HttpStatusCode.NotFound;
            return View("../Common/Mensaje",msj);
        }
    }
}