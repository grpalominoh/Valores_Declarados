using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Area
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public bool ExisteIdArea(short IdArea, short IdEstado)
        {
            bool retorno = false;
            SiniestrosSeguros.DTO.ModelCustoms.Area.Areas C = null;
            C = (from e in context.SP_S_Area(IdEstado).ToList()
                 where e.IdArea == IdArea
                 select new SiniestrosSeguros.DTO.ModelCustoms.Area.Areas()
                 {
                     IdArea = e.IdArea
                 }).FirstOrDefault();

            if (C != null)
            {
                retorno = true;
            }

            return retorno;
        }

        public Dictionary<short, string> ObtenerAreas(short IdEstado)
        {
            Dictionary<short, string> AreaList = new Dictionary<short, string>();
            List<SiniestrosSeguros.DTO.ModelCustoms.Area.Areas> lista = null;
            try
            {
                lista = (from t in context.SP_S_Area(IdEstado).ToList()
                         select new SiniestrosSeguros.DTO.ModelCustoms.Area.Areas()
                         {
                             IdArea = t.IdArea,
                             Descripcion = t.Nombre

                         }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelCustoms.Area.Areas item in lista)
                {
                    AreaList.Add(item.IdArea, item.Descripcion);
                }
            }
            catch (Exception ex)
            {
                AreaList = null;
                throw ex;
            }
            return AreaList;
        }
    }
}
