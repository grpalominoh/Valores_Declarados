using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Modelo
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public bool ExisteIdModelo(int IdModelo, short IdEstado)
        {
            bool retorno = false;
            DTO.ModelViews.Modelo.Modelos M = null;
            M = (from e in context.SP_S_Modelo(IdEstado).ToList()
                 where e.IdModelo == IdModelo
                 select new DTO.ModelViews.Modelo.Modelos()
                 {
                     IdModelo = e.IdModelo
                 }).FirstOrDefault();

            if (M != null)
            {
                retorno = true;
            }

            return retorno;
        }

        public Dictionary<int, string> ObtenerModelo(short IdEstado)
        {
            Dictionary<int, string> ModeloList = new Dictionary<int, string>();
            List<SiniestrosSeguros.DTO.ModelViews.Modelo.Modelos> M = null;
            try
            {
                M = (from t in context.SP_S_Modelo(IdEstado).ToList()
                      select new SiniestrosSeguros.DTO.ModelViews.Modelo.Modelos()
                      {
                          IdModelo  = t.IdModelo,
                          Descripcion = t.Descripcion

                      }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelViews.Modelo.Modelos item in M)
                {
                    ModeloList.Add(item.IdModelo, item.Descripcion);
                }
            }
            catch (Exception ex)
            {
                M = null;
                throw ex;
            }
            return ModeloList;
        }
    }
    
}
