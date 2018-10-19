using SiniestrosSeguros.DAO;
using SiniestrosSeguros.DTO.ModelCustoms;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using static SiniestrosSeguros.DTO.ModelCustoms.Disgrega;
using static SiniestrosSeguros.DTO.ModelViews.ValorDeclarado.DisgregarValorDeclaradoModelView;

namespace SiniestrosSeguros.BL.BLogic
{
    public class DisgregaValorDeclarado
    {
        SegurosDBEntities context = new SegurosDBEntities();

        ValorDeclarado valorDeclaradoBL = new ValorDeclarado();

        public InfoValorDeclaradoDetalleModalView ObtenerDatosValorDeclaradoDetalle(short IdTipoValorDeclarado, int IdValorDeclarado)
        {
            InfoValorDeclaradoDetalleModalView infoValorDeclaradoDetalleModalView = null;
            try
            {
                infoValorDeclaradoDetalleModalView = new InfoValorDeclaradoDetalleModalView();
                DTO.SP_S_ValorDeclaradoDetalle_PorTipoValorDeclarado_ValorDeclarado_Result obj = context.SP_S_ValorDeclaradoDetalle_PorTipoValorDeclarado_ValorDeclarado(IdValorDeclarado, IdTipoValorDeclarado).FirstOrDefault();
                infoValorDeclaradoDetalleModalView.IdValorDeclaradoDetalle = obj.IdValorDeclaradoDetalle;
                infoValorDeclaradoDetalleModalView.IdUnidadMedida = obj.IdUnidadMedida;
                infoValorDeclaradoDetalleModalView.UnidadMedida = obj.Nombre;
                infoValorDeclaradoDetalleModalView.AfectaImporte = obj.AfectaImporte;
                infoValorDeclaradoDetalleModalView.AfectaCantidad = obj.AfectaCantidad;
                infoValorDeclaradoDetalleModalView.ImporteValorDeclarado = obj.ImporteValorDeclarado;
                infoValorDeclaradoDetalleModalView.Cantidad = obj.Cantidad;
            }
            catch (Exception ex)
            {
                infoValorDeclaradoDetalleModalView = null;
                throw ex;
            }
            return infoValorDeclaradoDetalleModalView;
        } 

        public Mensaje InsertarDisgregacionValorDeclarado(string json, int IdValorDeclarado, string ListaArchivos, string ListaArchivosEliminados)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        JavaScriptSerializer serializer = new JavaScriptSerializer();

                        dynamic jsonObject = serializer.Deserialize<dynamic>(json);
                        foreach (var registroList in jsonObject)
                        {

                            int IdValorDeclaradoDetalle = int.Parse(registroList["IdValorDeclaradoDetalle"]);
                            short IdRamoPoliza = short.Parse(registroList["IdRamoPoliza"]);
                            short IdTipoPoliza = short.Parse(registroList["IdTipoPoliza"]);
                            decimal? ImporteValorDeclarado = registroList["ImporteValorDeclarado"] != null ? Decimal.Parse(registroList["ImporteValorDeclarado"]) : null;
                            short? IdUnidadMedida = registroList["IdUnidadMedida"] != null ? short.Parse(registroList["IdUnidadMedida"]) : null;
                            decimal? Cantidad = registroList["Cantidad"] != null ? Decimal.Parse(registroList["Cantidad"]) : null;
                            short IdMoneda = short.Parse(registroList["IdMoneda"]);

                            context.SP_I_ValorDeclaradoDetalleDisgregado(
                                        IdValorDeclaradoDetalle,
                                        IdRamoPoliza,
                                        IdTipoPoliza,
                                        IdUnidadMedida,
                                        Cantidad,
                                        IdMoneda,
                                        ImporteValorDeclarado
                                        );
                        }
                        ActualizacionArchivosValorDeclarado(IdValorDeclarado, ListaArchivos, ListaArchivosEliminados);
                        mensaje = valorDeclaradoBL.ActualizarEstadoValorDeclarado(IdValorDeclarado, "DISGREG");
                        if (!mensaje.esError)
                        {
                            context.SaveChanges();
                            Transaccion.Commit();
                            mensaje.mensaje = "La operación se realizó correctamente";
                            mensaje.esError = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        Transaccion.Rollback();
                        throw ex;
                    }
                }
            }
            catch (Exception)
            {
                mensaje.mensaje = "Ocurrió un error al realizar la disgregación";
                mensaje.esError = true;
            }
            
            return mensaje;
        }

        public List<TablaTipoPolizaDisgregadoModelView> ObtenerDisgregacionesValorDeclarado(int IdValorDeclarado)
        {
            List<TablaTipoPolizaDisgregadoModelView> listaDisgregaciones = null;

            try
            {
                listaDisgregaciones = (from t in context.SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclarado(IdValorDeclarado).ToList()
                                      select new TablaTipoPolizaDisgregadoModelView()
                                      {
                                          IdValorDeclaradoDetalleDisgregado = t.IdValorDeclaradoDetalleDisgregado,
                                          IdValorDeclaradoDetalle = t.IdValorDeclaradoDetalle,
                                          IdTipoValorDeclarado = t.IdTipoValorDeclarado,
                                          TipoValorDeclarado = t.TipoValorDeclarado,
                                          IdRamoPoliza = t.IdTipoPoliza,
                                          RamoPoliza = t.RamoPoliza,
                                          IdTipoPoliza = t.IdDivisionPoliza,
                                          TipoPoliza = t.DivisionPoliza,
                                          IdUnidadMedida = t.IdUnidadMedida,
                                          UnidadMedida = t.UnidadMedida,
                                          Cantidad = t.Cantidad,
                                          IdMoneda = t.IdMoneda,
                                          Moneda = t.Moneda,
                                          Importe = t.ImporteValorDeclarado
                                      }).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return listaDisgregaciones;
        }

        public Mensaje ActualizarDisgregacionValorDeclarado(string jsonListaVista, int IdValorDeclarado, 
                                                            string jsonListaEliminados, string jsonListaArchivos,
                                                            string jsonListaArchivosEliminados)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        JavaScriptSerializer serializer = new JavaScriptSerializer();

                        dynamic jsonObject = serializer.Deserialize<dynamic>(jsonListaVista);
                        foreach (var registroList in jsonObject)
                        {
                            int IdValorDeclaradoDetalleDisgregado = registroList["IdValorDeclaradoDetalleDisgregado"];
                            if (IdValorDeclaradoDetalleDisgregado <= 0)
                            {
                                int IdValorDeclaradoDetalle = int.Parse(registroList["IdValorDeclaradoDetalle"]);
                                short IdRamoPoliza = short.Parse(registroList["IdRamoPoliza"]);
                                short IdTipoPoliza = short.Parse(registroList["IdTipoPoliza"]);
                                decimal? ImporteValorDeclarado = registroList["ImporteValorDeclarado"] != null ? Decimal.Parse(registroList["ImporteValorDeclarado"]) : null;
                                short? IdUnidadMedida = registroList["IdUnidadMedida"] != null ? short.Parse(registroList["IdUnidadMedida"]) : null;
                                decimal? Cantidad = registroList["Cantidad"] != null ? Decimal.Parse(registroList["Cantidad"]) : null;
                                short IdMoneda = short.Parse(registroList["IdMoneda"]);

                                context.SP_I_ValorDeclaradoDetalleDisgregado(
                                       IdValorDeclaradoDetalle,
                                       IdRamoPoliza,
                                       IdTipoPoliza,
                                       IdUnidadMedida,
                                       Cantidad,
                                       IdMoneda,
                                       ImporteValorDeclarado
                                       );

                            }



                        }

                        dynamic jsonObjectEliminar = serializer.Deserialize<dynamic>(jsonListaEliminados);
                        foreach (var registroList in jsonObjectEliminar)
                        {
                            context.SP_D_ValorDeclaradoDetalleDisgregado(registroList["IdValorDeclaradoDetalleDisgregado"]);
                        }

                        ActualizacionArchivosValorDeclarado(IdValorDeclarado, jsonListaArchivos, jsonListaArchivosEliminados);
                        //--> Confirma los cambios y los almacena en mi ef y no lo envia al servidor--> 
                        context.SaveChanges();
                        //--> confirma los cambios y lo envia al servidor 
                        Transaccion.Commit();
                        mensaje.esError = false;
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
                mensaje.mensaje = ex.Message;
                mensaje.esError = true;
            }
            return mensaje;
        }

        private void ActualizacionArchivosValorDeclarado(int IdValorDeclarado, string ListaArchivo, string ListaArchivosEliminados)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            short? n1 = 0;
            //Agregar Archivo
            dynamic jsonArchivos = serializer.Deserialize<dynamic>(ListaArchivo);
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

                    context.SP_I_ArchivoValorDeclarado(
                                IdValorDeclarado,
                                IdArchivo,
                                NombreArchivo,
                                NombreAsignado,
                                RutaArchivo,
                                Formato,
                                IdEstado);
                }
            }

            //Eliminar Archivo
            dynamic jsonArchivosEliminado = serializer.Deserialize<dynamic>(ListaArchivosEliminados);
            foreach (var registroList in jsonArchivosEliminado)
            {
                int IdArchivo = registroList["IdArchivo"];
                short IdEstado = (registroList["IdEstado"] != null) ? Convert.ToInt16(registroList["IdEstado"]) : n1;

                context.SP_D_ArchivoValorDeclaradoPorId(IdArchivo, IdEstado);
            }
        }

    }
}
