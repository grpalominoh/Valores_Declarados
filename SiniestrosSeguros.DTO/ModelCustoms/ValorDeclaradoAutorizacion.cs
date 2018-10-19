using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class ValorDeclaradoAutorizacion
    {
        public int? IdValorDeclaradoAutorizacion { get; set; }
        public int? IdValorDeclarado { get; set; }
        public short? IdArea { get; set; }
        public short? IdCargo { get; set; }
        public int? IdTrabajador { get; set; }
        public short? OrdenAutoriza { get; set; }

    }
}
