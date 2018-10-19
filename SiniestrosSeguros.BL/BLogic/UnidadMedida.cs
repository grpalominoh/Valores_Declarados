using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static SiniestrosSeguros.DTO.ModelCustoms.UnidadMedida;

namespace SiniestrosSeguros.BL
{
    public class UnidadMedida
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public List<UnidadMedidas> ListaUnidadMedidas()
        {
            List<UnidadMedidas> lstUnidadMedidas = null;

            try
            {
                lstUnidadMedidas = (from e in context.SP_S_Unidad_Medida().ToList()
                               select new UnidadMedidas()
                               {
                                   IdUnidadMedida = e.IdUnidadMedida,
                                   Nombre = e.Nombre
                               }).ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return lstUnidadMedidas;
        }
    }
}
