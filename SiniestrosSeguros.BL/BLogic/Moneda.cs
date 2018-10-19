using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static SiniestrosSeguros.DTO.ModelCustoms.Moneda;

namespace SiniestrosSeguros.BL
{
    public class Moneda
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public List<Monedas> ListaMonedas()
        {
            List<Monedas> lstMonedas = null;

            try
            {
                lstMonedas = (from e in context.SP_S_Moneda().ToList()
                               select new Monedas()
                               {
                                   IdMoneda = e.IdMoneda,
                                   Moneda = e.Moneda
                               }).ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return lstMonedas;
        }

        public bool ExisteIdMoneda(short IdMoneda)
        {
            bool retorno = false;
            Monedas M = null;
            M = (from e in context.SP_S_Moneda().ToList()
                         where e.IdMoneda == IdMoneda
                         select new Monedas()
                         {
                             IdMoneda = e.IdMoneda,
                             Moneda = e.Moneda
                         }).FirstOrDefault();

            if (M != null)
            {
                retorno = true;
            }

            return retorno;
        }

        public Dictionary<int, string> ObtenerMoneda(short IdEstado)
        {
            Dictionary<int, string> MonedaList = new Dictionary<int, string>();
            List<SiniestrosSeguros.DTO.ModelCustoms.Moneda.Monedas> Moneda = null;
            try
            {
                Moneda = (from t in context.SP_S_Moneda().ToList()
                      select new SiniestrosSeguros.DTO.ModelCustoms.Moneda.Monedas()
                      {
                          IdMoneda = t.IdMoneda,
                          Moneda   = t.Moneda

                      }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelCustoms.Moneda.Monedas item in Moneda)
                {
                    MonedaList.Add(item.IdMoneda, item.Moneda);
                }
            }
            catch (Exception ex)
            {
                MonedaList = null;
                throw ex;
            }
            return MonedaList;
        }
    }
}
