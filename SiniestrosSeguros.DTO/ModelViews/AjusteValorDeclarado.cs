using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class AjusteValorDeclarado
    {
        public class AjusteValorDeclaradoModalModelView
        {
            public int IdValorDeclaradoDetalleDisgregado { get; set; }
            public string Afecta { get; set; }
            public int IdValorDeclarado { get; set; }
            public int IdValorDeclaradoDetalle { get; set; }
            public string TipoPoliza { get; set; }
            public string RamoPoliza { get; set; }
            public decimal? ImporteAjustado { get; set; }
            public decimal? CantidadAjustada { get; set; }
        }
    }
}
