using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class Constante
    {

        public class ConstanteComboView
        {
            public short IdConstante { get; set; }
            public string Constante { get; set; }
            public short? IdPadre { get; set; }
        }

    }
}
