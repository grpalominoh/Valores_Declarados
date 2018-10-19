using SiniestrosSeguros.DAO;
using SiniestrosSeguros.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.BL.BLogic
{
    public class UnidadNegocio
    {
        SegurosDBEntities context = new SegurosDBEntities();
        bool retorno;
        public bool ExisteIdUnidadNegocio(short IdUnidadNegocio, short IdEstado)
        {

            SiniestrosSeguros.DTO.ModelViews.UnidadNegocio UN = null;

            try
            {
                UN = (from t in context.SP_S_UnidadNegocio(IdEstado).ToList()
                      where t.IdUnidadNegocio == IdUnidadNegocio
                      select new SiniestrosSeguros.DTO.ModelViews.UnidadNegocio()
                      {
                          IdUnidadNegocio = t.IdUnidadNegocio
                      }).FirstOrDefault();

                if (UN != null)
                {
                    retorno = true;
                }
            }
            catch (Exception ex)
            {
                UN = null;
                throw ex;
            }

            return retorno;
        }

        public short ObtenerIdEmpresaPorUnidadNegocio(short IdUnidadNegocio, short IdEstado)
        {

            SiniestrosSeguros.DTO.ModelViews.UnidadNegocio UN = null;

            try
            {
                UN = (from t in context.SP_S_UnidadNegocio(IdEstado).ToList()
                           where t.IdUnidadNegocio == IdUnidadNegocio
                           select new SiniestrosSeguros.DTO.ModelViews.UnidadNegocio()
                           {
                               IdEmpresa = t.IdEmpresa
                           }).FirstOrDefault();
            }
            catch (Exception ex)
            {
                UN = null;
                throw ex;
            }

            return UN.IdEmpresa;
        }

        public Dictionary<int, short> ObtenerUnidadNegocio(short IdEstado)
        {
            Dictionary<int, short> UNList = new Dictionary<int, short>();
            List<SiniestrosSeguros.DTO.ModelViews.UnidadNegocio> UN = null;
            try
            {
                UN = (from t in context.SP_S_UnidadNegocio(IdEstado).ToList()                      
                      select new SiniestrosSeguros.DTO.ModelViews.UnidadNegocio()
                      {
                          IdEmpresa = t.IdEmpresa,
                          IdUnidadNegocio = t.IdUnidadNegocio,
                          Nombre = t.Nombre

                      }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelViews.UnidadNegocio item in UN)
                {
                    UNList.Add(item.IdUnidadNegocio, item.IdEmpresa);
                }
            }
            catch (Exception ex)
            {
                UN = null;
                throw ex;
            }
            return UNList;
        }
    }
}
