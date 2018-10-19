using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SiniestrosSeguros.DAO;
using static SiniestrosSeguros.DTO.ModelViews.Constantes;
using static SiniestrosSeguros.DTO.ModelCustoms.Constante;
using System.Data.Entity.Core.Objects;
using System.Data.Entity;
using SiniestrosSeguros.DTO;
using SiniestrosSeguros.DTO.ModelCustoms;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Constante
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public List<VerConstanteModelView> VerConstantes(short IdConstante = 0)
        {
            List<VerConstanteModelView> Const = null;

            try
            {
                Const = (from t in context.SP_S_Constante(IdConstante).ToList()
                         select new VerConstanteModelView()
                         {
                             IdConstante = t.IdConstante,
                             IdPadre = t.IdPadre,
                             Constante = t.Constante,
                             Descripcion = t.Descripcion,
                             CodigoAgrupador = t.CodigoAgrupador,
                             Orden = t.Orden,
                             Tag = t.Tag,
                             IdEstado = t.IdEstado ?? false,
                             ConstantePadre = t.Constante
                         }).OrderByDescending(x=>x.IdConstante).ToList();
            }
            catch (Exception ex)
            {
                Const = null;
                throw ex;
            }

            return Const;
        }

		public List<VerConstanteModelView> VerConstantesHijos(short IdPadre, string Constante)
        {
            List<VerConstanteModelView> Const = null;

            try
            {
                Const = (from t in context.SP_S_Constante_Hijo(IdPadre, Constante).ToList()
                         select new VerConstanteModelView()
                         {
                             IdConstante = t.IdConstante,
                             IdPadre = t.IdPadre,
                             Constante = t.Constante,
                             Descripcion = t.Descripcion,
                             CodigoAgrupador = t.CodigoAgrupador,
                             Orden = t.Orden,
                             Tag = t.Tag,
                             Estado = t.Detalle
                         }).OrderByDescending(x=>x.IdConstante).ToList();
            }
            catch (Exception ex)
            {
                Const = null;
                throw ex;
            }

            return Const;
        }

        public List<VerConstanteModelView> VerConstantes_Guardar(short IdConstante)
        {
            List<VerConstanteModelView> Const = null;

            try
            {
                Const = (from t in context.SP_S_Constante(IdConstante).ToList()
                         select new VerConstanteModelView()
                         {
                             IdConstante = t.IdConstante,
                             IdPadre = t.IdPadre == null ? IdConstante : t.IdPadre,
                             ConstantePadre = t.Constante,
                             Constante = "",
                             Descripcion = "",
                             CodigoAgrupador = t.CodigoAgrupador,
                             Orden = t.Orden,
                             Tag = "",
                             IdEstado = true
                         }).ToList();
            }
            catch (Exception ex)
            {
                Const = null;
                throw ex;
            }

            return Const;
        }

        public Mensaje CrearConstante(VerConstanteModelView Const)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                using (DbContextTransaction Transaccion = context.Database.BeginTransaction())
                {
                    try
                    {
                        context.SP_I_Constante(
                                Const.IdPadre,
                                Const.Constante,
                                Const.Descripcion,
                                Const.CodigoAgrupador,
                                Const.Orden,
                                Const.Tag,
                                Const.IdEstado
                            );

                        context.SaveChanges();
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

        public Mensaje EditarConstante(VerConstanteModelView Const)
        {
            Mensaje mensaje = new Mensaje();
            try
            {
                context.SP_U_Constante(
                        Const.IdConstante,
                        Const.Constante,
                        Const.Descripcion,
                        Const.Orden,
                        Const.Tag,
                        Const.IdEstado);
                mensaje.esError = false;
            }
            catch (Exception ex)
            {
                mensaje.esError = true;
                mensaje.mensaje = ex.Message;
            }

            return mensaje;
        }

        public List<ConstanteComboView> ListarDetalleConstante(string CodigoAgrupador)
        {
            List<ConstanteComboView> listaDetalle = null;
            try
            {
                listaDetalle = (from t in context.SP_S_Constante_PorCodigoAgrupador(CodigoAgrupador).ToList()
                                select new ConstanteComboView()
                                {
                                    IdConstante = t.IdConstante,
                                    Constante = t.Constante,
                                    IdPadre = t.IdPadre,
                                }).ToList();
            }
            catch (Exception ex)  //Yoski Ex
            {
                listaDetalle = null;
                throw ex;
            }

            return listaDetalle;
        }

        public bool ExisteTipoVehiculo(short IdConstante, short IdPadre, short IdEstado)
        {
            bool retorno = false;
            DTO.ModelViews.Constantes.CrearConstanteModelView C = null;
            C = (from e in context.SP_S_ConstantePorEstado(IdEstado).ToList()
                 where e.IdConstante == IdConstante && e.IdPadre == IdPadre
                 select new DTO.ModelViews.Constantes.CrearConstanteModelView()
                 {
                     Descripcion = e.Descripcion
                 }).FirstOrDefault();

            if (C != null)
            {
                retorno = true;
            }

            return retorno;
        }

        public bool ExisteIdConstantePorIdPadre(short IdConstante, short IdPadre, short IdEstado)
        {
            bool retorno = false;
            DTO.ModelViews.Constantes.CrearConstanteModelView C = null;
            C = (from e in context.SP_S_ConstantePorEstado(IdEstado).ToList()
                 where e.IdConstante == IdConstante && e.IdPadre == IdPadre
                 select new DTO.ModelViews.Constantes.CrearConstanteModelView()
                 {
                     Descripcion = e.Descripcion
                 }).FirstOrDefault();

            if (C != null)
            {
                retorno = true;
            }

            return retorno;
        }

        public Dictionary<short, string> ObtenerConstantesPorIdPadre(short IdPadre, short IdEstado)
        {
            Dictionary<short, string> CosntanteList = new Dictionary<short, string>();
            List<SiniestrosSeguros.DTO.ModelViews.Constantes.CrearConstanteModelView> C = null;
            try
            {
                C = (from t in context.SP_S_ConstantePorEstado(IdEstado).ToList()
                      where t.IdPadre == IdPadre
                      select new SiniestrosSeguros.DTO.ModelViews.Constantes.CrearConstanteModelView()
                      {
                          IdConstante = t.IdConstante,
                          Descripcion = t.Descripcion

                      }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelViews.Constantes.CrearConstanteModelView item in C)
                {
                    CosntanteList.Add(item.IdConstante, item.Descripcion);
                }
            }
            catch (Exception ex)
            {
                CosntanteList = null;
                throw ex;
            }
            return CosntanteList;
        }

    }
}
