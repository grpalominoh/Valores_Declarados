using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Persona
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public List<DTO.SP_S_Persona_Result> listarPersonaEstados(short IdEstado)
        {
            return context.SP_S_Persona(IdEstado).ToList();
        }
        public int devuelveIdPersonaPorDNI(string DNI, short IdEstado, List<DTO.SP_S_Persona_Result> personas)
        {
            int retorno = 0;
            DTO.ModelViews.Persona.Personas M = null;
            M = (from e in personas
                 where e.NroIdentidad != null && e.NroIdentidad.Equals(DNI.Trim())
                 select new DTO.ModelViews.Persona.Personas()
                 {
                     Nombre = e.Nombres,
                     IdPersona = e.IdPersona
                 }).FirstOrDefault();

            if (M != null)
            {
                retorno = M.IdPersona;
            }

            return retorno;
        }
        public int devuelveIdPersonaPorDNI(string DNI, short IdEstado)
        {
            int retorno = 0;

            var data = context.SP_S_BUSCAR_PERSONA_POR_ESTADO_Y_DNI(IdEstado, DNI).FirstOrDefault();
            if (data != null)
                retorno = data.IdPersona;
            return retorno;
        }
        public int ActualizarPersonaModalView(DTO.ModelViews.Persona.Personas Persona)
        {
            int IdTrabajadorRetorno = 0;
            SegurosDBEntities context = new SegurosDBEntities();

            ObjectParameter IdPersona = null;
            IdPersona = new ObjectParameter("IdPersona", typeof(Int32));
            IdPersona.Value = Persona.IdPersona;

            context.SP_U_PERSONA(
                                  IdPersona,
                                  Persona.Nombre,
                                  Persona.ApellidoPaterno,
                                  Persona.ApellidoMaterno,
                                  Persona.ApellidoPaterno + " " + Persona.ApellidoMaterno,
                                  1,//dni
                                  Persona.NroIdentidad,
                                  Persona.IdEstado);

            IdTrabajadorRetorno = Convert.ToInt32(IdPersona.Value);

            return IdTrabajadorRetorno;

        }
        public int CrearPersonaModalView(DTO.ModelViews.Persona.Personas Persona)
        {
            int IdTrabajadorRetorno = 0;
            SegurosDBEntities context = new SegurosDBEntities();

            ObjectParameter IdPersona = null;
            IdPersona = new ObjectParameter("IdPersona", typeof(Int32));
            IdPersona.Value = DBNull.Value;

            context.SP_I_Persona(
                                  IdPersona,
                                  Persona.Nombre,
                                  Persona.ApellidoPaterno,
                                  Persona.ApellidoMaterno,
                                  Persona.ApellidoPaterno + " " + Persona.ApellidoMaterno,
                                  1,//dni
                                  Persona.NroIdentidad,
                                  Persona.IdEstado);

            IdTrabajadorRetorno = Convert.ToInt32(IdPersona.Value);

            return IdTrabajadorRetorno;
        }

        public Dictionary<string, int> ObtenerPersona(short IdEstado)
        {
            Dictionary<string, int> PersonaList = new Dictionary<string, int>();
            List<SiniestrosSeguros.DTO.ModelViews.Persona.Personas> lista = null;
            try
            {
                lista = (from t in context.SP_S_Persona(IdEstado).ToList()
                         select new SiniestrosSeguros.DTO.ModelViews.Persona.Personas()
                         {
                             IdPersona = t.IdPersona,
                             NroIdentidad = t.NroIdentidad


                         }).ToList();
                foreach (SiniestrosSeguros.DTO.ModelViews.Persona.Personas item in lista)
                {
                    PersonaList.Add(item.NroIdentidad, item.IdPersona);
                }
            }
            catch (Exception ex)
            {
                PersonaList = null;
                throw ex;
            }
            return PersonaList;
        }
    }
}
