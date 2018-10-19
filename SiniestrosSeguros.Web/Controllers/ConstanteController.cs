using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SiniestrosSeguros.DTO.ModelViews;
using SiniestrosSeguros.BL.BLogic;
using SiniestrosSeguros.BL;
using static SiniestrosSeguros.DTO.ModelViews.Constantes;
using SiniestrosSeguros.DTO.ModelCustoms;

namespace SiniestrosSeguros.Web.Controllers
{
    public class ConstanteController : Controller
    {
        BL.BLogic.Constante ConstLogic = new BL.BLogic.Constante();
        BL.Estado EstadoLogic = new BL.Estado();

        // GET: Constante
        public ActionResult ConsultarConstantes()
        {
            return View();
        }

        public ActionResult ListPadre()
        {
            JsonResult jsonResult = null;
            try
            {
                jsonResult = Json(ConstLogic.VerConstantes(), JsonRequestBehavior.AllowGet);
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

        public ActionResult DetalleConsultarConstantes(short IdConstante)
        {
            ViewBag.IdConstante = IdConstante.ToString();
            return PartialView();
        }

        public ActionResult ListHijo(short IdConstante, string Constante)
        {
            JsonResult jsonResult = null;

            try
            {
                jsonResult = Json(ConstLogic.VerConstantesHijos(IdConstante, ""), JsonRequestBehavior.AllowGet);
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

        public ActionResult GuardarConstantes(string IdConstante, string TipoOperacion)
        {
            VerConstanteModelView model = null;
            try
            {
                if (IdConstante != null)
                {
                    if (TipoOperacion == "Guardar")
                    {
                        model = ConstLogic.VerConstantes_Guardar(Convert.ToInt16(IdConstante)).FirstOrDefault();
                    }
                    else if (TipoOperacion == "Editar")
                    {
                        model = ConstLogic.VerConstantes(Convert.ToInt16(IdConstante)).FirstOrDefault();
                    }
                }
                ViewBag.TipoOperacion = TipoOperacion;
                return PartialView(model);
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
        public ActionResult GuardarConstantes(string TipoOperacion, VerConstanteModelView Const)
        {
            if (!ModelState.IsValid)
            {
                return PartialView(Const);
            }

            if (TipoOperacion == "Guardar")
            {
                return PartialView("../Common/Mensaje", ConstLogic.CrearConstante(Const));
            }
            else if (TipoOperacion == "Editar")
            {
                return PartialView("../Common/Mensaje", ConstLogic.EditarConstante(Const));
            }
            else
            {
                ModelState.AddModelError("", "Ocurrió un error desconocido");
                return PartialView();
            }
        }
    }
}