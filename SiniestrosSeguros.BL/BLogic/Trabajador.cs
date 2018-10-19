using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Trabajador
    {
        SegurosDBEntities context = new SegurosDBEntities();

        //Mirar Aqui
        public int DevuelveIdTrabajadorPorIdPersona(int IdPersona, short IdEstado)
        {
            int retorno = 0;
            DTO.ModelViews.Trabajador.Trabajadores M = null;
            M = (from e in context.SP_S_trabajador(IdEstado).ToList()
                 where e.IdPersona == IdPersona
                 select new DTO.ModelViews.Trabajador.Trabajadores()
                 {
                     IdTrabajador = e.IdTrabajador
                 }).FirstOrDefault();

            if (M != null)
            {
                retorno = M.IdTrabajador;
            }

            return retorno;
        }
        public int BuscarTrabajadorPorPersona(int IdPersona, short IdEstado)
        {
            int retorno = 0;            
            var data = (context.SP_S_trabajador_POR_ID_PERSONA(IdPersona,IdEstado)).FirstOrDefault();
            if (data != null)            
                retorno = data.IdTrabajador;            

            return retorno;
        }
        public int ActuallizarTrabajadorModalView(DTO.ModelViews.Trabajador.Trabajadores Trabajador)
        {
            int IdTrabajadorRetorno = 0;
            SegurosDBEntities context = new SegurosDBEntities();
            short? ValorNull = null;
            ObjectParameter IdTrabajador = null;
            IdTrabajador = new ObjectParameter("IdTrabajador", typeof(Int32));
            IdTrabajador.Value = Trabajador.IdTrabajador;

            context.SP_U_TRABAJADOR(
                                  IdTrabajador,
                                  Trabajador.IdPersona,
                                  Trabajador.IdArea != 0 ? Trabajador.IdArea : ValorNull,
                                  null, //IdEmpresa
                                  null, //IdUnidadNegocio
                                  null,//
                                  Trabajador.EsPlanillado,
                                  Trabajador.IdCargo != 0 ? Trabajador.IdCargo : ValorNull,
                                  null, //IdClasificacionCargo
                                  null, //Mail
                                  null, //CodigoSap
                                  Trabajador.IdEstado,
                                  Trabajador.FechaIngreso.ToString());

            IdTrabajadorRetorno = Convert.ToInt32(IdTrabajador.Value);

            return IdTrabajadorRetorno;
        }
        public int CrearTrabajadorModalView(DTO.ModelViews.Trabajador.Trabajadores Trabajador)
        {
            int IdTrabajadorRetorno = 0;
            SegurosDBEntities context = new SegurosDBEntities();
            short? ValorNull = null;
            ObjectParameter IdTrabajador = null;
            IdTrabajador = new ObjectParameter("IdTrabajador", typeof(Int32));
            IdTrabajador.Value = DBNull.Value;

            context.SP_I_Trabajador(
                                  IdTrabajador,
                                  Trabajador.IdPersona,
                                  Trabajador.IdArea != 0 ? Trabajador.IdArea : ValorNull,
                                  null, //IdEmpresa
                                  null, //IdUnidadNegocio
                                  null,//
                                  Trabajador.EsPlanillado,
                                  Trabajador.IdCargo != 0 ? Trabajador.IdCargo : ValorNull,
                                  null, //IdClasificacionCargo
                                  null, //Mail
                                  null, //CodigoSap
                                  Trabajador.IdEstado,
                                  Trabajador.FechaIngreso.ToString());

            IdTrabajadorRetorno = Convert.ToInt32(IdTrabajador.Value);

            return IdTrabajadorRetorno;
        }
    }
}
