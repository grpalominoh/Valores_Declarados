using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SiniestrosSeguros.Web.ViewModel
{
    public class DataTableRequest
    {
        public int draw { get; set; }
        public Dictionary<string, string>[] order { get; set; }
        public int start { get; set; }
        public int length { get; set; }
        public Dictionary<string, string> search { get; set; }
        public short IdEmpresa { get; set; }
        public string FechaVigenciaIni { get; set; }
        public string FechaVigenciaFin { get; set; }
        public short IdEstado { get; set; }
    }
}