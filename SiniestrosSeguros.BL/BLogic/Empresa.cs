using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SiniestrosSeguros.DAO;
using static SiniestrosSeguros.DTO.ModelCustoms.Empresa;

namespace SiniestrosSeguros.BL
{
    public class Empresa
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public List<Empresas> ListaEmpresas()
        {
            List<Empresas> lstEmpresas = null;

            try
            {
                lstEmpresas = (from e in context.SP_S_Empresa().ToList()
                              select new Empresas()
                              {
                                  IdEmpresa      = e.IdEmpresa,
                                    NombreCorto  = e.NombreCorto
                              }).ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return lstEmpresas;
        }
    }
}

