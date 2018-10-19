using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Marca
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public bool ExisteIdMarca(short IdMarca, short IdEstado)
        {
            bool retorno = false;
            DTO.ModelViews.Marca.Marcas M = null;
            M = (from e in context.SP_S_Marca(IdEstado).ToList()
                 where e.IdMarca == IdMarca
                 select new DTO.ModelViews.Marca.Marcas()
                 {
                     IdMarca = e.IdMarca
                 }).FirstOrDefault();

            if (M != null)
            {
                retorno = true;
            }

            return retorno;
        }

        public Dictionary<short, string> ObtenerMarca(short IdEstado)
        {
            Dictionary<short, string> MarcaList = new Dictionary<short, string>();
            List<SiniestrosSeguros.DTO.ModelViews.Marca.Marcas> lista = null;
            try
            {
                lista = (from t in context.SP_S_Marca(IdEstado).ToList()
                      select new SiniestrosSeguros.DTO.ModelViews.Marca.Marcas()
                      {
                          IdMarca     = t.IdMarca,
                          Descripcion = t.Descripcion

                      }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelViews.Marca.Marcas item in lista)
                {
                    MarcaList.Add(item.IdMarca, item.Descripcion);
                }
            }
            catch (Exception ex)
            {
                MarcaList = null;
                throw ex;
            }
            return MarcaList;
        }
    }
}
