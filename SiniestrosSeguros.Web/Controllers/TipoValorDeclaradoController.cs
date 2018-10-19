using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SiniestrosSeguros.DTO.ModelViews;
using SiniestrosSeguros.BL.BLogic;
using SiniestrosSeguros.BL;
using static SiniestrosSeguros.DTO.ModelViews.TiposValoresDeclarados;
using SiniestrosSeguros.DTO.ModelCustoms;

namespace SiniestrosSeguros.Web.Controllers
{
    public class TipoValorDeclaradoController : Controller
    {
        BL.TipoValorDeclarado TVDLogic = new BL.TipoValorDeclarado();
        BL.Estado EstadoLogic = new BL.Estado();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List()
        {
            JsonResult jsonResult = null;

            try
            {
                jsonResult = Json(TVDLogic.VerTiposValoresDeclarados(), JsonRequestBehavior.AllowGet);
                jsonResult.MaxJsonLength = int.MaxValue;
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

            return jsonResult;
        }

        public ActionResult Create()
        {

            //ViewBag.IdEstado = new SelectList(EstadoLogic.ListaEstados(), "IdEstado", "Detalle");

            return PartialView();
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Create(CrearTipoValorDeclaradoModelView TVD)
        {
            if (TVD != null)
                //ViewBag.IdEstado = new SelectList(EstadoLogic.ListaEstados(), "IdEstado", "Detalle", TVD.IdEstado);

            if (!ModelState.IsValid) return PartialView(TVD);

            return PartialView("../Common/Mensaje", TVDLogic.CrearTipoValorDeclarado(TVD));
        }

        public ActionResult Edit(int IdTipoValorDeclarado)
        {
            try
            {
                return PartialView(TVDLogic.VerTipoValorDeclaradoPorIdTipoValorDeclarado(IdTipoValorDeclarado));
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Edit(VerTipoValorDeclaradoModelView TVD)
        {
            if (TVD != null)
                //ViewBag.IdEstado = new SelectList(EstadoLogic.ListaEstados(), "IdEstado", "Detalle", TVD.IdEstado);

            if (!ModelState.IsValid) return PartialView(TVD);

            return PartialView("../Common/Mensaje", TVDLogic.EditarTipoValorDeclarado(TVD));
        }

        [HttpPost]
        public ActionResult GetCountExistsTipoValorDeclaradoInValorDeclarado(short IdTipoValorDeclarado)
        {
            JsonResult jsonResult = null;
            try
            {
                jsonResult = Json(TVDLogic.GetCountExistsTipoValorDeclaradoInValorDeclarado(IdTipoValorDeclarado), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }      
            return jsonResult;
        }

        
    }
}