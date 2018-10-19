using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SiniestrosSeguros.DAO;
using SiniestrosSeguros.DTO.ModelCustoms;
using static SiniestrosSeguros.DTO.ModelViews.AjusteValorDeclarado;

namespace SiniestrosSeguros.BL.BLogic
{
    public class AjusteValorDeclarado
    {

        SegurosDBEntities context = new SegurosDBEntities();
        ValorDeclarado valorDeclaradoBL = new ValorDeclarado();

        public List<DTO.ModelViews.ValorDeclarado.AjusteValorDeclaradoModelView.TablaTipoValorDeclaradoModelView> ListarTiposValorDeclaradoPorValorDeclarado(int IdValorDeclarado)
        {
            List<DTO.ModelViews.ValorDeclarado.AjusteValorDeclaradoModelView.TablaTipoValorDeclaradoModelView> listaTipoValorDeclarado = null;

            try
            {
                listaTipoValorDeclarado = (from t in context.SP_S_ValorDeclaradoDetalle_PorIdValorDeclarado(IdValorDeclarado).ToList()
                                               select new DTO.ModelViews.ValorDeclarado.AjusteValorDeclaradoModelView.TablaTipoValorDeclaradoModelView()
                                               {
                                                   IdTipoValorDeclaradoDetalle = t.IdValorDeclaradoDetalle,
                                                   TipoValorDeclarado = t.Nombre,
                                                   Moneda = t.Moneda,
                                                   ImporteReal = t.ImporteValorDeclarado,
                                                   ImporteAjustado = t.ImporteAjustado,
                                                   UnidadMedida = t.UnidadMedida,
                                                   CantidadReal = t.Cantidad,
                                                   CantidadAjustada = t.CantidadAjustada,
                                                   TipoRegistro = t.TipoRegistro,
                                                   Afecta = t.Afecta,
                                                   Estado = t.Detalle
                                               }).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return listaTipoValorDeclarado;
        }

        public List<DTO.ModelViews.ValorDeclarado.AjusteValorDeclaradoModelView.TablaTipoPolizaModelView> ListarTiposPolizaPorValorDeclaradoDetalle(int IdValorDeclaradoDetalle)
        {
            List<DTO.ModelViews.ValorDeclarado.AjusteValorDeclaradoModelView.TablaTipoPolizaModelView> listaTipoPolizas = null;

            try
            {
                listaTipoPolizas = (from t in context.SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclaradoDetalle(IdValorDeclaradoDetalle).ToList()
                                           select new DTO.ModelViews.ValorDeclarado.AjusteValorDeclaradoModelView.TablaTipoPolizaModelView()
                                           {
                                               IdValorDeclaradoDetalleDisgregado = t.IdValorDeclaradoDetalleDisgregado,
                                               RamoPoliza = t.RamoPoliza,
                                               TipoPoliza = t.TipoPoliza,
                                               Moneda = t.Moneda,
                                               ImporteValorDeclarado = t.ImporteValorDeclarado,
                                               ImporteAjustado = t.ImporteAjustado,
                                               UnidadMedida = t.Nombre,
                                               Cantidad = t.Cantidad,
                                               CantidadAjustada = t.CantidadAjustada,
                                               Estado = t.Detalle
                                           }).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return listaTipoPolizas;
        }

        public Mensaje ActualizarAjusteValorDeclarado(AjusteValorDeclaradoModalModelView ajusteValorDeclaradoModalModelView)
        {
            Mensaje mensaje = new Mensaje();
            mensaje.esError = false;
            try
            {
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        context.SP_U_AjustarValoresDeclarados(ajusteValorDeclaradoModalModelView.IdValorDeclaradoDetalleDisgregado,
                                                                ajusteValorDeclaradoModalModelView.CantidadAjustada,
                                                                ajusteValorDeclaradoModalModelView.ImporteAjustado);
                        context.SP_U_ValorDeclarado_CamposAjustados(ajusteValorDeclaradoModalModelView.IdValorDeclarado,
                                                                            ajusteValorDeclaradoModalModelView.IdValorDeclaradoDetalle,
                                                                            ajusteValorDeclaradoModalModelView.Afecta);

                        valorDeclaradoBL.ActualizarEstadoValorDeclarado(ajusteValorDeclaradoModalModelView.IdValorDeclarado, "AJUST");

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
                mensaje.mensaje = ex.InnerException != null ? ex.InnerException.Message : ex.Message;
                mensaje.esError = true;
            }
            
            return mensaje;
        }

    }
}
