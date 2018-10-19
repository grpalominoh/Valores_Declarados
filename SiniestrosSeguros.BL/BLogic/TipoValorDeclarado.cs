using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SiniestrosSeguros.DTO.ModelViews;
using SiniestrosSeguros.DAO;
using static SiniestrosSeguros.DTO.ModelViews.TiposValoresDeclarados;
using System.Data.Entity.Core.Objects;
using System.Data.Entity;
using SiniestrosSeguros.DTO;
using static SiniestrosSeguros.DTO.ModelCustoms.TipoValorDeclarado;
using SiniestrosSeguros.DTO.ModelCustoms;
using System.Threading;

namespace SiniestrosSeguros.BL
{
    public class TipoValorDeclarado
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public Mensaje CrearTipoValorDeclarado(CrearTipoValorDeclaradoModelView TVD)
        {
            Mensaje mensaje = new Mensaje();
            short Activo = 1;
            short Inactivo = 0;
            ObjectParameter IdTipoValorDeclarado = null;
            IdTipoValorDeclarado = new ObjectParameter("IdTipoValorDeclarado", typeof(Int32));
            IdTipoValorDeclarado.Value = DBNull.Value;
            try
            {
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        context.SP_I_TipoValorDeclarado(
                       IdTipoValorDeclarado,
                       TVD.Nombre,
                       TVD.Descripcion,
                       TVD.AfectaImporte ? Activo : Inactivo,
                       TVD.AfectaCantidad ? Activo : Inactivo,
                       TVD.PermiteCargaDetalle ? Activo : Inactivo,
                       Activo);

                        context.SaveChanges();
                        //Thread.Sleep(10000);
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
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return mensaje;
        }

        public Mensaje EditarTipoValorDeclarado(VerTipoValorDeclaradoModelView TVD)
        {
            Mensaje mensaje = new Mensaje();
            short Activo = 1;
            short Inactivo = 0;
            try
            {
                context.SP_U_TipoValorDeclarado(
                        TVD.IdTipoValorDeclarado,
                        TVD.Nombre,
                        TVD.Descripcion,
                        TVD.AfectaImporte ? Activo : Inactivo,
                        TVD.AfectaCantidad ? Activo : Inactivo,
                        TVD.PermiteCargaDetalle ? Activo : Inactivo,
                        TVD.IdEstado ? Activo : Inactivo);
                mensaje.esError = false;
            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }
            return mensaje;
        }

        public VerTipoValorDeclaradoModelView VerTipoValorDeclaradoPorIdTipoValorDeclarado(int IdTipoValorDeclarado)
        {
            SP_S_TipoValorDeclarado_PorIdTipoValorDeclarado_Result response = null;
            VerTipoValorDeclaradoModelView TVD = null;
            short Activo = 1;
            try
            {
                response = context.SP_S_TipoValorDeclarado_PorIdTipoValorDeclarado(IdTipoValorDeclarado).FirstOrDefault();

                TVD = new VerTipoValorDeclaradoModelView();
                TVD.IdTipoValorDeclarado = response.IdTipoValorDeclarado;
                TVD.Nombre = response.Nombre;
                TVD.Descripcion = response.Descripcion;
                TVD.AfectaCantidad = response.AfectaCantidad == Activo ? true : false;
                TVD.AfectaImporte = response.AfectaImporte == Activo ? true : false;
                TVD.PermiteCargaDetalle = response.PermiteCargaDetalle == Activo ? true : false;
                TVD.IdEstado = response.IdEstado == 1 ? true : false;
                TVD.Estado = response.EstadoNombre;
            }
            catch (Exception ex)
            {
                TVD = null;
                throw ex;
            }

            return TVD;
        }

        public VerTipoValorDeclaradoModelView VerTipoValorDeclaradoPorIdEstado(int IdEstado)
        {
            SP_S_TipoValorDeclarado_PorIdEstado_Result response = null;
            VerTipoValorDeclaradoModelView TVD = null;
            short Activo = 1;
            try
            {
                response = context.SP_S_TipoValorDeclarado_PorIdEstado(IdEstado).FirstOrDefault();

                TVD = new VerTipoValorDeclaradoModelView();
                TVD.IdTipoValorDeclarado = response.IdTipoValorDeclarado;
                TVD.Nombre = response.Nombre;
                TVD.Descripcion = response.Descripcion;
                TVD.AfectaCantidad = response.AfectaCantidad == Activo ? true : false;
                TVD.AfectaImporte = response.AfectaImporte == Activo ? true : false;
                TVD.PermiteCargaDetalle = response.PermiteCargaDetalle == Activo ? true : false;
                TVD.IdEstado = response.IdEstado == 1 ? true : false;
                TVD.Estado = response.EstadoNombre;
            }
            catch (Exception ex)
            {
                TVD = null;
                throw ex;
            }

            return TVD;
        }

        public List<VerTipoValorDeclaradoModelView> VerTiposValoresDeclarados()
        {
            List<VerTipoValorDeclaradoModelView> TVD = null;
            short Activo = 1;
            try
            {
                TVD = (from t in context.SP_S_TipoValorDeclarado().ToList()
                       select new VerTipoValorDeclaradoModelView()
                       {
                           IdTipoValorDeclarado = t.IdTipoValorDeclarado,
                           Nombre = t.Nombre,
                           Descripcion = t.Descripcion,
                           AfectaCantidad = t.AfectaCantidad == Activo ? true : false,
                           AfectaImporte = t.AfectaImporte == Activo ? true : false,
                           PermiteCargaDetalle = t.PermiteCargaDetalle == Activo ? true : false,
                           //IdEstado = t.IdEstado == 1 ? true : false,
                           Estado = t.EstadoNombre
                       }).OrderByDescending(x => x.IdTipoValorDeclarado).ToList();
            }
            catch (Exception ex)
            {
                TVD = null;
                throw ex;
            }

            return TVD;
        }

        public List<TipoValorDeclaradoComboView> ListaTipoValoresDeclarados()
        {
            List<TipoValorDeclaradoComboView> lstTipoValoresDeclarados = null;
            short Activo = 1;
            try
            {
                lstTipoValoresDeclarados = (from e in context.SP_S_TipoValorDeclarado().ToList()

                                            where e.IdEstado == Activo
                                            select new TipoValorDeclaradoComboView()
                                            {
                                                IdTipoValorDeclarado = e.IdTipoValorDeclarado,
                                                Nombre = e.Nombre,
                                                AfectaCantidad = e.AfectaCantidad
                                            }).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstTipoValoresDeclarados;
        }

        public List<TipoValorDeclaradoComboView> ListaTipoValoresDeclaradosDesdeValorDeclaradoDetalle(int IdValorDeclarado)
        {
            List<TipoValorDeclaradoComboView> lstTipoValoresDeclarados = null;

            try
            {
                lstTipoValoresDeclarados = (from e in context.SP_S_TipoValorDeclarado_PorValorDeclarado(IdValorDeclarado).ToList()
                                            select new TipoValorDeclaradoComboView()
                                            {
                                                IdTipoValorDeclarado = e.IdTipoValorDeclarado,
                                                Nombre = e.Nombre
                                            }).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstTipoValoresDeclarados;
        }

        public int? GetCountExistsTipoValorDeclaradoInValorDeclarado(short IdTipoValorDeclarado)
        {
            int? response;
            try
            {
                response = context.SP_S_DevuelveValorDeclarado_PorTipoValorDeclarado(IdTipoValorDeclarado).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return response;
        }

        public TiposValoresDeclarados.CrearTipoValorDeclaradoModelView DevuelveFlagsPorIdTipoValorDeclarado(short IdTipoValorDeclarado)
        {
            TiposValoresDeclarados.CrearTipoValorDeclaradoModelView lstTipoValoresDeclarados = null;
            try
            {
                lstTipoValoresDeclarados = (from e in context.SP_S_TipoValorDeclarado().ToList()
                                            where e.IdTipoValorDeclarado == IdTipoValorDeclarado
                                            select new TiposValoresDeclarados.CrearTipoValorDeclaradoModelView()
                                            {
                                                IdTipoValorDeclarado = e.IdTipoValorDeclarado,
                                                PermiteCargaDetalle = e.PermiteCargaDetalle == 1 ? true : false,
                                                AfectaImporte = e.AfectaImporte == 1 ? true : false,
                                                AfectaCantidad = e.AfectaCantidad == 1 ? true : false
                                            }).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstTipoValoresDeclarados;
        }

    }

}
