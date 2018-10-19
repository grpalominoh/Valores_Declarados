using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class Disgrega
    {
        public class DisgregaParamsModalView
        {
            public int IdValorDeclarado { get; set; }
            public string DescEmpresa { get; set; }
            public string IdMoneda { get; set; }
            public string DescMoneda { get; set; }
            public string DescEstado { get; set; }
            public string NombreCortoEmpresa { get; set; }
            public int edit { get; set; }
        }

        public class InfoValorDeclaradoDetalleModalView
        {
            public int IdValorDeclaradoDetalle { get; set; }
            public short? IdUnidadMedida { get; set; }
            public string UnidadMedida { get; set; }
            public decimal? Cantidad { get; set; }
            public decimal? ImporteValorDeclarado { get; set; }
            public short AfectaImporte { get; set; }
            public short AfectaCantidad { get; set; }
        }

    }
}
