using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SiniestrosSeguros.DTO.ModelViews;

namespace SiniestrosSeguros.BL.BLogic
{
    public class CentroCosto
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public int ObtenerIdCentroCostoPorCodigo(string Codigo, short IdEstado)
        {

            DTO.ModelViews.CentroCosto.CentroCostos CC = null;

            try
            {
                CC = (from t in context.SP_S_CentroCosto(IdEstado).ToList()
                      where t.Codigo == Codigo
                      select new DTO.ModelViews.CentroCosto.CentroCostos()
                      {
                          IdCentroCosto = t.IdCentroCosto
                      }).FirstOrDefault();
            }
            catch (Exception ex)
            {
                CC = null;
                throw ex;
            }

            return CC.IdCentroCosto;
        }

        public Dictionary<string, int> ObtenerCentroCosto(short IdEstado)
        {
            Dictionary<string, int> CentroCostoList = new Dictionary<string, int>();
            List<SiniestrosSeguros.DTO.ModelViews.CentroCosto.CentroCostos> lista = null;
            try
            {
                lista = (from t in context.SP_S_CentroCosto(IdEstado).ToList()
                         select new SiniestrosSeguros.DTO.ModelViews.CentroCosto.CentroCostos()
                         {
                             IdCentroCosto = t.IdCentroCosto,
                             Codigo = t.Codigo.Trim()


                         }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelViews.CentroCosto.CentroCostos item in lista)
                {
                    CentroCostoList.Add(item.Codigo, item.IdCentroCosto);
                }
            }
            catch (Exception ex)
            {
                CentroCostoList = null;
                throw ex;
            }
            return CentroCostoList;
        }
    }
}
