using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class Reportes
    {
        public class RamoPolizaParamModelView
        {
            [Display(Name = "Ramo de Póliza")]
            public short IdConstante { get; set; }
            [Display(Name = "Empresa")]
            public string Empresa { get; set; }
            [Display(Name = "Fecha Inicio")]
            public DateTime FechaVigenciaIni { get; set; }
            [Display(Name = "Fecha Fin")]
            public DateTime FechaVigenciaFin { get; set; }
        }
    }
}
