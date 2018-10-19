using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SiniestrosSeguros.DAO;
using SiniestrosSeguros.DTO.ModelCustoms;
using static SiniestrosSeguros.DTO.ModelViews.TipoPoliza;

namespace SiniestrosSeguros.BL.BLogic
{
    public class TipoPoliza
    {

        SegurosDBEntities context = new SegurosDBEntities();

        public List<TablaTipoPolizaModelView> ListarTiposPolizaPorRamoPoliza(short IdTipoPoliza)
        {
            List<TablaTipoPolizaModelView> listaTipoPoliza = null;

            try
            {
                listaTipoPoliza = (from t in context.SP_S_DivisionPoliza_PorTipoPoliza(IdTipoPoliza).ToList()
                                   select new TablaTipoPolizaModelView()
                                   {
                                       IdDivisionPoliza = t.IdDivisionPoliza,
                                       Descripcion = t.Descripcion,
                                       Abreviatura = t.Abreviatura,
                                       AplicaProveedor = (t.AplicaProveedor == 0 ? "NO" : "SI"),
                                       IdEstado = Convert.ToBoolean(t.IdEstado),
                                       Estado = t.Detalle
                                   }).OrderByDescending(x=>x.IdDivisionPoliza).ToList();
            }
            catch (Exception ex)
            {
                listaTipoPoliza = null;
                throw ex;
            }

            return listaTipoPoliza;
        }

        public Mensaje CrearTiposPolizaPorRamoPoliza(SiniestrosSeguros.DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView modalTipoPolizaModelView)
        {
             
            Mensaje mensaje = new Mensaje();
            using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
            {
                short Activo = 1;
                try
                {
                    context.SP_I_DivisionPoliza(modalTipoPolizaModelView.IdTipoPoliza,
                                            modalTipoPolizaModelView.Descripcion,
                                            modalTipoPolizaModelView.Abreviatura,
                                            modalTipoPolizaModelView.AplicaProveedor,
                                            Activo
                                            );

                    context.SaveChanges();
                    Transaccion.Commit();
                    mensaje.esError = false;
                }
                catch (Exception ex)
                {
                    mensaje.mensaje = ex.Message;
                    mensaje.esError = true;
                    Transaccion.Rollback();
                }
            }
            return mensaje;
        }

        public ModalTipoPolizaModelView ObtenerTipoPoliza(DTO.ModelCustoms.TipoPoliza.TipoPolizaParamsModalView paramsModalView)
        {
            ModalTipoPolizaModelView result = null;

            using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
            {
                try
                {
                    result = (from t in context.SP_S_DivisionPoliza_PorTipoPoliza(paramsModalView.IdTipoPoliza).ToList()
                              where t.IdDivisionPoliza == paramsModalView.IdDivisionPoliza
                                       select new ModalTipoPolizaModelView()
                                       {
                                           IdDivisionPoliza = t.IdDivisionPoliza,
                                           Descripcion = t.Descripcion,
                                           Abreviatura = t.Abreviatura,
                                           AplicaProveedor = (t.AplicaProveedor == 0 ? false : true),
                                           IdEstado = (t.IdEstado == 0 ? false : true),
                                       }
                             ).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    result = null;
                    throw ex;
                }
            }

            return result;
        }

        public Mensaje ActualizarTipoPoliza(DTO.ModelViews.TipoPoliza.ModalTipoPolizaModelView modalTipoPolizaModelView)
        {
            Mensaje mensaje = new Mensaje();
            using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
            {
                short estado;
                if (modalTipoPolizaModelView.IdEstado)
                    estado = 1;
                else
                    estado = 0;

                try
                {
                    context.SP_U_TipoPoliza(modalTipoPolizaModelView.IdDivisionPoliza,
                                                    modalTipoPolizaModelView.Descripcion,
                                                    modalTipoPolizaModelView.Abreviatura,
                                                    modalTipoPolizaModelView.AplicaProveedor,
                                                    estado);
                    context.SaveChanges();
                    Transaccion.Commit();
                    mensaje.esError = false;
                }
                catch (Exception ex)
                {
                    mensaje.mensaje = ex.Message;
                    mensaje.esError = true;
                    Transaccion.Rollback();
                }
            }

            return mensaje;
        }


    }
}
