using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class Trabajador
    {
        public class Trabajadores
        {
            public int IdTrabajador { get; set; }
            public int IdPersona { get; set; }
            public DateTime FechaIngreso { get; set; }
            public short IdArea { get; set; }
            public short IdCargo { get; set; }
            public short IdEmpresa { get; set; }
            public short IdEstado { get; set; }
            public short IdCentroServicio { get; set; }
            public short IdUnidadNegocio{ get; set; }
            public short EsPlanillado { get; set; }
            public short IdClasificacionCargo { get; set; }
            public string Mail { get; set; }
            public string CodigoSap { get; set; }


        }
    }
}
