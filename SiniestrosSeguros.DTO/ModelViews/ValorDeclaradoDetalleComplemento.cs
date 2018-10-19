using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class ValorDeclaradoDetalleComplementoModalView
    {
        public int IdValorDeclaradoDetalleComplemento { get; set; }
        public int IdValorDeclaradoDetalle { get; set; }
        public short IdTipoBien { get; set; }
        public int IdElementoElectrico { get; set; }
        public string NroPlaca { get; set; }
        public int IdTrabajador { get; set; }
        public int IdVehiculo { get; set; }
        public int IdInstalacion { get; set; }
        public short IdCentroCosto { get; set; }
        public short IdArea { get; set; }
        public short IdCargo { get; set; }
        public short IdUUNN { get; set; }
        public short IdTipoPlanilla { get; set; }
        public short IdNivelRiesgo { get; set; }
        public decimal ValorDeclarado { get; set; }
        public decimal ImporteMensual { get; set; }
        public decimal ImporteGratificacion { get; set; }
        public short IdEstado { get; set; }
        public string NombreOrigen { get; set; }
        public string NombreAsignado { get; set; }
        public string Ruta { get; set; }
    }
}
