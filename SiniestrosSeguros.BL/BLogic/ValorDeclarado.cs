using SiniestrosSeguros.DAO;
using SiniestrosSeguros.DTO;
using SiniestrosSeguros.DTO.ModelCustoms;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using static SiniestrosSeguros.DTO.ModelViews.ValorDeclarado;

namespace SiniestrosSeguros.BL.BLogic
{
    public class ValorDeclarado
    {
        SegurosDBEntities context = new SegurosDBEntities();
        public List<ValorDeclaradoModalModelView.importeAjustadoCantidadAjustadaViewModel> importeAjustadoViewModel(Nullable<int> idValorDeclaradoDetalleDisgregado, Nullable<decimal> cantidadAjustada, Nullable<decimal> importeAjustado)
        {

            List<ValorDeclaradoModalModelView.importeAjustadoCantidadAjustadaViewModel> VD = null;

            try
            {
                VD = (from t in context.SP_S_validar_importe_ajustado_y_cantidad_ajustada(idValorDeclaradoDetalleDisgregado, cantidadAjustada, importeAjustado).ToList()
                      select new ValorDeclaradoModalModelView.importeAjustadoCantidadAjustadaViewModel()
                      {
                          error = t.error,
                          mensaje = t.mensaje
                      }).ToList();
            }
            catch (Exception ex)
            {
                VD = null;
                throw ex;
            }

            return VD;
        }
        public List<BusquedaValorDeclaradoModelView> ListarValoresDeclarados(BusquedaValorDeclaradoModelView busquedaValorDeclaradoModelView)
        {

            List<BusquedaValorDeclaradoModelView> VD = null;

            try
            {
                VD = (from t in context.SP_S_ValorDeclarado_page_server(busquedaValorDeclaradoModelView.IdEmpresa,
                                                            busquedaValorDeclaradoModelView.FechaVigenciaIni,
                                                            busquedaValorDeclaradoModelView.FechaVigenciaFin,
                                                            busquedaValorDeclaradoModelView.IdEstado,
                                                            busquedaValorDeclaradoModelView.iPagina,
                                                            busquedaValorDeclaradoModelView.iTamaño).ToList()
                      select new BusquedaValorDeclaradoModelView()
                      {
                          IdValorDeclarado = t.IdValorDeclarado,
                          DescEmpresa = t.DescEmpresa,
                          FechaVigenciaIni = t.FechaVigenciaInicio,
                          FechaVigenciaIniText = String.Format("{0:dd/MM/yyyy}", t.FechaVigenciaInicio),
                          FechaVigenciaFin = t.FechaVigenciaTermino,
                          FechaVigenciaFinText = String.Format("{0:dd/MM/yyyy}", t.FechaVigenciaTermino),
                          IdMoneda = t.IdMoneda,
                          DescMoneda = t.DescMoneda,
                          TipoCambio = t.TipoCambio,
                          DescEstado = t.DescEstado,
                          NombreCortoEmpresa = t.NombreCortoEmpresa,
                          totalFiltrados = (short?)t.totalFiltrados

                      }).OrderByDescending(x => x.IdValorDeclarado).ToList();
            }
            catch (Exception ex)
            {
                VD = null;
                throw ex;
            }

            return VD;
        }


        public Mensaje CrearValorDeclarado(ValorDeclaradoModalModelView VD)
        {
            Mensaje mensaje = new Mensaje();
            ObjectParameter IdValorDeclarado = null;
            IdValorDeclarado = new ObjectParameter("IdValorDeclarado", typeof(Int32));
            IdValorDeclarado.Value = DBNull.Value;

            //guardamos el detalle
            using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
            {
                try
                {
                    int retorno = context.SP_I_ValorDeclarado(
                                    IdValorDeclarado,
                                    VD.IdEmpresa,
                                    VD.ValorDeclaradoCabecera.FechaVigenciaIniModal,
                                    VD.ValorDeclaradoCabecera.FechaVigenciaFinModal,
                                    VD.IdMoneda,
                                    VD.ValorDeclaradoCabecera.TipoCambio);

                    int IdValorDeclaradoInt = Convert.ToInt32(IdValorDeclarado.Value);

                    JavaScriptSerializer serializer = new JavaScriptSerializer();

                    /**Inicio guardar Detalle*/
                    dynamic jsonObject = serializer.Deserialize<dynamic>(VD.ValorDeclaradoCabecera.ValorDeclaradoDetalle);
                    short? n1 = 0;
                    decimal n2 = 0;
                    //detalle
                    foreach (var registroList in jsonObject)
                    {

                        short IdUnidadMedidaDetalle = (registroList["IdUnidadMedidaDetalle"] != null && registroList["IdUnidadMedidaDetalle"] != "") ? short.Parse(registroList["IdUnidadMedidaDetalle"]) : n1;
                        short IdTipoValorDeclaradoDetalle = (registroList["IdTipoValorDeclaradoDetalle"] != null && registroList["IdTipoValorDeclaradoDetalle"] != "") ? short.Parse(registroList["IdTipoValorDeclaradoDetalle"]) : n1;
                        Decimal ImporteValorDeclarado = (registroList["ImporteValorDeclarado"] != null && registroList["ImporteValorDeclarado"] != "") ? Decimal.Parse(registroList["ImporteValorDeclarado"]) : n2;
                        Decimal Cantidad = (registroList["CantidadDetalle"] != null && registroList["CantidadDetalle"] != "") ? Decimal.Parse(registroList["CantidadDetalle"]) : n2;
                        short IdMoneda = (registroList["IdMonedaDetalle"] != null && registroList["IdMonedaDetalle"] != "") ? short.Parse(registroList["IdMonedaDetalle"]) : n1;

                        ObjectParameter IdValorDeclaradoDetalle = null;
                        IdValorDeclaradoDetalle = new ObjectParameter("IdValorDeclaradoDetalle", typeof(Int32));
                        IdValorDeclaradoDetalle.Value = DBNull.Value;
                        short? valorNull = null;
                        retorno = context.SP_I_ValorDeclaradoDetalle(
                                    IdValorDeclaradoDetalle,
                                    IdValorDeclaradoInt,
                                    IdTipoValorDeclaradoDetalle,
                                    IdUnidadMedidaDetalle == 0 ? valorNull : IdUnidadMedidaDetalle,
                                    Cantidad,
                                    ImporteValorDeclarado,
                                    IdMoneda,
                                    VD.IdTipoRegistro);

                        int IdValorDeclaradoDetalleInt = Convert.ToInt32(IdValorDeclaradoDetalle.Value);

                        //TVDD Vehiculo
                        if (IdTipoValorDeclaradoDetalle == 3)
                        {
                            /**Inicio guardar Detalle Complemento*/
                            if (VD.ValorDeclaradoDetalleComplementoVH != null && !VD.ValorDeclaradoDetalleComplementoVH.Trim().Equals("") && !VD.ValorDeclaradoDetalleComplementoVH.Equals("null"))
                            {
                                dynamic jsonVehiculo = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoVH);
                                short Inactivo = 0;
                                mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleInt, Inactivo);
                                if (!mensaje.esError)
                                {
                                    CrearValorDeclaradoDetalleComplementoVH(jsonVehiculo, IdValorDeclaradoDetalleInt);
                                }

                            }
                            /**Fin guardar Detalle Complemento*/
                            //Inicio Trabajadadores
                        }
                        else if (IdTipoValorDeclaradoDetalle == 2)
                        {
                            /**Inicio guardar Detalle Complemento*/
                            if (VD.ValorDeclaradoDetalleComplementoTRAB != null && !VD.ValorDeclaradoDetalleComplementoTRAB.Trim().Equals("") && !VD.ValorDeclaradoDetalleComplementoTRAB.Equals("null"))
                            {
                                dynamic jsonTrabajadores = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoTRAB);
                                short Inactivo = 0;
                                mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleInt, Inactivo);
                                if (!mensaje.esError)
                                    CrearValorDeclaradoDetalleComplementoTRAB(jsonTrabajadores, IdValorDeclaradoDetalleInt);

                            }
                            /**Fin guardar Detalle Complemento*/
                        }
                        else if (IdTipoValorDeclaradoDetalle == 1)
                        {
                            /**Inicio guardar Detalle Complemento*/
                            if (VD.ValorDeclaradoDetalleComplementoPRAC != null && !VD.ValorDeclaradoDetalleComplementoPRAC.Trim().Equals("") && !VD.ValorDeclaradoDetalleComplementoPRAC.Equals("null"))
                            {
                                dynamic jsonPracticantes = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoPRAC);
                                short Inactivo = 0;
                                mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleInt, Inactivo);
                                if (!mensaje.esError)
                                    CrearValorDeclaradoDetalleComplementoPRAC(jsonPracticantes, IdValorDeclaradoDetalleInt);
                            }
                            /**Fin guardar Detalle Complemento*/
                        }


                    }
                    /**Fin guardar Detalle*/

                    dynamic jsonArchivos = serializer.Deserialize<dynamic>(VD.ValorDeclaradoCabecera.ListaArchivo);

                    foreach (var registroList in jsonArchivos)
                    {
                        string NombreArchivo = (registroList["NombreArchivo"] != null && registroList["NombreArchivo"] != "") ? Convert.ToString(registroList["NombreArchivo"]) : "";
                        string NombreAsignado = (registroList["NombreAsignado"] != null && registroList["NombreAsignado"] != "") ? Convert.ToString(registroList["NombreAsignado"]) : "";
                        string RutaArchivo = (registroList["RutaArchivo"] != null && registroList["RutaArchivo"] != "") ? Convert.ToString(registroList["RutaArchivo"]) : "";
                        string Formato = (registroList["Formato"] != null && registroList["Formato"] != "") ? Convert.ToString(registroList["Formato"]) : "";
                        short IdEstado = (registroList["IdEstado"] != null) ? Convert.ToInt16(registroList["IdEstado"]) : n1;

                        ObjectParameter IdArchivo = null;
                        IdArchivo = new ObjectParameter("IdArchivo", typeof(Int32));
                        IdArchivo.Value = DBNull.Value;

                        retorno = context.SP_I_ArchivoValorDeclarado(
                                    IdValorDeclaradoInt,
                                    IdArchivo,
                                    NombreArchivo,
                                    NombreAsignado,
                                    RutaArchivo,
                                    Formato,
                                    IdEstado);
                    }

                    //Generar Autorizacion
                    context.ValorDeclaradoAutorizacion_Insertar_pa(IdValorDeclaradoInt, VD.IdEmpresa, VD.IdProceso);
                    context.SaveChanges();
                    Transaccion.Commit();
                    mensaje.esError = false;
                }
                catch (Exception ex)
                {
                    Transaccion.Rollback();
                    mensaje.esError = true;
                    mensaje.mensaje = ex.Message;
                }
            }


            return mensaje;
        }

        public List<ValorDeclaradoModalModelView.CrearValorDeclaradoDetalleModelView> ListarValoresDeclaradosDetalle(int IdValorDeclarado, short IdEstado)
        {

            List<ValorDeclaradoModalModelView.CrearValorDeclaradoDetalleModelView> VD = null;

            try
            {
                VD = (from t in context.SP_S_ValorDeclaradoDetalle(IdValorDeclarado, IdEstado).ToList()
                      select new ValorDeclaradoModalModelView.CrearValorDeclaradoDetalleModelView()
                      {
                          IdValorDeclaradoDetalle = t.IdValorDeclaradoDetalle,
                          IdTipoValorDeclarado = t.IdTipoValorDeclarado,
                          TipoValorDeclaradoDesc = t.TipoValorDeclaradoDesc,
                          IdMoneda = t.IdMoneda,
                          MonedaDesc = t.MonedaDesc,
                          ImporteValorDeclarado = t.ImporteValorDeclarado,
                          IdUnidadMedida = t.IdUnidadMedida,
                          UnidadMedidaDesc = t.UnidadMedidaDesc,
                          Cantidad = t.Cantidad,
                          FlagEdicion = 0
                      }).ToList();
            }
            catch (Exception ex)
            {
                VD = null;
                throw ex;
            }

            return VD;
        }

        public List<ValorDeclaradoModalModelView.ArchivoModelView> ListarArchivoValoresDeclarados(int IdValorDeclarado, short IdEstado)
        {

            List<ValorDeclaradoModalModelView.ArchivoModelView> VD = null;

            try
            {
                VD = (from t in context.SP_S_ArchivoValorDeclarado(IdValorDeclarado, IdEstado).ToList()
                      select new ValorDeclaradoModalModelView.ArchivoModelView()
                      {
                          IdArchivo = t.IdArchivo,
                          NombreArchivo = t.NombreOrigen,
                          NombreAsignado = t.NombreAsignado,
                          RutaArchivo = t.Ruta,
                          Formato = t.Formato,
                          IdValorDeclarado = t.IdValorDeclarado,
                          IdEstado = t.Estado

                      }).ToList();
            }
            catch (Exception ex)
            {
                VD = null;
                throw ex;
            }

            return VD;
        }

        public ValorDeclaradoModalModelView EditarValorDeclarado(short IdValorDeclarado)
        {
            SP_S_ValorDeclaradoPorId_Result response = null;
            ValorDeclaradoModalModelView VD = null;

            try
            {
                response = context.SP_S_ValorDeclaradoPorId(IdValorDeclarado).FirstOrDefault();

                VD = new ValorDeclaradoModalModelView();
                ValorDeclaradoModalModelView.CrearValorDeclaradoModelView Cabecera = new ValorDeclaradoModalModelView.CrearValorDeclaradoModelView();

                Cabecera.IdValorDeclarado = response.IdValorDeclarado;
                Cabecera.FechaVigenciaIniModal = response.FechaVigenciaInicio;
                Cabecera.FechaVigenciaFinModal = response.FechaVigenciaTermino;
                Cabecera.TipoCambio = response.TipoCambio;
                VD.IdEmpresa = response.IdEmpresa;
                VD.IdMoneda = response.IdMoneda;

                VD.ValorDeclaradoCabecera = Cabecera;
            }
            catch (Exception ex)
            {
                VD = null;
                throw ex;
            }

            return VD;
        }

        public Mensaje ActualizarValorDeclarado(ValorDeclaradoModalModelView VD)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                //trans
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        int retorno = context.SP_U_ValorDeclarado(
                        VD.ValorDeclaradoCabecera.IdValorDeclarado,
                        VD.IdEmpresa,
                        VD.ValorDeclaradoCabecera.FechaVigenciaIniModal,
                        VD.ValorDeclaradoCabecera.FechaVigenciaFinModal,
                        VD.IdMoneda,
                        VD.ValorDeclaradoCabecera.TipoCambio);

                        JavaScriptSerializer serializer = new JavaScriptSerializer();

                        //Agregar detalle
                        dynamic jsonObject = serializer.Deserialize<dynamic>(VD.ValorDeclaradoCabecera.ValorDeclaradoDetalle);
                        short? n1 = 0;
                        decimal n2 = 0;
                        short? valorNull = null;

                        foreach (var registroList in jsonObject)
                        {
                            int IdValorDeclaradoDetalleTmp = (registroList["IdValorDeclaradoDetalle"] != null) ? Convert.ToInt32(registroList["IdValorDeclaradoDetalle"]) : 0;
                            int FlagEdicionTmp = Convert.ToInt32(registroList["FlagEdicion"]);

                            ObjectParameter IdValorDeclaradoDetalle = null;
                            if (IdValorDeclaradoDetalleTmp <= 0)
                            {

                                //obtenemos los demas valores
                                short IdUnidadMedidaDetalle = (registroList["IdUnidadMedidaDetalle"] != null && registroList["IdUnidadMedidaDetalle"] != "") ? Convert.ToInt16(registroList["IdUnidadMedidaDetalle"]) : n1;
                                short IdTipoValorDeclaradoDetalle = (registroList["IdTipoValorDeclaradoDetalle"] != null) ? Convert.ToInt16(registroList["IdTipoValorDeclaradoDetalle"]) : n1;
                                decimal ImporteValorDeclarado = (registroList["ImporteValorDeclarado"] != null && registroList["ImporteValorDeclarado"] != "") ? Convert.ToDecimal(registroList["ImporteValorDeclarado"]) : n2;
                                decimal Cantidad = (registroList["CantidadDetalle"] != null && registroList["CantidadDetalle"] != "") ? Convert.ToDecimal(registroList["CantidadDetalle"]) : n2;
                                short IdMoneda = (registroList["IdMonedaDetalle"] != null) ? Convert.ToInt16(registroList["IdMonedaDetalle"]) : n1;


                                IdValorDeclaradoDetalle = new ObjectParameter("IdValorDeclaradoDetalle", typeof(Int32));
                                IdValorDeclaradoDetalle.Value = DBNull.Value;

                                retorno = context.SP_I_ValorDeclaradoDetalle(
                                            IdValorDeclaradoDetalle,
                                            VD.ValorDeclaradoCabecera.IdValorDeclarado,
                                            IdTipoValorDeclaradoDetalle,
                                            IdUnidadMedidaDetalle == 0 ? valorNull : IdUnidadMedidaDetalle,
                                            Cantidad,
                                            ImporteValorDeclarado,
                                            IdMoneda,
                                            VD.IdTipoRegistro);

                                int IdValorDeclaradoDetalleInt = Convert.ToInt32(IdValorDeclaradoDetalle.Value);
                                //TVDD Vehiculo
                                if (IdTipoValorDeclaradoDetalle == 3)
                                {
                                    /**Inicio guardar Detalle Complemento*/
                                    if (VD.ValorDeclaradoDetalleComplementoVH != null && !VD.ValorDeclaradoDetalleComplementoVH.Trim().Equals(""))
                                    {
                                        dynamic jsonVehiculo = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoVH);

                                        short Inactivo = 0;
                                        mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleInt, Inactivo);
                                        if (!mensaje.esError)
                                            CrearValorDeclaradoDetalleComplementoVH(jsonVehiculo, IdValorDeclaradoDetalleInt);
                                        //}

                                    }
                                    /**Fin guardar Detalle Complemento*/
                                }
                                else if (IdTipoValorDeclaradoDetalle == 2)
                                {
                                    /**Inicio guardar Detalle Complemento*/
                                    if (VD.ValorDeclaradoDetalleComplementoTRAB != null && !VD.ValorDeclaradoDetalleComplementoTRAB.Trim().Equals(""))
                                    {
                                        dynamic jsonTrabajadores = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoTRAB);
                                        short Inactivo = 0;
                                        mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleInt, Inactivo);
                                        if (!mensaje.esError)
                                            CrearValorDeclaradoDetalleComplementoTRAB(jsonTrabajadores, IdValorDeclaradoDetalleInt);
                                    }
                                    /**Fin guardar Detalle Complemento*/
                                }
                                else if (IdTipoValorDeclaradoDetalle == 1)
                                {
                                    /**Inicio guardar Detalle Complemento*/
                                    if (VD.ValorDeclaradoDetalleComplementoPRAC != null && !VD.ValorDeclaradoDetalleComplementoPRAC.Trim().Equals(""))
                                    {
                                        dynamic jsonPracticantes = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoPRAC);
                                        short Inactivo = 0;
                                        mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleInt, Inactivo);
                                        if (!mensaje.esError)
                                            CrearValorDeclaradoDetalleComplementoPRAC(jsonPracticantes, IdValorDeclaradoDetalleInt);

                                    }
                                    /**Fin guardar Detalle Complemento*/
                                }

                            }
                            else if (IdValorDeclaradoDetalleTmp > 0 && FlagEdicionTmp < 0)
                            {
                                //EDITAMOS LOS VDD QUE YA HABIAN SIDO AÑADIDOS ANTERIORMENTE Y QUE SE MODIFICARON

                                //obtenemos los demas valores
                                short IdUnidadMedidaDetalle = (registroList["IdUnidadMedidaDetalle"] != null && registroList["IdUnidadMedidaDetalle"] != "") ? Convert.ToInt16(registroList["IdUnidadMedidaDetalle"]) : n1;
                                short IdTipoValorDeclaradoDetalle = (registroList["IdTipoValorDeclaradoDetalle"] != null) ? Convert.ToInt16(registroList["IdTipoValorDeclaradoDetalle"]) : n1;
                                decimal ImporteValorDeclarado = (registroList["ImporteValorDeclarado"] != null && registroList["ImporteValorDeclarado"] != "") ? Convert.ToDecimal(registroList["ImporteValorDeclarado"]) : n2;
                                decimal Cantidad = (registroList["CantidadDetalle"] != null && registroList["CantidadDetalle"] != "") ? Convert.ToDecimal(registroList["CantidadDetalle"]) : n2;
                                short IdMoneda = (registroList["IdMonedaDetalle"] != null) ? Convert.ToInt16(registroList["IdMonedaDetalle"]) : n1;

                                retorno = context.SP_U_ValorDeclaradoDetalle(
                                            IdValorDeclaradoDetalleTmp,
                                            IdTipoValorDeclaradoDetalle,
                                            IdUnidadMedidaDetalle == 0 ? valorNull : IdUnidadMedidaDetalle,
                                            IdMoneda,
                                            Cantidad,
                                            ImporteValorDeclarado
                                            );

                                //TVDD Vehiculo
                                if (IdTipoValorDeclaradoDetalle == 3)
                                {
                                    /**Inicio guardar Detalle Complemento*/
                                    if (VD.ValorDeclaradoDetalleComplementoVH != null && !VD.ValorDeclaradoDetalleComplementoVH.Trim().Equals(""))
                                    {
                                        dynamic jsonVehiculo = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoVH);
                                        short Inactivo = 0;
                                        mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleTmp, Inactivo);
                                        if (!mensaje.esError)
                                            CrearValorDeclaradoDetalleComplementoVH(jsonVehiculo, IdValorDeclaradoDetalleTmp);
                                    }
                                    /**Fin guardar Detalle Complemento*/
                                }
                                else if (IdTipoValorDeclaradoDetalle == 2)
                                {
                                    /**Inicio guardar Detalle Complemento*/
                                    if (VD.ValorDeclaradoDetalleComplementoTRAB != null && !VD.ValorDeclaradoDetalleComplementoTRAB.Trim().Equals(""))
                                    {
                                        dynamic jsonTrabajadores = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoTRAB);
                                        short Inactivo = 0;
                                        mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleTmp, Inactivo);
                                        if (!mensaje.esError)
                                            CrearValorDeclaradoDetalleComplementoTRAB(jsonTrabajadores, IdValorDeclaradoDetalleTmp);
                                    }
                                    /**Fin guardar Detalle Complemento*/
                                }
                                else if (IdTipoValorDeclaradoDetalle == 1)
                                {
                                    /**Inicio guardar Detalle Complemento*/
                                    if (VD.ValorDeclaradoDetalleComplementoPRAC != null && !VD.ValorDeclaradoDetalleComplementoPRAC.Trim().Equals(""))
                                    {
                                        dynamic jsonPracticantes = serializer.Deserialize<dynamic>(VD.ValorDeclaradoDetalleComplementoPRAC);
                                        short Inactivo = 0;
                                        mensaje = ActualizarEstadoValorDeclaradoDetalleComplemeento(IdValorDeclaradoDetalleTmp, Inactivo);
                                        if (!mensaje.esError)
                                            CrearValorDeclaradoDetalleComplementoPRAC(jsonPracticantes, IdValorDeclaradoDetalleTmp);
                                    }
                                    /**Fin guardar Detalle Complemento*/
                                }

                            }
                        }

                        //Eliminar detalle
                        dynamic jsonObjectEliminado = serializer.Deserialize<dynamic>(VD.ValorDeclaradoCabecera.ValorDeclaradoDetalleEliminado);
                        foreach (var registroList in jsonObjectEliminado)
                        {
                            int IdValorDeclaradoDetalle = registroList["IdValorDeclaradoDetalle"];
                            //short IdUnidadMedidaDetalle = (registroList["IdUnidadMedidaDetalle"] != null) ? Convert.ToInt16(registroList["IdUnidadMedidaDetalle"]) : n1;
                            //short IdTipoValorDeclaradoDetalle = (registroList["IdTipoValorDeclaradoDetalle"] != null) ? Convert.ToInt16(registroList["IdTipoValorDeclaradoDetalle"]) : n1;
                            //Decimal ImporteValorDeclarado = (registroList["ImporteValorDeclarado"] != null) ? Convert.ToDecimal(registroList["ImporteValorDeclarado"]) : 0.0;
                            //Decimal Cantidad = (registroList["CantidadDetalle"] != null) ? Convert.ToDecimal(registroList["CantidadDetalle"]) : 0.0;
                            //short IdMoneda = (registroList["IdMonedaDetalle"] != null) ? Convert.ToInt16(registroList["IdMonedaDetalle"]) : n1;
                            short IdEstado = (registroList["IdEstado"] != null) ? Convert.ToInt16(registroList["IdEstado"]) : n1;

                            retorno = context.SP_D_ValorDeclaradoDetallePorId(
                                            IdValorDeclaradoDetalle, IdEstado);
                        }


                        //Agregar Archivo
                        dynamic jsonArchivos = serializer.Deserialize<dynamic>(VD.ValorDeclaradoCabecera.ListaArchivo);
                        foreach (var registroList in jsonArchivos)
                        {
                            int IdArchivoTmp = registroList["IdArchivo"];

                            if (IdArchivoTmp <= 0)
                            {
                                string NombreArchivo = (registroList["NombreArchivo"] != null && registroList["NombreArchivo"] != "") ? Convert.ToString(registroList["NombreArchivo"]) : "";
                                string NombreAsignado = (registroList["NombreAsignado"] != null && registroList["NombreAsignado"] != "") ? Convert.ToString(registroList["NombreAsignado"]) : "";
                                string RutaArchivo = (registroList["RutaArchivo"] != null && registroList["RutaArchivo"] != "") ? Convert.ToString(registroList["RutaArchivo"]) : "";
                                string Formato = (registroList["Formato"] != null && registroList["Formato"] != "") ? Convert.ToString(registroList["Formato"]) : "";
                                short IdEstado = (registroList["IdEstado"] != null) ? Convert.ToInt16(registroList["IdEstado"]) : n1;

                                ObjectParameter IdArchivo = null;
                                IdArchivo = new ObjectParameter("IdArchivo", typeof(Int32));
                                IdArchivo.Value = DBNull.Value;

                                retorno = context.SP_I_ArchivoValorDeclarado(
                                            VD.ValorDeclaradoCabecera.IdValorDeclarado,
                                            IdArchivo,
                                            NombreArchivo,
                                            NombreAsignado,
                                            RutaArchivo,
                                            Formato,
                                            IdEstado);
                            }
                        }

                        //Eliminar Archivo
                        dynamic jsonArchivosEliminado = serializer.Deserialize<dynamic>(VD.ValorDeclaradoCabecera.ListaArchivoEliminado);
                        foreach (var registroList in jsonArchivosEliminado)
                        {
                            int IdArchivo = registroList["IdArchivo"];
                            short IdEstado = (registroList["IdEstado"] != null) ? Convert.ToInt16(registroList["IdEstado"]) : n1;

                            retorno = context.SP_D_ArchivoValorDeclaradoPorId(IdArchivo, IdEstado);
                        }

                        context.SaveChanges();
                        Transaccion.Commit();
                        mensaje.esError = false;
                    }
                    catch (Exception ex)
                    {
                        mensaje.esError = true;
                        mensaje.mensaje = ex.Message;
                    }
                }

            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return mensaje;
        }

        public Mensaje ActualizarEstadoValorDeclarado(int IdValorDeclarado, string DescEstado)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                DTO.ModelCustoms.Estado.Estados estado = (from t in context.SP_S_Estado().ToList()
                                                          where t.Detalle.ToUpper().Contains(DescEstado)
                                                          select new DTO.ModelCustoms.Estado.Estados()
                                                          {
                                                              IdRegistro = t.IdRegistro,
                                                              Detalle = t.Detalle
                                                          }
                                                         ).FirstOrDefault();

                context.SP_U_ValorDeclarado_Estado(IdValorDeclarado, Convert.ToInt16(estado.IdRegistro));
                mensaje.esError = false;
            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return mensaje;
        }
        //problem

        public Mensaje ActualizarEstadoValorDeclarado(int IdValorDeclarado, short IdRegistro)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                context.SP_U_ValorDeclarado_Estado(IdValorDeclarado, IdRegistro);
                mensaje.esError = false;
            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return mensaje;
        }

        public Mensaje CrearValorDeclaradoDetalleComplementoVH(dynamic jsonVehiculo, int IdValorDeclaradoDetalle)
        {
            Mensaje mensaje = new Mensaje();


            BL.BLogic.Vehiculo VHLogic = new BL.BLogic.Vehiculo();
            BL.BLogic.UnidadNegocio UNLogic = new BL.BLogic.UnidadNegocio();
            foreach (var VDC in jsonVehiculo)
            {

                DTO.ModelViews.Vehiculo.VehiculosModelView vehiculo = new DTO.ModelViews.Vehiculo.VehiculosModelView();
                vehiculo.IdUnidadNegocio = Convert.ToInt16(VDC["IdUUNN"]);
                vehiculo.IdEmpresa = UNLogic.ObtenerIdEmpresaPorUnidadNegocio(Convert.ToInt16(VDC["IdUUNN"]), 1); ;
                vehiculo.IdCentroCosto = Convert.ToInt16(VDC["IdCentroCosto"]);
                vehiculo.IdTipoVehiculo = Convert.ToInt16(VDC["Clase"]);
                vehiculo.IdMarca = Convert.ToInt16(VDC["IdMarca"]);
                vehiculo.IdModelo = Convert.ToInt32(VDC["IdModelo"]);
                vehiculo.Placa = Convert.ToString(VDC["NroPlaca"]);
                vehiculo.Clase = Convert.ToString(VDC["Clase"]);
                vehiculo.SerieMotor = Convert.ToString(VDC["NroMotor"]);
                vehiculo.SerieCarroceria = Convert.ToString(VDC["NroChasis"]);
                vehiculo.NroAsientos = Convert.ToInt16(VDC["NroAsientos"]);
                vehiculo.AnoFabricado = Convert.ToInt16(VDC["AnoFabricacion"]);
                vehiculo.TimonCambiado = Convert.ToInt16(VDC["TimonCambiado"]);
                vehiculo.IdMoneda = Convert.ToInt16(VDC["IdMoneda"]);
                vehiculo.ValorComercial = Convert.ToDecimal(VDC["ValorDeclarado"]);
                vehiculo.IdEstado = Convert.ToInt16(VDC["IdEstado"]);
                vehiculo.FechaInicio = Convert.ToDateTime(VDC["FechaInicio"]);
                vehiculo.FechaFin = Convert.ToDateTime(VDC["FechaFin"]);


                ObjectParameter IdValorDeclaradoDetalleComplemento = null;
                IdValorDeclaradoDetalleComplemento = new ObjectParameter("IdValorDeclaradoDetalleComplemento", typeof(Int32));
                IdValorDeclaradoDetalleComplemento.Value = DBNull.Value;

                short IdCargo = VDC["IdCargo"] != null ? Convert.ToInt16(VDC["IdCargo"]) : 0;
                short TipoPlanilla = VDC["IdTipoPlanilla"] != null ? Convert.ToInt16(VDC["IdTipoPlanilla"]) : 0;
                short IdNivelRiesgo = VDC["IdNivelRiesgo"] != null ? Convert.ToInt16(VDC["IdNivelRiesgo"]) : 0;
                decimal ImporteMensual = VDC["ImporteMensual"] != null ? Convert.ToDecimal(VDC["ImporteMensual"]) : 0;
                decimal ImporteGratificacion = VDC["ImporteGratificacion"] != null ? Convert.ToDecimal(VDC["ImporteGratificacion"]) : 0;
                short IdArea = Convert.ToInt16(VDC["IdArea"]) != null ? Convert.ToInt16(VDC["IdArea"]) : 0;
                int IdInstalacion = Convert.ToInt32(VDC["IdInstalacion"]) != null ? Convert.ToInt32(VDC["IdInstalacion"]) : 0;
                int IdElementoElectrico = VDC["IdElementoElectrico"] != null ? Convert.ToInt32(VDC["IdElementoElectrico"]) : 0;

                context.SP_I_ValorDeclaradoDetalleComplemento_vehiculo_excel_writer(
                            IdValorDeclaradoDetalleComplemento,
                            IdValorDeclaradoDetalle,
                            Convert.ToInt16(VDC["IdTipoBien"]),
                            null,
                            Convert.ToInt16(VDC["IdCentroCosto"]),
                            IdArea,
                            IdCargo,
                            Convert.ToInt16(VDC["IdUUNN"]),
                            TipoPlanilla,
                            IdNivelRiesgo,
                            Convert.ToDecimal(VDC["ValorDeclarado"]),
                            ImporteMensual,
                            ImporteGratificacion,
                            Convert.ToInt16(VDC["IdEstado"]),
                            Convert.ToString(VDC["NombreOrigen"]),
                            Convert.ToString(VDC["NombreAsignado"]),
                            Convert.ToString(VDC["Ruta"]),
                            vehiculo.IdEmpresa,
                            vehiculo.IdUnidadNegocio,
                            vehiculo.IdTipoVehiculo,
                            vehiculo.IdMarca,
                            vehiculo.IdModelo,
                            vehiculo.PlacaAnterior,
                            vehiculo.Placa,
                            vehiculo.SerieCarroceria,
                            vehiculo.SerieMotor,
                            vehiculo.Clase,
                            vehiculo.AnoFabricado,
                            vehiculo.IdColor,
                            vehiculo.NroAsientos,
                            vehiculo.TimonCambiado,
                            vehiculo.IdMoneda,
                            vehiculo.ValorComercial,
                            vehiculo.FechaInicio,
                            vehiculo.FechaFin
                            );

            }

            return mensaje;
        }


        public Mensaje CrearValorDeclaradoDetalleComplementoTRAB(dynamic jsonTrabajador, int IdValorDeclaradoDetalle)
        {
            Mensaje mensaje = new Mensaje();


            BL.BLogic.Trabajador TrabajadorLogic = new BL.BLogic.Trabajador();
            BL.BLogic.Persona PersonaLogic = new BL.BLogic.Persona();


            foreach (var VDC in jsonTrabajador)
            {
                short IdCargo = VDC["IdCargo"] != null ? Convert.ToInt16(VDC["IdCargo"]) : 0;
                short TipoPlanilla = VDC["IdTipoPlanilla"] != null ? Convert.ToInt16(VDC["IdTipoPlanilla"]) : 0;
                short IdNivelRiesgo = VDC["IdNivelRiesgo"] != null ? Convert.ToInt16(VDC["IdNivelRiesgo"]) : 0;
                decimal ImporteMensual = VDC["ImporteMensual"] != null ? Convert.ToDecimal(VDC["ImporteMensual"]) : 0;
                decimal ImporteGratificacion = VDC["ImporteGratificacion"] != null ? Convert.ToDecimal(VDC["ImporteGratificacion"]) : 0;
                short IdArea = Convert.ToInt16(VDC["IdArea"]) != null ? Convert.ToInt16(VDC["IdArea"]) : 0;
                short IdTipoBien = VDC["IdTipoBien"] != null ? Convert.ToInt16(VDC["IdTipoBien"]) : 0;
                string FechaNacimiento = VDC["FechaNacimiento"] == null ? "" : Convert.ToString(VDC["FechaNacimiento"]);
                //buscaremos el Persona
                //int IdTrabajadorTmp = 0;

                DTO.ModelViews.Persona.Personas Persona = new DTO.ModelViews.Persona.Personas();
                Persona.Nombre = Convert.ToString(VDC["Nombre"]);
                Persona.ApellidoPaterno = Convert.ToString(VDC["ApellidoPaterno"]);
                Persona.ApellidoMaterno = Convert.ToString(VDC["ApellidoMaterno"]);
                Persona.NroIdentidad = Convert.ToString(VDC["DNI"]);
                Persona.IdEstado = Convert.ToInt16(VDC["IdEstado"]);
                Persona.FechaNacimiento = FechaNacimiento;

                DTO.ModelViews.Trabajador.Trabajadores Trabajador = new DTO.ModelViews.Trabajador.Trabajadores();
                Trabajador.IdArea = IdArea;
                Trabajador.EsPlanillado = 0;
                Trabajador.IdCargo = IdCargo;
                Trabajador.IdEstado = Convert.ToInt16(VDC["IdEstado"]);
                Trabajador.FechaIngreso = Convert.ToDateTime(VDC["FechaIngreso"]);

                ObjectParameter IdValorDeclaradoDetalleComplemento = null;
                IdValorDeclaradoDetalleComplemento = new ObjectParameter("IdValorDeclaradoDetalleComplemento", typeof(Int32));
                IdValorDeclaradoDetalleComplemento.Value = DBNull.Value;

                context.SP_I_ValorDeclaradoDetalleComplemento_trabajador_excel_writer(
                            IdValorDeclaradoDetalleComplemento,
                            IdValorDeclaradoDetalle,
                            IdTipoBien,
                            null, //IdElementoElectrico falta definir porque este campo es Foraneo. Debe permitir null?
                            0,
                            null,//IdVehiculo
                            null, // IdInstalacion falta definir porque este campo es Foraneo. Debe permitir null?
                            null, //IdCentroCosto
                            IdArea,
                            IdCargo,
                            null,
                            TipoPlanilla,
                            IdNivelRiesgo,
                            null,
                            ImporteMensual,
                            ImporteGratificacion,
                            Convert.ToInt16(VDC["IdEstado"]),
                            Convert.ToString(VDC["NombreOrigen"]),
                            Convert.ToString(VDC["NombreAsignado"]),
                            Convert.ToString(VDC["Ruta"]),
                           Persona.NroIdentidad,
                            Persona.Nombre,
                            Persona.ApellidoPaterno,
                            Persona.ApellidoMaterno,
                            string.IsNullOrEmpty(Persona.FechaNacimiento) ? null : (DateTime?)Convert.ToDateTime(Persona.FechaNacimiento),
                            Trabajador.FechaIngreso
                            );

            }

            return mensaje;
        }

        public Mensaje CrearValorDeclaradoDetalleComplementoPRAC(dynamic jsonTrabajador, int IdValorDeclaradoDetalle)
        {
            Mensaje mensaje = new Mensaje();


            BL.BLogic.Trabajador TrabajadorLogic = new BL.BLogic.Trabajador();
            BL.BLogic.Persona PersonaLogic = new BL.BLogic.Persona();
            foreach (var VDC in jsonTrabajador)
            {
                short TipoPlanilla = VDC["IdTipoPlanilla"] != null ? Convert.ToInt16(VDC["IdTipoPlanilla"]) : 0;
                decimal ImporteMensual = VDC["ImporteMensual"] != null ? Convert.ToDecimal(VDC["ImporteMensual"]) : 0;
                short IdTipoBien = VDC["IdTipoBien"] != null ? Convert.ToInt16(VDC["IdTipoBien"]) : 0;
                string FechaNacimiento = VDC["FechaNacimiento"] == null ? "" : Convert.ToString(VDC["FechaNacimiento"]);
                //buscaremos el Persona
                /* -- */
                DTO.ModelViews.Persona.Personas Persona = new DTO.ModelViews.Persona.Personas();
                Persona.Nombre = Convert.ToString(VDC["Nombre"]);
                Persona.ApellidoPaterno = Convert.ToString(VDC["ApellidoPaterno"]);
                Persona.ApellidoMaterno = Convert.ToString(VDC["ApellidoMaterno"]);
                Persona.NroIdentidad = Convert.ToString(VDC["DNI"]);
                Persona.IdEstado = Convert.ToInt16(VDC["IdEstado"]);
                Persona.FechaNacimiento = FechaNacimiento;

                DTO.ModelViews.Trabajador.Trabajadores Trabajador = new DTO.ModelViews.Trabajador.Trabajadores();
                Trabajador.IdArea = Convert.ToInt16(VDC["IdArea"]); //verificar
                Trabajador.EsPlanillado = 0;
                Trabajador.IdCargo = Convert.ToInt16(VDC["IdCargo"]); //verificar
                Trabajador.IdEstado = Convert.ToInt16(VDC["IdEstado"]);
                Trabajador.FechaIngreso = Convert.ToDateTime(VDC["FechaIngreso"]);


                ObjectParameter IdValorDeclaradoDetalleComplemento = null;
                IdValorDeclaradoDetalleComplemento = new ObjectParameter("IdValorDeclaradoDetalleComplemento", typeof(Int32));
                IdValorDeclaradoDetalleComplemento.Value = DBNull.Value;

                context.SP_I_ValorDeclaradoDetalleComplemento_trabajador_excel_writer(
                            IdValorDeclaradoDetalleComplemento,
                            IdValorDeclaradoDetalle,
                            IdTipoBien,
                            null, //IdElementoElectrico falta definir porque este campo es Foraneo. Debe permitir null?
                            0,
                            null,//IdVehiculo
                            null, // IdInstalacion falta definir porque este campo es Foraneo. Debe permitir null?
                            null, //IdCentroCosto
                            Trabajador.IdArea,
                            Trabajador.IdCargo,
                            null,
                            TipoPlanilla,
                            0,
                            null,
                            ImporteMensual,
                            0,
                            Convert.ToInt16(VDC["IdEstado"]),
                            Convert.ToString(VDC["NombreOrigen"]),
                            Convert.ToString(VDC["NombreAsignado"]),
                            Convert.ToString(VDC["Ruta"]),
                            Persona.NroIdentidad,
                            Persona.Nombre,
                            Persona.ApellidoPaterno,
                            Persona.ApellidoMaterno,
                            string.IsNullOrEmpty(Persona.FechaNacimiento) ? null : (DateTime?)Convert.ToDateTime(Persona.FechaNacimiento),
                            Trabajador.FechaIngreso
                            );

            }

            return mensaje;
        }

        public List<ValorDeclaradoModalModelView.VDDCModalView> VerValorDeclaradoDetalleComplementoVH(int IdValorDeclaradoDetalle, short IdEstado)
        {
            List<ValorDeclaradoModalModelView.VDDCModalView> VDDC = null;

            try
            {
                VDDC = (from t in context.SP_S_ValorDeclaradoDetalleComplemento(IdValorDeclaradoDetalle, IdEstado).ToList()
                        select new ValorDeclaradoModalModelView.VDDCModalView()
                        {
                            IdUUNN = t.IdUUNN,
                            UnidadNegocio = t.UnidadNegocio,
                            IdCentroCosto = t.IdCentroCosto,
                            CentroCosto = t.CentroCosto,
                            NroPlaca = t.NroPlaca,
                            SerieMotor = t.SerieMotor,
                            SerieCarroceria = t.SerieCarroceria,
                            idMarca = t.IdMarca,
                            Marca = t.Marca,
                            idModelo = t.IdModelo,
                            Modelo = t.Modelo,
                            AnoFabricacion = t.AnoFabricado,
                            Clase = t.Clase,
                            Ocupantes = t.NroAsientos,
                            TimonCambiado = t.TimonCambiado == 0 ? "NO" : "SI",
                            FechaInicio = t.fechaInicio,
                            FechaTermino = t.fechaTermino,
                            idMoneda = t.IdMoneda,
                            Moneda = t.Moneda,
                            ValorDeclarado = t.ValorDeclarado,
                        }).ToList();

            }
            catch (Exception ex)
            {
                VDDC = null;
                throw ex;
            }

            return VDDC;
        }

        public List<ValorDeclaradoModalModelView.VDDCModalTrabajadorView> VerValorDeclaradoDetalleComplementoTrab_Prac(int IdValorDeclaradoDetalle, short IdEstado)
        {
            List<ValorDeclaradoModalModelView.VDDCModalTrabajadorView> VDDC = null;

            try
            {
                VDDC = (from t in context.SP_S_ValorDeclaradoDetalleComplementoTrabajador(IdValorDeclaradoDetalle, IdEstado).ToList()
                        select new ValorDeclaradoModalModelView.VDDCModalTrabajadorView()
                        {
                            Nombre = t.Nombre,
                            ApellidoPaterno = t.ApellidoPaterno,
                            ApellidoMaterno = t.ApellidoMaterno,
                            DNI = t.DNI,
                            FechaIngreso = t.FechaIngreso,
                            FechaNacimiento = t.FechaNacimiento == null ? "" : t.FechaNacimiento.Value.ToShortDateString(),
                            idCargo = t.IdCargo,
                            idArea = t.IdArea,
                            area = t.area,
                            cargo = t.cargo,
                            idNivelRiesgo = t.IdNivelRiesgo,
                            riesgo = t.riesgo,
                            idTipoPlanilla = t.IdTipoPlanilla,
                            planilla = t.planilla,
                            RemuneracionMensual = t.ImporteMensual,
                            SubvencionMensual = t.ImporteMensual,
                            Graticiacion = t.ImporteGratificacion
                        }).ToList();

            }
            catch (Exception ex)
            {
                VDDC = null;
                throw ex;
            }

            return VDDC;
        }

        public Mensaje ActualizarEstadoValorDeclaradoDetalleComplemeento(int IdValorDeclaradoDetalle, short IdEstado)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                context.SP_U_ValorDeclaradoDetalleComplementoPorEstado(IdValorDeclaradoDetalle, IdEstado);
                mensaje.esError = false;
            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return mensaje;
        }

        public void ActualizarValorDeclaradoAutorizacion(string ClaveUnica, short IdEstado, int IdValorDeclarado, short IdAutorizado, short IdProceso, string Dominio)
        {
            try
            {
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        int resp = context.SP_U_ValorDeclaradoAutorizacion(Guid.Parse(ClaveUnica), IdEstado);
                        if (resp == 0)
                        {
                            throw new Exception("No se encontró la clave única indicada para realizar la operación.");
                        }

                        SP_S_PendienteAutorizacion_Result result = context.SP_S_PendienteAutorizacion(IdValorDeclarado).FirstOrDefault();
                        ValorDeclaradoAutorizacion valorDeclaradoAutorizacion = null;
                        if (result != null)
                        {
                            valorDeclaradoAutorizacion = new ValorDeclaradoAutorizacion();
                            valorDeclaradoAutorizacion.IdValorDeclaradoAutorizacion = result.IdValorDeclaradoAutorizacion;
                            valorDeclaradoAutorizacion.IdValorDeclarado = result.IdValorDeclarado;
                            valorDeclaradoAutorizacion.IdArea = result.IdArea;
                            valorDeclaradoAutorizacion.IdCargo = result.IdCargo;
                            valorDeclaradoAutorizacion.IdTrabajador = result.IdTrabajador;
                            valorDeclaradoAutorizacion.OrdenAutoriza = result.OrdenAutoriza;
                        }

                        if (valorDeclaradoAutorizacion == null)
                        {
                            int respActualizacion = context.SP_U_ValorDeclarado_Estado(IdValorDeclarado, IdAutorizado);
                            if (respActualizacion == 0)
                            {
                                throw new Exception("No se encontró el valor declarado para realizar dicha operación.");
                            }
                        }
                        else
                        {
                            if (context.SP_S_ValorDeclaradoPorId(Convert.ToInt16(IdValorDeclarado)).FirstOrDefault() == null)
                            {
                                throw new Exception("No se encontró el valor declarado para realizar dicha operación.");
                            }
                            NotificarAutorizacion(IdValorDeclarado, IdProceso, Dominio);
                        }
                        context.SaveChanges();
                        Transaccion.Commit();
                    }
                    catch (Exception ex)
                    {
                        Transaccion.Rollback();
                        throw ex;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //problem

        public void NotificarAutorizacion(int IdValorDeclarado, short IdProceso, string Dominio)
        {
            try
            {
                context.SP_S_NotificarAutorizacion(IdValorDeclarado, IdProceso, Dominio);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
