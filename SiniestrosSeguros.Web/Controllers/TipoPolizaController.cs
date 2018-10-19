using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SiniestrosSeguros.BL.BLogic;
using SiniestrosSeguros.DTO.ModelCustoms;

namespace SiniestrosSeguros.Web.Controllers
{
    public class TipoPolizaController : Controller
    {
        BL.BLogic.Constante constanteBL = new BL.BLogic.Constante();
        BL.BLogic.TipoPoliza tipoPolizaBL = new BL.BLogic.TipoPoliza();

        public ActionResult Index()
        {
            try
            {
                string filtroPoliza = "TIPOLIZA";
                List<DTO.ModelCustoms.Constante.ConstanteComboView> listaDetalle = constanteBL.ListarDetalleConstante(filtroPoliza);
                ViewBag.ListaRamoPoliza = new SelectList(listaDetalle, "IdConstante", "Constante");
                return View();
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;

                DTO.ModelCustoms.Constante.ConstanteComboView const1 = new DTO.ModelCustoms.Constante.ConstanteComboView();

                if (mensaje.esError)
                    const1.IdConstante = 1;
                else
                    const1.IdConstante = 0;

                const1.Constante = ex.Message;

                List<DTO.ModelCustoms.Constante.ConstanteComboView> listaDetalle = new List<DTO.ModelCustoms.Constante.ConstanteComboView>();
                listaDetalle.Add(const1);

                ViewBag.ListaRamoPoliza = new SelectList(listaDetalle, "IdConstante", "Constante");

                return View();
            }
        }

        public ActionResult List(short IdTipoPoliza)
        {
            JsonResult jsonResult = null;

            try
            {
                jsonResult = Json(tipoPolizaBL.ListarTiposPolizaPorRamoPoliza(IdTipoPoliza), JsonRequestBehavior.AllowGet);
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

        public ActionResult Create(DTO.ModelCustoms.TipoPoliza.TipoPolizaParamsModalView paramsModalView)
        {
            DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView tipoPolizaModelView = new DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView
            {
                IdEstado = true,
                IdTipoPoliza = paramsModalView.IdTipoPoliza,
                paramsModalView = paramsModalView
            };

            return PartialView("Create", tipoPolizaModelView);
        }

        [HttpPost]
        public ActionResult Create(DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView modalTipoPolizaModelView)
        {
            if (!ModelState.IsValid)
                return PartialView(modalTipoPolizaModelView);

            return PartialView("../Common/Mensaje", tipoPolizaBL.CrearTiposPolizaPorRamoPoliza(modalTipoPolizaModelView));  
        }

        public ActionResult Edit(DTO.ModelCustoms.TipoPoliza.TipoPolizaParamsModalView paramsModalView)
        {
            DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView tipoPolizaModelView = tipoPolizaBL.ObtenerTipoPoliza(paramsModalView);
            tipoPolizaModelView.paramsModalView = paramsModalView;
            return PartialView("Edit", tipoPolizaModelView);
        }


        [HttpPost]
        public ActionResult Edit(DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView modalTipoPolizaModelView)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                if (!ModelState.IsValid)
                    return PartialView(modalTipoPolizaModelView);

                return PartialView("../Common/Mensaje", tipoPolizaBL.ActualizarTipoPoliza(modalTipoPolizaModelView));
            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;                  
                return PartialView("../Common/Mensaje", mensaje);
            }
          
        }

    }
}