using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class TipoPoliza
    {
        public class TipoPolizaParamsModalView
        {
            public short IdTipoPoliza { get; set; }
            public string DescripcionRamoPoliza { get; set; }
            public short IdDivisionPoliza { get; set; }
        }

        public class TipoPolizaComboView
        {
            public short IdDivisionPoliza { get; set; }
            public string Descripcion { get; set; }
        }

    }
}
