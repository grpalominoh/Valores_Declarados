using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using SiniestrosSeguros.BL;
using static SiniestrosSeguros.DTO.ModelViews.ValorDeclarado;
using static SiniestrosSeguros.DTO.ModelViews.AjusteValorDeclarado;
using static SiniestrosSeguros.DTO.ModelCustoms.TipoPoliza;
using static SiniestrosSeguros.DTO.ModelViews.TipoPoliza;
using System.Security.Claims;
using static SiniestrosSeguros.DTO.ModelCustoms.Disgrega;
using static SiniestrosSeguros.DTO.ModelViews.ValorDeclarado.DisgregarValorDeclaradoModelView;
using SiniestrosSeguros.BL.BLogic;
using SiniestrosSeguros.DTO.ModelCustoms;
using System.Configuration;
using System.Data;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Text.RegularExpressions;
using static SiniestrosSeguros.DTO.ModelViews.ValorDeclarado.ValorDeclaradoModalModelView;
using System.Transactions;
using System.Threading;
using SiniestrosSeguros.Web.ViewModel;
using Newtonsoft.Json;

namespace SiniestrosSeguros.Web.Controllers
{
    public class ValorDeclaradoController : Controller
    {
        ValorDeclarado VDLogic = new ValorDeclarado();
        BL.TipoValorDeclarado TVDLogic = new BL.TipoValorDeclarado();
        BL.Estado EstadoLogic = new BL.Estado();
        BL.Empresa EmpresaLogic = new BL.Empresa();
        BL.Moneda MonedaLogic = new BL.Moneda();
        BL.UnidadMedida UMLogic = new BL.UnidadMedida();
        AjusteValorDeclarado ajusteValorDeclarado = new AjusteValorDeclarado();
        BL.BLogic.Constante constanteBL = new BL.BLogic.Constante();
        BL.BLogic.TipoPoliza tipoPolizaBL = new BL.BLogic.TipoPoliza();
        DisgregaValorDeclarado disgregaBL = new DisgregaValorDeclarado();

        // GET: GestorValorDeclarado
        public ActionResult Index()
        {
            try
            {
                ViewBag.FechaVigenciaIni = DateTime.Now.AddMonths(-1).ToShortDateString();
                ViewBag.FechaVigenciaFin = DateTime.Now.ToShortDateString();

                ViewBag.IdEstado = new SelectList(EstadoLogic.ListaEstados(), "IdEstado", "Detalle");
                ViewBag.IdEmpresa = new SelectList(EmpresaLogic.ListaEmpresas(), "IdEmpresa", "NombreCorto");
                return View();
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;

                DTO.ModelCustoms.Estado.Estados estado1 = new DTO.ModelCustoms.Estado.Estados();
                DTO.ModelCustoms.Empresa.Empresas empresas1 = new DTO.ModelCustoms.Empresa.Empresas();
                estado1.IdEstado = 1;
                estado1.Detalle = ex.Message;
                empresas1.IdEmpresa = 1;
                empresas1.NombreCorto = ex.Message;

                List<DTO.ModelCustoms.Estado.Estados> lstEstados = new List<DTO.ModelCustoms.Estado.Estados>();
                lstEstados.Add(estado1);

                List<DTO.ModelCustoms.Empresa.Empresas> lstEmpresas = new List<DTO.ModelCustoms.Empresa.Empresas>();
                lstEmpresas.Add(empresas1);

                ViewBag.IdEstado = new SelectList(lstEstados, "IdEstado", "Detalle");
                ViewBag.IdEmpresa = new SelectList(lstEmpresas, "IdEmpresa", "NombreCorto");

                return View();

            }
        }

        [HttpPost]
        public ActionResult Index(BusquedaValorDeclaradoModelView ValorDeclarado)
        {
            JsonResult jsonResult = null;

            try
            {
                var roles = ((ClaimsIdentity)User.Identity).Claims.Where(c => c.Type == ClaimTypes.Role).Select(c => c.Value);

                List<BusquedaValorDeclaradoModelView> listaValorDeclarado = VDLogic.ListarValoresDeclarados(ValorDeclarado);

                foreach (BusquedaValorDeclaradoModelView item in listaValorDeclarado)
                {
                    //item.RolUsuario = roles[0];
                }

                jsonResult = Json(listaValorDeclarado, JsonRequestBehavior.AllowGet);

                //if(jsonResult != null)
                //{
                //  jsonResult.MaxJsonLength = int.MaxValue;
                //}

            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

            return jsonResult;
            //return View();
        }
        [HttpGet]
        public ActionResult List(DataTableRequest model)
        {
            short IdEmpresa = model.IdEmpresa;
            string FechaVigenciaIni = model.FechaVigenciaIni;
            string FechaVigenciaFin = model.FechaVigenciaFin;
            short IdEstado = model.IdEstado;

            DataTableAdapter<BusquedaValorDeclaradoModelView> result = new DataTableAdapter<BusquedaValorDeclaradoModelView>();

            BusquedaValorDeclaradoModelView valorDeclarado = new BusquedaValorDeclaradoModelView();

            short? n2 = null;
            valorDeclarado.IdEmpresa = IdEmpresa == 0 ? n2 : IdEmpresa;

            if (!FechaVigenciaIni.Equals(""))
                valorDeclarado.FechaVigenciaIni = DateTime.Parse(FechaVigenciaIni);
            else
                valorDeclarado.FechaVigenciaIni = null;

            if (!FechaVigenciaFin.Equals(""))
                valorDeclarado.FechaVigenciaFin = DateTime.Parse(FechaVigenciaFin);
            else
                valorDeclarado.FechaVigenciaFin = null;

            short? n1 = null;
            valorDeclarado.IdEstado = IdEstado == 0 ? n1 : IdEstado;

            //JsonResult jsonResult = null;

            try
            {
                valorDeclarado.iTamaño = Convert.ToInt32(ConfigurationManager.AppSettings["tamañoFilas"].ToString());
                valorDeclarado.iPagina = Convert.ToInt32((model.start / valorDeclarado.iTamaño)) + 1;

                List<BusquedaValorDeclaradoModelView> valoresDeclaradosTableServer = VDLogic.ListarValoresDeclarados(valorDeclarado);
                int iTotalRegistros = valoresDeclaradosTableServer.Count == 0 ? 0 : (int)valoresDeclaradosTableServer[0].totalFiltrados;
                result.Data = valoresDeclaradosTableServer;
                result.Draw = model.draw;
                result.RecordsTotal = valorDeclarado.iTamaño;
                result.RecordsFiltered = iTotalRegistros;
                //jsonResult = Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

            return Content(JsonConvert.SerializeObject(result), "application/json");
            //return View();
        }

        //[HttpGet]
        //public ActionResult List(short IdEmpresa, string FechaVigenciaIni, string FechaVigenciaFin, short IdEstado)
        //{

        //    BusquedaValorDeclaradoModelView valorDeclarado = new BusquedaValorDeclaradoModelView();

        //    short? n2 = null;
        //    valorDeclarado.IdEmpresa = IdEmpresa == 0 ? n2 : IdEmpresa;

        //    if (!FechaVigenciaIni.Equals(""))
        //        valorDeclarado.FechaVigenciaIni = DateTime.Parse(FechaVigenciaIni);
        //    else
        //        valorDeclarado.FechaVigenciaIni = null;

        //    if (!FechaVigenciaFin.Equals(""))
        //        valorDeclarado.FechaVigenciaFin = DateTime.Parse(FechaVigenciaFin);
        //    else
        //        valorDeclarado.FechaVigenciaFin = null;


        //    short? n1 = null;
        //    valorDeclarado.IdEstado = IdEstado == 0 ? n1 : IdEstado;

        //    JsonResult jsonResult = null;

        //    try
        //    {
        //        jsonResult = Json(VDLogic.ListarValoresDeclarados(valorDeclarado), JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        Mensaje mensaje = new Mensaje();
        //        mensaje.esError = true;
        //        mensaje.mensaje = ex.Message;
        //        return PartialView("../Common/Mensaje", mensaje);
        //    }

        //    return jsonResult;
        //    //return View();
        //}

        public ActionResult Create()
        {
            try
            {
                ViewBag.IdEmpresa = new SelectList(EmpresaLogic.ListaEmpresas(), "IdEmpresa", "NombreCorto");
                ViewBag.IdMoneda = new SelectList(MonedaLogic.ListaMonedas(), "IdMoneda", "Moneda");
                ViewBag.IdTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclarados(), "IdTipoValorDeclarado", "Nombre", "AfectaCantidad");
                ViewBag.IdUnidadMedida = new SelectList(UMLogic.ListaUnidadMedidas(), "IdUnidadMedida", "Nombre");
                ViewBag.MaxSizeArchivo = ConfigurationManager.AppSettings["MaxSizeArchivo"];
                Session["ListRegistroVDDC"] = new Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>();
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }
        }

        //Excel-Perfomance
        [HttpPost]
        public ActionResult Create(ValorDeclaradoModalModelView VDD)
        {
            try
            {

                if (!ModelState.IsValid)
                {
                    ViewBag.IdEmpresa = new SelectList(EmpresaLogic.ListaEmpresas(), "IdEmpresa", "NombreCorto");
                    ViewBag.IdMoneda = new SelectList(MonedaLogic.ListaMonedas(), "IdMoneda", "Moneda");
                    ViewBag.IdTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclarados(), "IdTipoValorDeclarado", "Nombre");
                    ViewBag.IdUnidadMedida = new SelectList(UMLogic.ListaUnidadMedidas(), "IdUnidadMedida", "Nombre");
                    return PartialView(VDD);
                }
                short TipoRegistro = Convert.ToInt16(ConfigurationManager.AppSettings["TipoRegistro"]);
                VDD.IdTipoRegistro = TipoRegistro; //tiene que obtenerse del web.config
                VDD.IdProceso = Convert.ToInt16(ConfigurationManager.AppSettings["IdProceso"]);
                return PartialView("../Common/Mensaje", VDLogic.CrearValorDeclarado(VDD));
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }
        }

        public ActionResult Edit(short IdValorDeclarado)
        {

            ValorDeclaradoModalModelView Model = null;

            try
            {
                ViewBag.MaxSizeArchivo = ConfigurationManager.AppSettings["MaxSizeArchivo"];
                short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);

                Model = VDLogic.EditarValorDeclarado(IdValorDeclarado);
                JsonResult ModelDetalle = Json(VDLogic.ListarValoresDeclaradosDetalle(IdValorDeclarado, Activo), JsonRequestBehavior.AllowGet);

                JsonResult ModelArchivo = Json(VDLogic.ListarArchivoValoresDeclarados(IdValorDeclarado, Activo), JsonRequestBehavior.AllowGet);

                var jsonSerialiser = new JavaScriptSerializer();
                Model.ValorDeclaradoCabecera.ValorDeclaradoDetalle = jsonSerialiser.Serialize(ModelDetalle.Data);
                Model.ValorDeclaradoCabecera.ListaArchivo = jsonSerialiser.Serialize(ModelArchivo.Data);

                if (Model != null)
                {
                    ViewBag.IdEmpresa = new SelectList(EmpresaLogic.ListaEmpresas(), "IdEmpresa", "NombreCorto", Model.IdEmpresa);
                    ViewBag.IdMoneda = new SelectList(MonedaLogic.ListaMonedas(), "IdMoneda", "Moneda", Model.IdMoneda);
                    ViewBag.IdTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclarados(), "IdTipoValorDeclarado", "Nombre");
                    ViewBag.IdUnidadMedida = new SelectList(UMLogic.ListaUnidadMedidas(), "IdUnidadMedida", "Nombre");
                }
                Session["ListRegistroVDDC"] = new Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>();
                return PartialView(Model);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }
        }

        [HttpPost]
        public ActionResult Edit(ValorDeclaradoModalModelView VD)
        {
            try
            {
                if (VD != null)
                {
                    ViewBag.IdEmpresa = new SelectList(EmpresaLogic.ListaEmpresas(), "IdEmpresa", "NombreCorto", VD.IdEmpresa);
                    ViewBag.IdMoneda = new SelectList(MonedaLogic.ListaMonedas(), "IdMoneda", "Moneda", VD.IdMoneda);
                    ViewBag.IdTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclarados(), "IdTipoValorDeclarado", "Nombre");
                    ViewBag.IdUnidadMedida = new SelectList(UMLogic.ListaUnidadMedidas(), "IdUnidadMedida", "Nombre");
                }

                if (!ModelState.IsValid) return PartialView(VD);

                short TipoRegistro = Convert.ToInt16(ConfigurationManager.AppSettings["TipoRegistro"]);
                VD.IdTipoRegistro = TipoRegistro; //tiene que obtenerse del web.config
                VD.IdProceso = Convert.ToInt16(ConfigurationManager.AppSettings["IdProceso"]);

                return PartialView("../Common/Mensaje", VDLogic.ActualizarValorDeclarado(VD));

            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }
        }

        public ActionResult Ajuste(int IdValorDeclarado, int edit)
        {
            ViewBag.edit = edit;
            ViewBag.IdValorDeclarado = IdValorDeclarado;
            return PartialView();
        }
        //
        public ActionResult AjusteValorDeclaradoDetalleList(int IdValorDeclarado)
        {
            JsonResult jsonResult = null;
            try
            {
                jsonResult = Json(ajusteValorDeclarado.ListarTiposValorDeclaradoPorValorDeclarado(IdValorDeclarado), JsonRequestBehavior.AllowGet);
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

        public ActionResult AjusteTipoPolizaList(int IdValorDeclaradoDetalle)
        {
            JsonResult jsonResult = null;
            try
            {
                jsonResult = Json(ajusteValorDeclarado.ListarTiposPolizaPorValorDeclaradoDetalle(IdValorDeclaradoDetalle), JsonRequestBehavior.AllowGet);
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

        public ActionResult AjusteValor(AjusteValorDeclaradoModalModelView ajusteValorDeclaradoModalModelView)
        {
            return PartialView(ajusteValorDeclaradoModalModelView);
        }

        [HttpPost]
        public ActionResult ImporteAjustado(int? idValorDeclaradoDetalleDisgregado, decimal? cantidadAjustada, decimal? importeAjustado)
        {
            return Json(new ValorDeclarado().importeAjustadoViewModel(idValorDeclaradoDetalleDisgregado, cantidadAjustada, importeAjustado), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]

        public ActionResult EditaAjuste(AjusteValorDeclaradoModalModelView ajusteValorDeclaradoModalModelView)
        {
            if (!ModelState.IsValid)
                return PartialView(ajusteValorDeclaradoModalModelView);

            return PartialView("../Common/Mensaje", ajusteValorDeclarado.ActualizarAjusteValorDeclarado(ajusteValorDeclaradoModalModelView));
        }


        [HttpPost]
        public ActionResult ActualizarEstado(int IdValorDeclarado)
        {
            return PartialView("../Common/Mensaje", VDLogic.ActualizarEstadoValorDeclarado(IdValorDeclarado, "AJUST"));
        }

        [HttpPost]
        public ActionResult Anular(int IdValorDeclarado)
        {
            return PartialView("../Common/Mensaje", VDLogic.ActualizarEstadoValorDeclarado(IdValorDeclarado, "ANUL"));
        }

        //problem
        [HttpPost]
        public ActionResult Autorizar(int IdValorDeclarado)
        {
            short IdAutorizacionEnProceso = Convert.ToInt16(ConfigurationManager.AppSettings["IdAutorizacionEnProceso"]);
            short IdProceso = Convert.ToInt16(ConfigurationManager.AppSettings["IdProceso"]);
            string Dominio = Convert.ToString(ConfigurationManager.AppSettings["Dominio"]);
            Mensaje mensaje = null;
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    VDLogic.NotificarAutorizacion(IdValorDeclarado, IdProceso, Dominio);
                    scope.Complete();
                    using (TransactionScope scope2 = new TransactionScope(TransactionScopeOption.RequiresNew))
                    {
                        mensaje = VDLogic.ActualizarEstadoValorDeclarado(IdValorDeclarado, IdAutorizacionEnProceso);
                        scope2.Complete();
                    }
                }


            }
            catch (Exception)
            {
                mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = "Ocurrió un error en el envió de la notificación de autorización";
            }
            return PartialView("../Common/Mensaje", mensaje);
        }

        [HttpPost]
        public ActionResult AdjuntarArchivo(HttpPostedFileBase file, string ArchivoList)
        {

            JsonResult jsonResult = null;

            try
            {

                List<ValorDeclaradoModalModelView.ArchivoModelView> listaValorDeclarado = new List<ValorDeclaradoModalModelView.ArchivoModelView>();
                ValorDeclaradoModalModelView.ArchivoModelView archivo = null;
                string path = String.Empty;
                Guid cName;
                if (file != null && file.ContentLength > 0)
                {
                    string Formato = Path.GetExtension(file.FileName);
                    short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
                    string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);

                    cName = Guid.NewGuid();
                    path = Path.Combine(UrlArchivo, Convert.ToString(cName + Formato));
                    //path = Path.Combine(Server.MapPath(UrlArchivo), Convert.ToString(cName + Formato));

                    file.SaveAs(path);

                    archivo = new ValorDeclaradoModalModelView.ArchivoModelView();
                    archivo.IdArchivo = 0;
                    archivo.NombreArchivo = file.FileName;
                    archivo.RutaArchivo = UrlArchivo;
                    archivo.IdEstado = Activo;
                    archivo.NombreAsignado = cName.ToString();
                    archivo.Formato = Formato;
                    listaValorDeclarado.Add(archivo);
                }

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                dynamic jsonObject = serializer.Deserialize<dynamic>(ArchivoList);

                short? n1 = 0;
                foreach (var registroList in jsonObject)
                {
                    int IdValorDeclarado = registroList["IdValorDeclarado"];
                    short IdArchivo = (registroList["IdArchivo"] != null) ? Convert.ToInt16(registroList["IdArchivo"]) : n1;
                    string NombreArchivo = (registroList["NombreArchivo"] != null && registroList["NombreArchivo"] != "") ? Convert.ToString(registroList["NombreArchivo"]) : "";
                    string NombreAsignado = (registroList["NombreAsignado"] != null && registroList["NombreAsignado"] != "") ? Convert.ToString(registroList["NombreAsignado"]) : "";
                    string Formato = (registroList["Formato"] != null && registroList["Formato"] != "") ? Convert.ToString(registroList["Formato"]) : "";
                    string RutaArchivo = (registroList["RutaArchivo"] != null && registroList["RutaArchivo"] != "") ? Convert.ToString(registroList["RutaArchivo"]) : "";
                    short IdEstado = (registroList["IdEstado"] != null) ? Convert.ToInt16(registroList["IdEstado"]) : n1;

                    archivo = new ValorDeclaradoModalModelView.ArchivoModelView();
                    archivo.IdValorDeclarado = IdValorDeclarado;
                    archivo.IdArchivo = IdArchivo;
                    archivo.NombreArchivo = NombreArchivo;
                    archivo.NombreAsignado = NombreAsignado;
                    archivo.Formato = Formato;
                    archivo.RutaArchivo = RutaArchivo;
                    archivo.IdEstado = IdEstado;
                    listaValorDeclarado.Add(archivo);
                }

                jsonResult = Json(listaValorDeclarado, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = "No se puede encontrar una parte de la ruta de acceso del servidor.";
                return Json(mensaje, JsonRequestBehavior.AllowGet);
            }

            return jsonResult;
        }

        public ActionResult ValidarDescarga(string NombreArchivo, string NombreAsignado, string Formato)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);
                string fileName = NombreAsignado + Formato;
                //string path = Path.Combine(Server.MapPath(UrlArchivo), fileName);
                string path = Path.Combine(UrlArchivo, fileName);
                if (System.IO.File.Exists(path))
                {
                    mensaje.esError = false;
                }
                else
                {
                    mensaje.esError = true;
                    mensaje.mensaje = "El archivo seleccionado no ha sido encontrado en la carpeta de alojamiento.";
                }

            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return Json(mensaje, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult DescargarArchivo(string NombreArchivo, string NombreAsignado, string Formato)
        {
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);
            string fileName = NombreAsignado + Formato;
            //string path = Path.Combine(Server.MapPath(UrlArchivo), fileName);
            string path = Path.Combine(UrlArchivo, fileName);
            byte[] fileBytes = System.IO.File.ReadAllBytes(path);
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

        [HttpGet]
        public ActionResult DescargarArchivoError(string NombreArchivo, string NombreAsignado, string Formato)
        {
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);
            string fileName = NombreAsignado + Formato;
            //string path = Path.Combine(Server.MapPath(UrlArchivo), fileName);
            string path = Path.Combine(UrlArchivo, fileName);
            //System.IO.File.Delete(path);            
            byte[] fileBytes = System.IO.File.ReadAllBytes(path);
            System.IO.File.Delete(path);
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

        public JsonResult validaDescarga(int? nCodFor, int? nCodUsu)
        {

            bool valida = false;

            try
            {

                string path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "RUTA DEL ARCHIVO");
                if (System.IO.File.Exists(path))
                {
                    valida = true;
                }
                else
                {
                    valida = false;
                }

            }
            catch (Exception)
            {
                valida = false;

            }

            return Json(valida, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public ActionResult LeerExcel(HttpPostedFileBase File, short IdTipoValorDeclarado)
        {
            #region Leer Excel => DataTable 

            decimal cantidadImporte = 0;

            List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView> ListVDCTrabajadores
                                            = new List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>();
            List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView> ListVDCPracticantes
                                            = new List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>();


            ValorDeclaradoModalModelView.InfoArchivos InfoArchivos
                                            = new ValorDeclaradoModalModelView.InfoArchivos();

            int count = 0;
            IEnumerable<Row> rows = null;
            InfoArchivos infoArchivos = new InfoArchivos();
            try
            {
                string path = "";
                Guid cName;

                if (File != null && File.ContentLength > 0)
                {
                    string Formato = Path.GetExtension(File.FileName);
                    short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
                    string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);

                    cName = Guid.NewGuid();
                    path = Path.Combine(UrlArchivo, Convert.ToString(cName + Formato));
                    //path = Path.Combine(Server.MapPath(UrlArchivo), Convert.ToString(cName + Formato));

                    File.SaveAs(path);


                    using (SpreadsheetDocument spreadSheetDocument = SpreadsheetDocument.Open(path, false))
                    {
                        WorkbookPart workbookPart = spreadSheetDocument.WorkbookPart;
                        IEnumerable<Sheet> sheets = spreadSheetDocument.WorkbookPart.Workbook.GetFirstChild<DocumentFormat.OpenXml.Spreadsheet.Sheets>().Elements<Sheet>();
                        string relationshipId = sheets.First().Id.Value;
                        WorksheetPart worksheetPart = (WorksheetPart)spreadSheetDocument.WorkbookPart.GetPartById(relationshipId);
                        DocumentFormat.OpenXml.Spreadsheet.Worksheet workSheet = worksheetPart.Worksheet;
                        SheetData sheetData = workSheet.GetFirstChild<SheetData>();
                        rows = sheetData.Descendants<Row>();

                        count = rows.Count();
                        if (count > 0)
                        {
                            Row RowTmp = rows.ElementAt(0);
                            int countCeldas = RowTmp.Count(); // obtenemos el numero de celdas para luego validar el tipo de archivo



                            List<int> ListRegistrosCorrectos = new List<int>();
                            short IdTipoValorDeclaradoVehiculos = Convert.ToInt16(ConfigurationManager.AppSettings["IdTipoValorDeclaradoVehiculos"]);

                            short IdTipoValorDeclaradoTrabajadores = Convert.ToInt16(ConfigurationManager.AppSettings["IdTipoValorDeclaradoTrabajadores"]);
                            short IdTipoValorDeclaradoPracticantes = Convert.ToInt16(ConfigurationManager.AppSettings["IdTipoValorDeclaradoPracticantes"]);




                            if (IdTipoValorDeclarado == IdTipoValorDeclaradoVehiculos)
                            {

                                short NroColumnasVehiculo = Convert.ToInt16(ConfigurationManager.AppSettings["NroColumnasVehiculo"]);
                                if (countCeldas == NroColumnasVehiculo)
                                {
                                    //ARCHIVOS RETORNA CORRECTAMENTE
                                    infoArchivos = ValidaListVehiculoComplemento(rows, spreadSheetDocument, File.FileName, cName + Formato, IdTipoValorDeclarado, ref cantidadImporte);

                                }
                                else
                                {
                                    InfoArchivos.ArchivoIncorrecto = true;
                                    InfoArchivos.Mensaje = "Número de Columnas no es correcto conforme el Tipo de Valor Declararo seleccionado. Archivo no se procesará.";
                                }

                            }
                            else if (IdTipoValorDeclarado == IdTipoValorDeclaradoTrabajadores)
                            {
                                //obtenemos numero de columnas definido para Archivo trabajadores
                                short NroColumnasTrabajadores = Convert.ToInt16(ConfigurationManager.AppSettings["NroColumnasTrabajadores"]);
                                if (countCeldas == NroColumnasTrabajadores)
                                {
                                    infoArchivos = ValidaListTrabajadoresComplemento(rows, spreadSheetDocument, File.FileName, cName + Formato, IdTipoValorDeclarado, ref cantidadImporte);
                                }
                                else
                                {
                                    InfoArchivos.ArchivoIncorrecto = true;
                                    InfoArchivos.Mensaje = "Número de Columnas no es correcto conforme el Tipo de Valor Declararo seleccionado. Archivo no se procesará.";
                                }

                            }
                            else if (IdTipoValorDeclarado == IdTipoValorDeclaradoPracticantes)
                            {
                                //obtenemos numero de columnas definido para Archivo practicantes
                                short NroColumnasPracticantes = Convert.ToInt16(ConfigurationManager.AppSettings["NroColumnasPracticantes"]);
                                if (countCeldas == NroColumnasPracticantes)
                                {
                                    infoArchivos = ValidaListPracticantesComplemento(rows, spreadSheetDocument, File.FileName, cName + Formato, IdTipoValorDeclarado, ref cantidadImporte);
                                }
                                else
                                {
                                    InfoArchivos.ArchivoIncorrecto = true;
                                    InfoArchivos.Mensaje = "Número de Columnas no es correcto conforme el Tipo de Valor Declararo seleccionado. Archivo no se procesará.";
                                }
                            }
                            else
                            {
                                InfoArchivos.ArchivoIncorrecto = true;
                                InfoArchivos.Mensaje = "Archivo no se puede procesar porque no tiene reglas de negocio.";
                            }
                        }
                        else
                        {
                            InfoArchivos.ArchivoIncorrecto = true;
                            InfoArchivos.Mensaje = "Archivo está vacío";
                        }
                    }
                }
                else
                {
                    InfoArchivos.ArchivoIncorrecto = true;
                    InfoArchivos.Mensaje = "Archivo está vacío";
                }

                if (cantidadImporte == 0)
                {
                    InfoArchivos.ArchivoIncorrecto = true;
                    InfoArchivos.Mensaje += ". Verifique el formato. No se cargó ningun valor para el importe.";
                }
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = "No se puede encontrar una parte de la ruta de acceso del servidor.";
                return Json(mensaje, JsonRequestBehavior.AllowGet);
            }

            #endregion

            var jsonSerialiser = new JavaScriptSerializer();
            InfoArchivos.NroRegistrosTotal = count - 1;
            InfoArchivos.NroRegistrosOk = count - infoArchivos.NroRegistrosError;
            InfoArchivos.NroRegistrosError = infoArchivos.NroRegistrosError;
            InfoArchivos.ListRegistroVDDC = infoArchivos.ListRegistroVDDC;
            InfoArchivos.ListRegistrosError = infoArchivos.ListRegistrosError;
            InfoArchivos.RegistroVDDC = jsonSerialiser.Serialize(infoArchivos.ListRegistroVDDC);
            InfoArchivos.RegistrosError = jsonSerialiser.Serialize(infoArchivos.ListRegistrosError);
            InfoArchivos.Total = cantidadImporte;
            return Json(InfoArchivos, JsonRequestBehavior.AllowGet);
        }

        public InfoArchivos ValidaListVehiculoComplemento(IEnumerable<Row> rows, SpreadsheetDocument spreadSheetDocument, string nombreArchivo, string nombreAsignado, int IdTipoValorDeclarado, ref decimal cantidadImporte)
        {
            ValorDeclaradoModalModelView.InfoArchivos InfoArchivos = new ValorDeclaradoModalModelView.InfoArchivos();

            ValorDeclaradoModalModelView.GestionRegistrosArchivo RegistrosError = null;
            List<ValorDeclaradoModalModelView.GestionRegistrosArchivo> ListGestionArchivo
                                            = new List<ValorDeclaradoModalModelView.GestionRegistrosArchivo>();
            List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView> ListVDCVehiculo
                                            = new List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>();
            decimal montoValorDeclarado = 0;
            int count = 0;
            int countError = 0;
            //obtenemos numero de columnas definido para Archivo vehiculos

            short IdTipoBien = Convert.ToInt16(ConfigurationManager.AppSettings["IdTipoBien"]);
            short IdPadreTipoVehiculo = Convert.ToInt16(ConfigurationManager.AppSettings["IdPadreTipoVehiculo"]);
            short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);

            BL.BLogic.Vehiculo VHLogic = new BL.BLogic.Vehiculo();
            BL.BLogic.UnidadNegocio UNLogic = new BL.BLogic.UnidadNegocio();
            BL.BLogic.CentroCosto CentroCostoLogic = new BL.BLogic.CentroCosto();
            BL.BLogic.Marca MarcaLogic = new BL.BLogic.Marca();
            BL.BLogic.Modelo ModeloLogic = new BL.BLogic.Modelo();
            BL.BLogic.Constante ConstanteLogic = new BL.BLogic.Constante();
            BL.Moneda MonedaLogic = new BL.Moneda();
            Dictionary<int, short> UNLIst = new Dictionary<int, short>();
            Dictionary<string, int> CentroCostoList = new Dictionary<string, int>();
            Dictionary<short, string> MarcaList = new Dictionary<short, string>();
            Dictionary<int, string> ModeloList = new Dictionary<int, string>();
            Dictionary<short, string> ConstanteList = new Dictionary<short, string>();
            Dictionary<int, string> MonedaList = new Dictionary<int, string>();

            UNLIst = UNLogic.ObtenerUnidadNegocio(Activo);
            CentroCostoList = CentroCostoLogic.ObtenerCentroCosto(Activo);
            MarcaList = MarcaLogic.ObtenerMarca(Activo);
            ModeloList = ModeloLogic.ObtenerModelo(Activo);
            ConstanteList = ConstanteLogic.ObtenerConstantesPorIdPadre(IdPadreTipoVehiculo, Activo); //tipoVehiculo
            MonedaList = MonedaLogic.ObtenerMoneda(Activo);

            foreach (Row row in rows.Where((item, index) => index > 0))
            {
                ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView VDC
                                                        = new ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView();

                RegistrosError = new ValorDeclaradoModalModelView.GestionRegistrosArchivo();
                count++;
                string IdUnidadNegocioTmp = "";
                string CentroCostoTmp = "";
                string NroPlacaTmp = "";
                string NroMotorTmp = "";
                string NroChasisTmp = "";
                string IdMarcaTmp = "";
                string IdModeloTmp = "";
                string AnoFabricacionTmp = "";
                string ClaseTmp = "";
                string OcupantesTmp = "";
                string TimonCambiadoTmp = "";
                string FechaInicioTmp = "";
                string FechaTerminoTmp = "";
                string IdMonedaTmp = "";
                string ValorDeclaradoTmp = "";
                try
                {
                    IdUnidadNegocioTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(0)).Trim();
                    CentroCostoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(1)).Trim();
                    NroPlacaTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(2)).Trim();
                    NroMotorTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(3)).Trim();
                    NroChasisTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(4)).Trim();
                    IdMarcaTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(5)).Trim();
                    IdModeloTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(6)).Trim();
                    AnoFabricacionTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(7)).Trim();
                    ClaseTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(8)).Trim();
                    OcupantesTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(9)).Trim();
                    TimonCambiadoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(10)).Trim();
                    FechaInicioTmp = DateTime.FromOADate(double.Parse(GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(11)).Trim())).ToShortDateString();
                    FechaTerminoTmp = DateTime.FromOADate(double.Parse(GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(12)).Trim())).ToShortDateString();
                    IdMonedaTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(13)).Trim();
                    ValorDeclaradoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(14)).Trim();
                }
                catch (Exception ex)
                {
                    RegistrosError.Campo = "Error en un campo de la fila.";
                    RegistrosError.mensaje = "Campo Vacío, null o formato de fecha Incorrecta";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = "Referencia Inválida";
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                VDC.IdTipoBien = IdTipoBien;
                VDC.IdEstado = Activo;
                VDC.Ruta = UrlArchivo;
                VDC.NombreAsignado = nombreAsignado;
                VDC.NombreOrigen = nombreArchivo;

                if (!ValidaCadenaVacia(IdUnidadNegocioTmp.Trim()))
                {
                    if (EsNumero(IdUnidadNegocioTmp))
                    {
                        if (UNLIst.ContainsKey(Convert.ToInt32(IdUnidadNegocioTmp)))
                        {
                            VDC.IdUUNN = Convert.ToInt16(IdUnidadNegocioTmp);
                        }
                        else
                        {
                            RegistrosError.Campo = "Unidad Negocio";
                            RegistrosError.mensaje = "No existe";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdUnidadNegocioTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "Unidad Negocio";
                        RegistrosError.mensaje = "No es númerico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdUnidadNegocioTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Unidad Negocio";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdUnidadNegocioTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(CentroCostoTmp.Trim()))
                {
                    int IdCentroCosto = CentroCostoList[CentroCostoTmp.Trim()];
                    if (IdCentroCosto > 0)
                    {
                        VDC.IdCentroCosto = Convert.ToInt16(IdCentroCosto);
                    }
                    else
                    {
                        RegistrosError.Campo = "Centro Costo";
                        RegistrosError.mensaje = "Código no existe en la tabla Centro de Costo";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = CentroCostoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Centro Costo";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = CentroCostoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }
                if (!ValidaCadenaVacia(FechaInicioTmp.Trim()))
                {
                    if (ValidaFecha(FechaInicioTmp.Trim()))
                    {
                        VDC.FechaInicio = Convert.ToDateTime(FechaInicioTmp.Trim());
                    }
                    else
                    {
                        RegistrosError.Campo = "FechaInicio";
                        RegistrosError.mensaje = "Error en formato de Fecha: ( ejemplo: 'dd/mm/yyy )";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = FechaInicioTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "FechaInicio";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = FechaInicioTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(FechaTerminoTmp.Trim()))
                {
                    if (ValidaFecha(FechaTerminoTmp.Trim()))
                    {
                        VDC.FechaFin = Convert.ToDateTime(FechaTerminoTmp.Trim());
                    }
                    else
                    {
                        RegistrosError.Campo = "FechaTerminoTmp";
                        RegistrosError.mensaje = "Error en formato de Fecha: ( ejemplo: 'dd/mm/yyy )";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = FechaTerminoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "FechaTerminoTmp";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = FechaTerminoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(NroPlacaTmp.Trim()))
                {
                    if (NroPlacaTmp.Trim().Length <= 10)
                    {
                        if (ValidaPlaca(NroPlacaTmp))
                        {
                            //Inicialmente no se inserta en la base de datos, eso se ve recien cuando se guarda el VD.
                            VDC.NroPlaca = NroPlacaTmp;

                        }
                        else
                        {
                            RegistrosError.Campo = "Nro. Placa";
                            RegistrosError.mensaje = "Placa incorrecta";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = NroPlacaTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }
                    }
                    else
                    {
                        RegistrosError.Campo = "Nro. Placa";
                        RegistrosError.mensaje = "Número de campos es mayor a 10";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = NroPlacaTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }


                }
                else
                {
                    RegistrosError.Campo = "Nro. Placa";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = NroPlacaTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(NroMotorTmp.Trim()))
                {
                    if (NroMotorTmp.Trim().Length <= 64)
                    {
                        VDC.NroMotor = NroMotorTmp;
                    }
                    else
                    {
                        RegistrosError.Campo = "Nro. Motor";
                        RegistrosError.mensaje = "Número de campos es mayor a 64";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = NroMotorTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Nro. Motor";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = NroMotorTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(NroChasisTmp.Trim()))
                {
                    if (NroChasisTmp.Trim().Length <= 64)
                    {
                        VDC.NroChasis = NroChasisTmp;
                    }
                    else
                    {
                        RegistrosError.Campo = "Nro. Chasis";
                        RegistrosError.mensaje = "Número de campos es mayor a 64";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = NroMotorTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Nro. chasis";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = NroChasisTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }


                if (!ValidaCadenaVacia(IdMarcaTmp.Trim()))
                {
                    if (EsNumero(IdMarcaTmp))
                    {
                        short IdMarca = Convert.ToInt16(IdMarcaTmp);
                        if (MarcaList.ContainsKey(IdMarca))
                        {
                            VDC.IdMarca = IdMarca;
                        }
                        else
                        {
                            RegistrosError.Campo = "Id. Marca";
                            RegistrosError.mensaje = "No existe en Tabla Marca";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdMarcaTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }
                    }
                    else
                    {
                        RegistrosError.Campo = "Id. Marca";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdMarcaTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Id. Marca";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdMarcaTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }


                if (!ValidaCadenaVacia(IdModeloTmp.Trim()))
                {
                    if (EsNumero(IdModeloTmp))
                    {
                        int IdModelo = Convert.ToInt32(IdModeloTmp);
                        if (ModeloList.ContainsKey(IdModelo))
                        {
                            VDC.IdModelo = IdModelo;
                        }
                        else
                        {
                            RegistrosError.Campo = "Id. Modelo";
                            RegistrosError.mensaje = "No existe en tabla Modelo";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdModeloTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }
                    }
                    else
                    {
                        RegistrosError.Campo = "Id. Marca";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdModeloTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Id. Modelo";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdModeloTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(AnoFabricacionTmp.Trim()))
                {
                    if (EsNumero(AnoFabricacionTmp))
                    {
                        VDC.AnoFabricacion = Convert.ToInt16(AnoFabricacionTmp);
                    }
                    else
                    {
                        RegistrosError.Campo = "Año Fabricación";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = AnoFabricacionTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Año Fabricación";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = AnoFabricacionTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }


                if (!ValidaCadenaVacia(ClaseTmp.Trim()))
                {
                    if (EsNumero(ClaseTmp))
                    {
                        short clase = Convert.ToInt16(ClaseTmp);
                        if (ConstanteList.ContainsKey(clase))
                        {
                            VDC.Clase = clase;
                        }
                        else
                        {
                            RegistrosError.Campo = "Clase";
                            RegistrosError.mensaje = "No exite en tabla Constante";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = ClaseTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }
                    }
                    else
                    {
                        RegistrosError.Campo = "Clase";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = ClaseTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Clase";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = ClaseTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(OcupantesTmp.Trim()))
                {

                    if (EsNumero(OcupantesTmp))
                    {
                        short Ocupantes = Convert.ToInt16(OcupantesTmp);
                        if (Ocupantes > 0)
                        {
                            VDC.NroAsientos = Ocupantes;
                        }
                        else
                        {
                            RegistrosError.Campo = "Ocupantes";
                            RegistrosError.mensaje = "Número de Ocupantes debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = OcupantesTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }
                    }
                    else
                    {
                        RegistrosError.Campo = "Ocupantes";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = OcupantesTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Ocupantes";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = OcupantesTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(TimonCambiadoTmp.Trim()))
                {
                    if (TimonCambiadoTmp.Trim().ToUpper().Equals("SI"))
                    {
                        VDC.TimonCambiado = 1;
                    }
                    else if (TimonCambiadoTmp.Trim().ToUpper().Equals("NO"))
                    {
                        VDC.TimonCambiado = 0;
                    }
                    else
                    {
                        RegistrosError.Campo = "Timon Cambiado";
                        RegistrosError.mensaje = "Campo debe contener sólo SI o NO";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = TimonCambiadoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Timon Cambiado";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = TimonCambiadoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(IdMonedaTmp.Trim()))
                {
                    if (EsNumero(IdMonedaTmp))
                    {
                        short IdMoneda = Convert.ToInt16(IdMonedaTmp);
                        if (MonedaList.ContainsKey(IdMoneda))
                        {
                            VDC.IdMoneda = IdMoneda;
                        }
                        else
                        {
                            RegistrosError.Campo = "Id Moneda";
                            RegistrosError.mensaje = "No existe en Tabla Moneda";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdMonedaTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }
                    }
                    else
                    {
                        RegistrosError.Campo = "Id Moneda";
                        RegistrosError.mensaje = "No es Numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdMonedaTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {
                    RegistrosError.Campo = "Id Moneda";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdMonedaTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(ValorDeclaradoTmp.Trim()))
                {
                    if (EsDecimal(ValorDeclaradoTmp))
                    {
                        VDC.ValorDeclarado = Convert.ToDecimal(ValorDeclaradoTmp);
                        cantidadImporte += (decimal)VDC.ValorDeclarado;
                    }
                    else
                    {
                        RegistrosError.Campo = "Valor Declarado";
                        RegistrosError.mensaje = " No es númerico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = ValorDeclaradoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }
                }
                else
                {

                    RegistrosError.Campo = "Valor Declarado";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = ValorDeclaradoTmp;
                    ListGestionArchivo.Add(RegistrosError);

                    countError++;
                    continue;
                }

                //agregamos cada registro a la lista
                ListVDCVehiculo.Add(VDC);

            }

            InfoArchivos.NroRegistrosTotal = count;
            InfoArchivos.NroRegistrosError = countError;
            InfoArchivos.ListRegistroVDDC = ListVDCVehiculo;
            InfoArchivos.ListRegistrosError = ListGestionArchivo;

            var archivos = (Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>)Session["ListRegistroVDDC"];
            if (archivos.ContainsKey((int)IdTipoValorDeclarado))
                archivos[IdTipoValorDeclarado] = ListVDCVehiculo;
            else
                archivos.Add(IdTipoValorDeclarado, ListVDCVehiculo);

            return InfoArchivos;
        }

        public InfoArchivos ValidaListTrabajadoresComplemento(IEnumerable<Row> rows, SpreadsheetDocument spreadSheetDocument, string nombreArchivo, string nombreAsignado, int IdTipoValorDeclarado, ref decimal cantidadImporte)
        {
            ValorDeclaradoModalModelView.InfoArchivos InfoArchivos = new ValorDeclaradoModalModelView.InfoArchivos();

            ValorDeclaradoModalModelView.GestionRegistrosArchivo RegistrosError = null;
            List<ValorDeclaradoModalModelView.GestionRegistrosArchivo> ListGestionArchivo
                                            = new List<ValorDeclaradoModalModelView.GestionRegistrosArchivo>();
            List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView> ListVDCTrabajadores
                                            = new List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>();
            int count = 0;
            int countError = 0;

            short IdPadreIdCargo = Convert.ToInt16(ConfigurationManager.AppSettings["IdPadreIdCargo"]);
            short IdPadreIdNivelRiesgo = Convert.ToInt16(ConfigurationManager.AppSettings["IdPadreIdNivelRiesgo"]);
            short IdPadreIdTipoPlanilla = Convert.ToInt16(ConfigurationManager.AppSettings["IdPadreIdTipoPlanilla"]);
            short IdTipoBien = Convert.ToInt16(ConfigurationManager.AppSettings["IdTipoBienPersona"]);

            short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);

            BL.BLogic.Constante ConstanteLogic = new BL.BLogic.Constante();
            BL.BLogic.Area AreaLogic = new BL.BLogic.Area();

            Dictionary<short, string> ConstanteCargoList = new Dictionary<short, string>();
            Dictionary<short, string> ConstanteRiesgoList = new Dictionary<short, string>();
            Dictionary<short, string> ConstanteTipoPlanillaList = new Dictionary<short, string>();
            Dictionary<int, string> MonedaList = new Dictionary<int, string>();
            Dictionary<short, string> AreaList = new Dictionary<short, string>();

            ConstanteCargoList = ConstanteLogic.ObtenerConstantesPorIdPadre(IdPadreIdCargo, Activo); //Idcargo
            ConstanteRiesgoList = ConstanteLogic.ObtenerConstantesPorIdPadre(IdPadreIdNivelRiesgo, Activo); //Idriesgo
            ConstanteTipoPlanillaList = ConstanteLogic.ObtenerConstantesPorIdPadre(IdPadreIdTipoPlanilla, Activo); //IdTipoPlanilla
            MonedaList = MonedaLogic.ObtenerMoneda(Activo);
            AreaList = AreaLogic.ObtenerAreas(Activo);


            foreach (Row row in rows.Where((item, index) => index > 0))
            {
                ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView VDC
                                                        = new ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView();

                RegistrosError = new ValorDeclaradoModalModelView.GestionRegistrosArchivo();
                count++;
                string ApellidoPaternoTmp = "";
                string ApellidoMaternoTmp = "";
                string NombreTmp = "";
                string DNITmp = "";
                string FechaNacimientoTmp = "";
                string FechaIngresoTmp = "";
                string IdCargoTmp = "";
                string IdAreaTmp = "";
                string IdNivelRiesgoTmp = "";
                string IdTipoPlanillaTmp = "";
                string RemuneracionMensualTmp = "";
                string GraficiacionesTmp = "";
                try
                {
                    ApellidoPaternoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(0));
                    ApellidoMaternoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(1));
                    NombreTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(2));
                    DNITmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(3));

                    FechaNacimientoTmp = DateTime.FromOADate(double.Parse(GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(4)))).ToShortDateString();
                    FechaIngresoTmp = DateTime.FromOADate(double.Parse(GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(5)))).ToShortDateString();
                    IdCargoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(6));
                    IdAreaTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(7));
                    IdNivelRiesgoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(8));
                    IdTipoPlanillaTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(9));
                    RemuneracionMensualTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(10));
                    GraficiacionesTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(11));
                }
                catch (Exception ex)
                {
                    RegistrosError.Campo = "Error en un campo de la fila";
                    RegistrosError.mensaje = "Campo Vacío o null";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = "Referencia Inválida";
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                VDC.IdTipoBien = IdTipoBien;
                VDC.IdEstado = Activo;
                VDC.Ruta = UrlArchivo;
                VDC.NombreAsignado = nombreAsignado;
                VDC.NombreOrigen = nombreArchivo;

                if (!ValidaCadenaVacia(ApellidoPaternoTmp.Trim()))
                {
                    if (ApellidoPaternoTmp.Trim().Length <= 32)
                    {
                        VDC.ApellidoPaterno = ApellidoPaternoTmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "Apellido Paterno";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 32 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = ApellidoPaternoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Apellido Paterno";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = ApellidoPaternoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(ApellidoMaternoTmp.Trim()))
                {
                    if (ApellidoMaternoTmp.Trim().Length <= 32)
                    {
                        VDC.ApellidoMaterno = ApellidoMaternoTmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "Apellido Paterno";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 32 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = ApellidoMaternoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Apellido Materno";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = ApellidoMaternoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(NombreTmp.Trim()))
                {
                    if (NombreTmp.Trim().Length <= 128)
                    {
                        VDC.Nombre = NombreTmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "Nombre";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 128 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = NombreTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Nombre";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = NombreTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(DNITmp.Trim()))
                {
                    if (DNITmp.Trim().Length <= 20)
                    {
                        VDC.DNI = DNITmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "DNI";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 20 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = DNITmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "DNI";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = DNITmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(FechaNacimientoTmp.Trim()))
                {
                    if (ValidaFecha(FechaNacimientoTmp.Trim()))
                    {
                        VDC.FechaNacimiento = Convert.ToDateTime(FechaNacimientoTmp.Trim());
                    }
                    else
                    {
                        RegistrosError.Campo = "FechaNacimiento";
                        RegistrosError.mensaje = "Error en formato de Fecha: ( ejemplo: 'dd/mm/yyy )";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = FechaNacimientoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "FechaNacimiento";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = FechaNacimientoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(FechaIngresoTmp.Trim()))
                {
                    if (ValidaFecha(FechaIngresoTmp.Trim()))
                    {
                        VDC.FechaIngreso = Convert.ToDateTime(FechaIngresoTmp.Trim());
                        if (DateTime.Compare(VDC.FechaIngreso, VDC.FechaNacimiento) > 0)
                        {
                            //todo ok
                        }
                        else
                        {
                            RegistrosError.Campo = "FechaIngreso";
                            RegistrosError.mensaje = "Fecha de Ingreso debe ser mayor a la fecha de Nacimiento";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = FechaIngresoTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "FechaIngreso";
                        RegistrosError.mensaje = "Error en formato de Fecha ( ejemplo: 'dd/mm/yyy )";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = FechaIngresoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "FechaIngreso";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = FechaIngresoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(IdCargoTmp.Trim()))
                {
                    if (EsNumero(IdCargoTmp))
                    {
                        short IdCargo = Convert.ToInt16(IdCargoTmp.Trim());
                        if (IdCargo > 0)
                        {
                            if (ConstanteCargoList.ContainsKey(IdCargo))
                            {
                                VDC.IdCargo = IdCargo;
                            }
                            else
                            {
                                RegistrosError.Campo = "Cargo";
                                RegistrosError.mensaje = "No existe en la tabla Constante para el IdPadre 71";
                                RegistrosError.NroRegistro = count + 1;
                                RegistrosError.Valor = IdCargoTmp;
                                ListGestionArchivo.Add(RegistrosError);
                                countError++;
                                continue;
                            }

                        }
                        else
                        {
                            RegistrosError.Campo = "Cargo";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdCargoTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "Cargo";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdCargoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Cargo";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdCargoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(IdAreaTmp.Trim()))
                {
                    if (EsNumero(IdAreaTmp))
                    {
                        short IdArea = Convert.ToInt16(IdAreaTmp.Trim());
                        if (IdArea > 0)
                        {
                            if (AreaList.ContainsKey(IdArea))
                            {
                                VDC.IdArea = IdArea;
                            }
                            else
                            {
                                RegistrosError.Campo = "IdArea";
                                RegistrosError.mensaje = "No existe en la tabla Area";
                                RegistrosError.NroRegistro = count + 1;
                                RegistrosError.Valor = IdAreaTmp;
                                ListGestionArchivo.Add(RegistrosError);
                                countError++;
                                continue;
                            }

                        }
                        else
                        {
                            RegistrosError.Campo = "IdArea";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdAreaTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "IdArea";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdAreaTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "IdArea";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdAreaTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(IdNivelRiesgoTmp.Trim()))
                {
                    if (EsNumero(IdNivelRiesgoTmp))
                    {
                        short IdNivelRiesgo = Convert.ToInt16(IdNivelRiesgoTmp.Trim());
                        if (IdNivelRiesgo > 0)
                        {
                            if (ConstanteRiesgoList.ContainsKey(IdNivelRiesgo))
                            {
                                VDC.IdNivelRiesgo = IdNivelRiesgo;
                            }
                            else
                            {
                                RegistrosError.Campo = "IdNivelRiesgo";
                                RegistrosError.mensaje = "No existe en la tabla Constante para el IdPadre 360";
                                RegistrosError.NroRegistro = count + 1;
                                RegistrosError.Valor = IdNivelRiesgoTmp;
                                ListGestionArchivo.Add(RegistrosError);
                                countError++;
                                continue;
                            }

                        }
                        else
                        {
                            RegistrosError.Campo = "IdNivelRiesgo";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdNivelRiesgoTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "IdNivelRiesgo";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdNivelRiesgoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "IdNivelRiesgo";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdNivelRiesgoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(IdTipoPlanillaTmp.Trim()))
                {
                    if (EsNumero(IdTipoPlanillaTmp))
                    {
                        short IdTipoPlanilla = Convert.ToInt16(IdTipoPlanillaTmp.Trim());
                        if (IdTipoPlanilla > 0)
                        {
                            if (ConstanteTipoPlanillaList.ContainsKey(IdTipoPlanilla))
                            {
                                VDC.IdTipoPlanilla = IdTipoPlanilla;
                            }
                            else
                            {
                                RegistrosError.Campo = "IdTipoPlanilla";
                                RegistrosError.mensaje = "No existe en la tabla Constante para el IdPadre 371";
                                RegistrosError.NroRegistro = count + 1;
                                RegistrosError.Valor = IdTipoPlanillaTmp;
                                ListGestionArchivo.Add(RegistrosError);
                                countError++;
                                continue;
                            }
                        }
                        else
                        {
                            RegistrosError.Campo = "IdTipoPlanilla";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdTipoPlanillaTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "IdTipoPlanilla";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdTipoPlanillaTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "IdTipoPlanilla";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdTipoPlanillaTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(RemuneracionMensualTmp.Trim()))
                {
                    if (EsDecimal(RemuneracionMensualTmp))
                    {
                        decimal RemuneracionMensual = Convert.ToDecimal(RemuneracionMensualTmp.Trim());
                        if (RemuneracionMensual > 0)
                        {
                            VDC.ImporteMensual = RemuneracionMensual; //importe mensual
                            VDC.RemuneracionMensual = RemuneracionMensual;
                            cantidadImporte += RemuneracionMensual;
                        }
                        else
                        {
                            RegistrosError.Campo = "RemuneracionMensual";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = RemuneracionMensualTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "RemuneracionMensual";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = RemuneracionMensualTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "RemuneracionMensual";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = RemuneracionMensualTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(GraficiacionesTmp.Trim()))
                {
                    if (EsDecimal(GraficiacionesTmp))
                    {
                        decimal Graficiaciones = Convert.ToDecimal(GraficiacionesTmp.Trim());
                        if (Graficiaciones > 0)
                        {
                            VDC.Graficiaciones = Graficiaciones;
                            VDC.ImporteGratificacion = Graficiaciones; //importe gratificacion
                            cantidadImporte += Graficiaciones;
                        }
                        else
                        {
                            RegistrosError.Campo = "Graficiaciones";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = GraficiacionesTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "Graficiaciones";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = GraficiacionesTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Graficiaciones";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = GraficiacionesTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                //agregamos cada registro a la lista
                ListVDCTrabajadores.Add(VDC);

            }

            InfoArchivos.NroRegistrosTotal = count;
            InfoArchivos.NroRegistrosError = countError;
            InfoArchivos.ListRegistroVDDC = ListVDCTrabajadores;
            InfoArchivos.ListRegistrosError = ListGestionArchivo;

            var archivos = (Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>)Session["ListRegistroVDDC"];
            if (archivos.ContainsKey((int)IdTipoValorDeclarado))
                archivos[IdTipoValorDeclarado] = ListVDCTrabajadores;
            else
                archivos.Add(IdTipoValorDeclarado, ListVDCTrabajadores);
            return InfoArchivos;
        }

        public InfoArchivos ValidaListPracticantesComplemento(IEnumerable<Row> rows, SpreadsheetDocument spreadSheetDocument, string nombreArchivo, string nombreAsignado, int IdTipoValorDeclarado, ref decimal cantidadImporte)
        {
            ValorDeclaradoModalModelView.InfoArchivos InfoArchivos = new ValorDeclaradoModalModelView.InfoArchivos();

            ValorDeclaradoModalModelView.GestionRegistrosArchivo RegistrosError = null;
            List<ValorDeclaradoModalModelView.GestionRegistrosArchivo> ListGestionArchivo
                                            = new List<ValorDeclaradoModalModelView.GestionRegistrosArchivo>();
            List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView> ListVDCPracticantes
                                            = new List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>();
            int count = 0;
            int countError = 0;
            //short IdPadreIdTipoPlanillaPracticante = Convert.ToInt16(ConfigurationManager.AppSettings["IdPadreIdTipoPlanillaPracticante"]);
            short IdPadreIdTipoPlanillaPracticante = Convert.ToInt16(ConfigurationManager.AppSettings["IdPadreIdTipoPlanilla"]);
            short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);
            short IdTipoBien = Convert.ToInt16(ConfigurationManager.AppSettings["IdTipoBienPersona"]);
            short IdAreaPracticante = Convert.ToInt16(ConfigurationManager.AppSettings["IdAreaPracticante"]);
            short IdCargoPracticante = Convert.ToInt16(ConfigurationManager.AppSettings["IdCargoPracticante"]);

            BL.BLogic.Constante ConstanteLogic = new BL.BLogic.Constante();

            Dictionary<short, string> ConstanteTipoPlanillaList = new Dictionary<short, string>();
            Dictionary<int, string> MonedaList = new Dictionary<int, string>();

            ConstanteTipoPlanillaList = ConstanteLogic.ObtenerConstantesPorIdPadre(IdPadreIdTipoPlanillaPracticante, Activo); //IdTipoPlanilla

            foreach (Row row in rows.Where((item, index) => index > 0))
            {
                ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView VDC
                                                        = new ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView();
                string ApellidoPaternoTmp = "";
                string ApellidoMaternoTmp = "";
                string NombreTmp = "";
                string DNITmp = "";
                string FechaNacimientoTmp = "";
                string FechaIngresoTmp = "";
                string IdTipoPlanillaTmp = "";
                string RemuneracionMensualTmp = "";
                RegistrosError = new ValorDeclaradoModalModelView.GestionRegistrosArchivo();
                count++;
                try
                {
                    ApellidoPaternoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(0));
                    ApellidoMaternoTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(1));
                    NombreTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(2));
                    DNITmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(3));
                    FechaNacimientoTmp = DateTime.FromOADate(double.Parse(GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(4)))).ToShortDateString();
                    FechaIngresoTmp = DateTime.FromOADate(double.Parse(GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(5)))).ToShortDateString();
                    IdTipoPlanillaTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(6));
                    RemuneracionMensualTmp = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(7));

                }
                catch (Exception ex)
                {
                    RegistrosError.Campo = "Error en un campo de la fila";
                    RegistrosError.mensaje = "Campo Vacío o null";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = "Referencia Inválida";
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                VDC.IdTipoBien = IdTipoBien;
                VDC.IdEstado = Activo;
                VDC.Ruta = UrlArchivo;
                VDC.NombreAsignado = nombreAsignado;
                VDC.NombreOrigen = nombreArchivo;
                VDC.IdArea = IdAreaPracticante;
                VDC.IdCargo = IdCargoPracticante;

                if (!ValidaCadenaVacia(ApellidoPaternoTmp.Trim()))
                {
                    if (ApellidoPaternoTmp.Trim().Length <= 32)
                    {
                        VDC.ApellidoPaterno = ApellidoPaternoTmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "Apellido Paterno";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 32 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = ApellidoPaternoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Apellido Paterno";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = ApellidoPaternoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(ApellidoMaternoTmp.Trim()))
                {
                    if (ApellidoMaternoTmp.Trim().Length <= 32)
                    {
                        VDC.ApellidoMaterno = ApellidoMaternoTmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "Apellido Paterno";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 32 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = ApellidoMaternoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Apellido Materno";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = ApellidoMaternoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(NombreTmp.Trim()))
                {
                    if (NombreTmp.Trim().Length <= 128)
                    {
                        VDC.Nombre = NombreTmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "Nombre";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 128 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = NombreTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "Nombre";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = NombreTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(DNITmp.Trim()))
                {
                    if (DNITmp.Trim().Length <= 20)
                    {
                        VDC.DNI = DNITmp.Trim();
                    }
                    else
                    {
                        RegistrosError.Campo = "DNI";
                        RegistrosError.mensaje = "Campo tiene que ser máximo de 20 caracteres";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = DNITmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "DNI";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = DNITmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(FechaNacimientoTmp.Trim()))
                {
                    if (ValidaFecha(FechaNacimientoTmp.Trim()))
                    {
                        VDC.FechaNacimiento = Convert.ToDateTime(FechaNacimientoTmp.Trim());
                    }
                    else
                    {
                        RegistrosError.Campo = "FechaNacimiento";
                        RegistrosError.mensaje = "Error en formato de Fecha:  ( ejemplo: 'dd/mm/yyy )";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = FechaNacimientoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "FechaNacimiento";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = FechaNacimientoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(FechaIngresoTmp.Trim()))
                {
                    if (ValidaFecha(FechaIngresoTmp.Trim()))
                    {
                        VDC.FechaIngreso = Convert.ToDateTime(FechaIngresoTmp.Trim());
                        if (DateTime.Compare(VDC.FechaIngreso, VDC.FechaNacimiento) > 0)
                        {
                            //todo ok
                        }
                        else
                        {
                            RegistrosError.Campo = "FechaIngreso";
                            RegistrosError.mensaje = "Fecha de Ingreso debe ser mayor a la fecha de Nacimiento";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = FechaIngresoTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "FechaIngreso";
                        RegistrosError.mensaje = "Error en formato de Fecha:  ( ejemplo: 'dd/mm/yyy )";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = FechaIngresoTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "FechaIngreso";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = FechaIngresoTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(IdTipoPlanillaTmp.Trim()))
                {
                    if (EsNumero(IdTipoPlanillaTmp))
                    {
                        short IdTipoPlanilla = Convert.ToInt16(IdTipoPlanillaTmp.Trim());
                        if (IdTipoPlanilla > 0)
                        {
                            if (ConstanteTipoPlanillaList.ContainsKey(IdTipoPlanilla))
                            {
                                VDC.IdTipoPlanilla = IdTipoPlanilla;
                            }
                            else
                            {
                                RegistrosError.Campo = "IdTipoPlanilla";
                                RegistrosError.mensaje = "No existe en la tabla Constante para el IdPadre 371";
                                RegistrosError.NroRegistro = count + 1;
                                RegistrosError.Valor = IdTipoPlanillaTmp;
                                ListGestionArchivo.Add(RegistrosError);
                                countError++;
                                continue;
                            }
                        }
                        else
                        {
                            RegistrosError.Campo = "IdTipoPlanilla";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = IdTipoPlanillaTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "IdTipoPlanilla";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = IdTipoPlanillaTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "IdTipoPlanilla";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = IdTipoPlanillaTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                if (!ValidaCadenaVacia(RemuneracionMensualTmp.Trim()))
                {
                    if (EsDecimal(RemuneracionMensualTmp))
                    {
                        decimal RemuneracionMensual = Convert.ToDecimal(RemuneracionMensualTmp.Trim());
                        if (RemuneracionMensual > 0)
                        {
                            VDC.ImporteMensual = RemuneracionMensual; //importe mensual
                            VDC.SubvencionMensual = RemuneracionMensual;
                            cantidadImporte += RemuneracionMensual;
                        }
                        else
                        {
                            RegistrosError.Campo = "RemuneracionMensual";
                            RegistrosError.mensaje = "Debe ser mayor que 0";
                            RegistrosError.NroRegistro = count + 1;
                            RegistrosError.Valor = RemuneracionMensualTmp;
                            ListGestionArchivo.Add(RegistrosError);
                            countError++;
                            continue;
                        }

                    }
                    else
                    {
                        RegistrosError.Campo = "RemuneracionMensual";
                        RegistrosError.mensaje = "Debe ser numérico";
                        RegistrosError.NroRegistro = count + 1;
                        RegistrosError.Valor = RemuneracionMensualTmp;
                        ListGestionArchivo.Add(RegistrosError);
                        countError++;
                        continue;
                    }

                }
                else
                {
                    RegistrosError.Campo = "RemuneracionMensual";
                    RegistrosError.mensaje = "Campo Vacío";
                    RegistrosError.NroRegistro = count + 1;
                    RegistrosError.Valor = RemuneracionMensualTmp;
                    ListGestionArchivo.Add(RegistrosError);
                    countError++;
                    continue;
                }

                //agregamos cada registro a la lista
                ListVDCPracticantes.Add(VDC);

            }

            InfoArchivos.NroRegistrosTotal = count;
            InfoArchivos.NroRegistrosError = countError;
            InfoArchivos.ListRegistroVDDC = ListVDCPracticantes;
            InfoArchivos.ListRegistrosError = ListGestionArchivo;

            var archivos = (Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>)Session["ListRegistroVDDC"];
            if (archivos.ContainsKey((int)IdTipoValorDeclarado))
                archivos[IdTipoValorDeclarado] = ListVDCPracticantes;
            else
                archivos.Add(IdTipoValorDeclarado, ListVDCPracticantes);

            return InfoArchivos;
        }

        [HttpPost]
        public bool CrearArchivoErrores(string RegistrosError)
        {
            bool retorno = false;
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            dynamic jsonObject = serializer.Deserialize<dynamic>(RegistrosError);
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);
            try
            {

                StreamWriter sw = new StreamWriter(UrlArchivo + "/Errores.txt");
                //StreamWriter sw = new StreamWriter(Server.MapPath(UrlArchivo) + "/Errores.txt");

                foreach (var InfoArchivos in jsonObject)
                {
                    sw.WriteLine("Registro: " + InfoArchivos["NroRegistro"] + " | Campo: " + InfoArchivos["Campo"] + " | " + InfoArchivos["mensaje"] + " | " + InfoArchivos["Valor"]);
                }
                sw.Close();
                retorno = true;

            }
            catch (Exception e)
            {
                Console.WriteLine("Exception: " + e.Message);
            }
            finally
            {
                Console.WriteLine("Executing finally block.");
            }
            return retorno;
        }

        private string GetCellValue(SpreadsheetDocument document, Cell cell)
        {
            SharedStringTablePart stringTablePart = document.WorkbookPart.SharedStringTablePart;
            string value = cell.CellValue.InnerXml;

            if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
            {
                return stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;
            }
            else
            {
                return value;
            }
        }

        public bool ValidaCadenaVacia(string cadena)
        {

            bool retorno = false;

            if (cadena == null || cadena.Equals(""))
            {
                retorno = true;
            }

            return retorno;
        }


        public bool ValidaFecha(string cadena)
        {

            bool FechaError = false;
            string Fecha = cadena;
            DateTime FechaValida = new DateTime();
            try
            {

                if (string.IsNullOrEmpty(cadena))
                    return false;
                else
                {
                    int len = cadena.Split('/').Length;
                    if (len < 3)
                        return false;
                    else if (len == 3)
                    {
                        string[] fecha = cadena.Split('/');
                        Fecha = ("0" + fecha[0]).Substring(("0" + fecha[0]).Length - 2) + "/";
                        Fecha += ("0" + fecha[1]).Substring(("0" + fecha[1]).Length - 2) + "/";
                        Fecha += fecha[2];
                        FechaValida = DateTime.Parse(Fecha);
                        if (FechaValida.ToString("dd/MM/yyyy") == Fecha)
                            FechaError = true;
                        else
                        {
                            FechaValida = new DateTime();
                            FechaError = false;
                        }
                    }
                    else
                        FechaError = false;
                }

            }
            catch
            {
                FechaError = false;
            }
            return FechaError;
        }

        public bool ValidaPlaca(string cadena)
        {
            try
            {
                if (cadena.Substring(3, 1).Equals("-"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception Ex)
            {
                return false;
            }
        }

        public bool EsNumero(string cadena)
        {
            bool retorno = false;
            try
            {
                retorno = Regex.IsMatch(cadena, @"^\d+$");
            }
            catch (Exception ex)
            {
                retorno = false;
            }
            return retorno;
        }

        public bool EsDecimal(string cadena)
        {
            bool retorno = false;
            //string REGEX_DECIMAL_NUMBERS = "^\\d{1,9}(\\.\\d{1,2})?$";
            try
            {
                decimal number;
                if (Decimal.TryParse(cadena, out number))
                {
                    retorno = true;
                }

                //return retorno = Regex.IsMatch(cadena, REGEX_DECIMAL_NUMBERS);

            }
            catch (Exception ex)
            {
                retorno = false;
            }
            return retorno;
        }

        public DateTime fechaRe(double dia)
        {
            DateTime fec = new DateTime();
            fec.AddDays(dia);

            fec.ToShortDateString();

            return fec;
        }

        public string guardaArchivo(HttpPostedFileBase file)
        {
            string path = String.Empty;

            if (file != null && file.ContentLength > 0)
            {
                Guid cName = Guid.NewGuid();
                path = Path.Combine("\\\\SGD30001\\ArchivosModulos\\Seguros", Convert.ToString(cName + ".xlsx"));
                //path = Path.Combine(Server.MapPath("~/ArchivosValorDeclarado"), Convert.ToString(cName + ".xlsx"));
                file.SaveAs(path);
            }

            return path;
        }

        public ActionResult Ver(short IdValorDeclarado)
        {

            ValorDeclaradoModalModelView Model = null;

            try
            {
                ViewBag.MaxSizeArchivo = ConfigurationManager.AppSettings["MaxSizeArchivo"];
                short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);

                Model = VDLogic.EditarValorDeclarado(IdValorDeclarado);
                JsonResult ModelDetalle = Json(VDLogic.ListarValoresDeclaradosDetalle(IdValorDeclarado, Activo), JsonRequestBehavior.AllowGet);

                JsonResult ModelArchivo = Json(VDLogic.ListarArchivoValoresDeclarados(IdValorDeclarado, Activo), JsonRequestBehavior.AllowGet);

                var jsonSerialiser = new JavaScriptSerializer();
                Model.ValorDeclaradoCabecera.ValorDeclaradoDetalle = jsonSerialiser.Serialize(ModelDetalle.Data);
                Model.ValorDeclaradoCabecera.ListaArchivo = jsonSerialiser.Serialize(ModelArchivo.Data);

                if (Model != null)
                {
                    ViewBag.IdEmpresa = new SelectList(EmpresaLogic.ListaEmpresas(), "IdEmpresa", "NombreCorto", Model.IdEmpresa);
                    ViewBag.IdMoneda = new SelectList(MonedaLogic.ListaMonedas(), "IdMoneda", "Moneda", Model.IdMoneda);
                    ViewBag.IdTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclarados(), "IdTipoValorDeclarado", "Nombre");
                    ViewBag.IdUnidadMedida = new SelectList(UMLogic.ListaUnidadMedidas(), "IdUnidadMedida", "Nombre");
                }

                return PartialView(Model);

            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

        }

        public ActionResult Disgrega(DisgregaParamsModalView disgregaParamsModalView)
        {
            try
            {
                if (disgregaParamsModalView.DescEstado.ToUpper().Contains("DISGRE")
                   || disgregaParamsModalView.DescEstado.ToUpper().Contains("Autorización en Proceso".ToUpper()))
                {
                    JsonResult listaDisgregacion = Json(disgregaBL.ObtenerDisgregacionesValorDeclarado(disgregaParamsModalView.IdValorDeclarado), JsonRequestBehavior.AllowGet);
                    var jsonSerialiser = new JavaScriptSerializer();
                    ViewBag.ListaDisgregacion = jsonSerialiser.Serialize(listaDisgregacion.Data);
                }
                string filtroPoliza = "TIPOLIZA";
                List<TipoPolizaComboView> listaTipoPoliza = new List<TipoPolizaComboView>();
                ViewBag.edit = disgregaParamsModalView.edit;
                ViewBag.IdValorDeclarado = disgregaParamsModalView.IdValorDeclarado;
                ViewBag.IdMoneda = disgregaParamsModalView.IdMoneda;
                ViewBag.DescMoneda = disgregaParamsModalView.DescMoneda;
                ViewBag.DescEmpresa = disgregaParamsModalView.DescEmpresa;
                //ViewBag.DescEmpresa = disgregaParamsModalView.NombreCortoEmpresa;
                ViewBag.EstadoValorDeclarado = disgregaParamsModalView.DescEstado;
                ViewBag.ListaTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclaradosDesdeValorDeclaradoDetalle(disgregaParamsModalView.IdValorDeclarado), "IdTipoValorDeclarado", "Nombre");
                ViewBag.ListaRamoPoliza = new SelectList(constanteBL.ListarDetalleConstante(filtroPoliza), "IdConstante", "Constante");
                ViewBag.ListaTipoPoliza = new SelectList(listaTipoPoliza, "IdTipoPoliza", "Descripcion");
                ViewBag.MaxSizeArchivo = ConfigurationManager.AppSettings["MaxSizeArchivo"];
                short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
                JsonResult ModelArchivo = Json(VDLogic.ListarArchivoValoresDeclarados(disgregaParamsModalView.IdValorDeclarado, Activo), JsonRequestBehavior.AllowGet);
                var jsonSerialiserArchivo = new JavaScriptSerializer();
                ViewBag.ListaArchivo = jsonSerialiserArchivo.Serialize(ModelArchivo.Data);
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

        }

        public ActionResult ObtenerTiposPolizas(short IdTipoPoliza)
        {
            try
            {
                List<TipoPolizaComboView> listaPolizas = (from t in tipoPolizaBL.ListarTiposPolizaPorRamoPoliza(IdTipoPoliza).Where(x => x.IdEstado == true).ToList()
                                                          select new TipoPolizaComboView()
                                                          {
                                                              IdDivisionPoliza = t.IdDivisionPoliza,
                                                              Descripcion = t.Descripcion
                                                          }).ToList();
                return Json(listaPolizas, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

        }

        public ActionResult ObtenerInfoTipoValorDeclarado(short IdTipoValorDeclarado, int IdValorDeclarado)
        {
            try
            {
                return Json(disgregaBL.ObtenerDatosValorDeclaradoDetalle(IdTipoValorDeclarado, IdValorDeclarado), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = "Ha ocurrido un error, intente de nuevo.";
                return Json(mensaje, JsonRequestBehavior.AllowGet);
            }

        }

        [HttpPost]
        public ActionResult DisgregarValorDeclarado(string ListaDisgregacion, int IdValorDeclarado,
                                                    string ListaEliminadosDisgregacion, string EstadoValorDeclarado,
                                                    string ListaArchivos, string ListaArchivosEliminados)
        {
            if (EstadoValorDeclarado.ToUpper().Contains("DISGRE"))
            {
                return PartialView("../Common/Mensaje", disgregaBL.ActualizarDisgregacionValorDeclarado(ListaDisgregacion, IdValorDeclarado, ListaEliminadosDisgregacion, ListaArchivos, ListaArchivosEliminados));
            }
            return PartialView("../Common/Mensaje", disgregaBL.InsertarDisgregacionValorDeclarado(ListaDisgregacion, IdValorDeclarado, ListaArchivos, ListaArchivosEliminados));
        }

        public ActionResult DevuelveFlagsPorIdTipoValorDeclarado(short IdTipoValorDeclarado)
        {
            try
            {
                return Json(TVDLogic.DevuelveFlagsPorIdTipoValorDeclarado(IdTipoValorDeclarado), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }

        }


        public ActionResult VerValorDeclaradoDetalleComplementoVH(int IdValorDeclaradoDetalle, int IdTipoValorDeclarado)
        {
            ViewBag.ValorDeclaradoDetalle_IdValorDeclaradoDetalle = IdValorDeclaradoDetalle;
            ViewBag.IdTipoValorDeclarado = IdTipoValorDeclarado;
            return PartialView("VerValorDeclaradoDetalleComplementoVH"); ;

        }

        [HttpPost]
        public ActionResult VerValorDeclaradoDetalleComplementoVeHiculo(short IdValorDeclaradoDetalle, int IdTipoValorDeclarado)
        {
            JsonResult jsonResult = null;
            try
            {
                short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);

                if (IdValorDeclaradoDetalle > 0)
                {
                    jsonResult = Json(VDLogic.VerValorDeclaradoDetalleComplementoVH(IdValorDeclaradoDetalle, Activo), JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var archivos = (Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>)Session["ListRegistroVDDC"];
                    var tblResult = from x in archivos[IdTipoValorDeclarado]
                                    select new VDDCModalView
                                    {
                                        IdUUNN = x.IdUUNN,
                                        IdCentroCosto = x.IdCentroCosto.ToString(),
                                        NroPlaca = x.NroPlaca,
                                        SerieMotor = x.NroMotor,
                                        SerieCarroceria = x.NroChasis,
                                        idMarca = x.IdMarca,
                                        idModelo = x.IdModelo,
                                        AnoFabricacion = x.AnoFabricacion,
                                        Clase = x.Clase.ToString(),
                                        Ocupantes = x.NroAsientos,
                                        TimonCambiado = x.TimonCambiado == 0 ? "NO" : "SI",
                                        FechaInicio = x.FechaInicio.ToShortDateString(),
                                        FechaTermino = x.FechaFin.ToShortDateString(),
                                        idMoneda = x.IdMoneda,
                                        ValorDeclarado = x.ValorDeclarado,

                                    };
                    jsonResult = Json(tblResult.ToList(), JsonRequestBehavior.AllowGet);

                }
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

        public ActionResult VerValorDeclaradoDetalleComplementoTrab(int IdValorDeclaradoDetalle, int IdTipoValorDeclarado)
        {
            ViewBag.ValorDeclaradoDetalle_IdValorDeclaradoDetalle = IdValorDeclaradoDetalle;
            ViewBag.IdTipoValorDeclarado = IdTipoValorDeclarado;
            return PartialView("VerValorDeclaradoDetalleComplementoTrab_Prac"); ;

        }

        [HttpPost]
        public ActionResult VerValorDeclaradoDetalleComplementoTrab(short IdValorDeclaradoDetalle, int IdTipoValorDeclarado)
        {
            JsonResult jsonResult = null;
            try
            {
                short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
                if (IdValorDeclaradoDetalle > 0)
                {
                    jsonResult = Json(VDLogic.VerValorDeclaradoDetalleComplementoTrab_Prac(IdValorDeclaradoDetalle, Activo), JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var archivos = (Dictionary<int, List<ValorDeclaradoModalModelView.ValorDeclaradoDetalleComplementoModalView>>)Session["ListRegistroVDDC"];
                    var tblResult = from x in archivos[IdTipoValorDeclarado]
                                    select new VDDCModalTrabajadorView
                                    {
                                        ApellidoMaterno = x.ApellidoMaterno,
                                        ApellidoPaterno = x.ApellidoPaterno,
                                        DNI = x.DNI,
                                        Nombre = x.Nombre,
                                        FechaNacimiento = x.FechaNacimiento.ToShortDateString(),
                                        FechaIngreso = x.FechaIngreso.ToShortDateString(),
                                        idArea = x.IdArea,
                                        idCargo = x.IdCargo,
                                        Graticiacion = x.Graficiaciones,
                                        idNivelRiesgo = x.IdNivelRiesgo,
                                        idTipoPlanilla = x.IdTipoPlanilla,
                                        RemuneracionMensual = x.RemuneracionMensual,
                                        SubvencionMensual = x.SubvencionMensual
                                    };
                    jsonResult = Json(tblResult.ToList(), JsonRequestBehavior.AllowGet);

                }
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

        public ActionResult VerDisgregar(DisgregaParamsModalView disgregaParamsModalView)
        {
            try
            {
                if (disgregaParamsModalView.DescEstado.ToUpper().Contains("DISGRE")
                    || disgregaParamsModalView.DescEstado.ToUpper().Contains("AJUST")
                    || disgregaParamsModalView.DescEstado.ToUpper().Contains("AUTORIZADO"))
                {
                    JsonResult listaDisgregacion = Json(disgregaBL.ObtenerDisgregacionesValorDeclarado(disgregaParamsModalView.IdValorDeclarado), JsonRequestBehavior.AllowGet);
                    var jsonSerialiser = new JavaScriptSerializer();
                    ViewBag.ListaDisgregacion = jsonSerialiser.Serialize(listaDisgregacion.Data);
                }
                string filtroPoliza = "TIPOLIZA";
                List<TipoPolizaComboView> listaTipoPoliza = new List<TipoPolizaComboView>();
                ViewBag.IdValorDeclarado = disgregaParamsModalView.IdValorDeclarado;
                ViewBag.IdMoneda = disgregaParamsModalView.IdMoneda;
                ViewBag.DescMoneda = disgregaParamsModalView.DescMoneda;
                ViewBag.DescEmpresa = disgregaParamsModalView.DescEmpresa;
                ViewBag.EstadoValorDeclarado = disgregaParamsModalView.DescEstado;
                ViewBag.ListaTipoValorDeclarado = new SelectList(TVDLogic.ListaTipoValoresDeclaradosDesdeValorDeclaradoDetalle(disgregaParamsModalView.IdValorDeclarado), "IdTipoValorDeclarado", "Nombre");
                ViewBag.ListaRamoPoliza = new SelectList(constanteBL.ListarDetalleConstante(filtroPoliza), "IdConstante", "Constante");
                ViewBag.ListaTipoPoliza = new SelectList(listaTipoPoliza, "IdTipoPoliza", "Descripcion");
                ViewBag.MaxSizeArchivo = ConfigurationManager.AppSettings["MaxSizeArchivo"];
                short Activo = Convert.ToInt16(ConfigurationManager.AppSettings["Activo"]);
                JsonResult ModelArchivo = Json(VDLogic.ListarArchivoValoresDeclarados(disgregaParamsModalView.IdValorDeclarado, Activo), JsonRequestBehavior.AllowGet);
                var jsonSerialiserArchivo = new JavaScriptSerializer();
                ViewBag.ListaArchivo = jsonSerialiserArchivo.Serialize(ModelArchivo.Data);
                return PartialView();
            }
            catch (Exception ex)
            {
                Mensaje mensaje = new Mensaje();
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
                return PartialView("../Common/Mensaje", mensaje);
            }
        }

        [HttpPost]
        public ActionResult SolicitarAutorizacion(int IdValorDeclarado)
        {
            Mensaje mensaje = new Mensaje();
            mensaje.esError = false;
            short IdProceso = Convert.ToInt16(ConfigurationManager.AppSettings["IdProceso"]);
            string Dominio = Convert.ToString(ConfigurationManager.AppSettings["Dominio"]);
            try
            {
                VDLogic.NotificarAutorizacion(IdValorDeclarado, IdProceso, Dominio);
            }
            catch (Exception)
            {
                mensaje.esError = true;
                mensaje.mensaje = "Ocurrió un error en el envió de la notificación de autorización";
            }
            return PartialView("../Common/Mensaje", mensaje);
        }

    }
}