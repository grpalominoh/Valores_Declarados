using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class TipoValorDeclarado
    {

        public class TipoValorDeclaradoComboView
        {
            public short IdTipoValorDeclarado { get; set; }
            public string Nombre { get; set; }
            public short AfectaCantidad { get; set; }
        }

    }
}
