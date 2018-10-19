using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class Persona
    {
        public class Personas
        {
            public int IdPersona { get; set; }
            public string ApellidoPaterno { get; set; }
            public string ApellidoMaterno { get; set; }
            public string Nombre { get; set; }
            public string NroIdentidad { get; set; }
            public short IdEstado { get; set; }
            public string FechaNacimiento { get; set; }
        }
    }
}
