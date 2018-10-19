using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static SiniestrosSeguros.DTO.ModelCustoms.Estado;

namespace SiniestrosSeguros.BL
{
    public class Estado
    {
        private int[] hardCodeEstados = new int[] { 106, 2, 24, 107, 6, 21, 3 };

        SegurosDBEntities context = new SegurosDBEntities();

        public List<Estados> ListaEstados()
        {
            List<Estados> lstEstados = null;

            try
            {
                lstEstados = (from e in context.SP_S_Estado().ToList()
                              where hardCodeEstados.Contains(e.IdRegistro)
                              select new Estados()
                              {
                                  IdEstado = e.IdRegistro,
                                  Detalle = e.Detalle
                              }).ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return lstEstados;
        }
    }
}
