using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class ValorDeclaradoDetalle
    {
        public class BusquedaValorDeclaradoDetalleModelView
        {
            public int IdValorDeclaradoDetalle { get; set; }

            public int IdValorDeclarado { get; set; }

            public short IdTipoValorDeclarado { get; set; }

            public short IdMoneda { get; set; }

            public float ImporteValorDeclarado { get; set; }

            public float ImporteAjustado { get; set; }

            public short IdUnidadMedida { get; set; }

            public float Cantidad { get; set; }

            public float CantidadAjustada { get; set; }

            public DateTime FechaRegistro { get; set; }

            public short IdTipoRegistro { get; set; }

            public int IdPolizaEndoso { get; set; }

            public string Descripcion { get; set; }

            public short IdEstado { get; set; }

        }
    }
}
