using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class Reportes
    {

        public class Patrimonial
        {
            public int? IdTipoPoliza { get; set; }
            public string TipoPoliza { get; set; }
            public short? IdEmpresa { get; set; }
            public string Empresa { get; set; }
            public short? IdTipoValorDeclarado { get; set; }
            public string TipoValorDeclarado { get; set; }
            public decimal? Importe { get; set; }
            public decimal? valorTipoCambio { get; set; }
        }

        public class Personal
        {
            public string Empresa { get; set; }
            public short? NumTrabajadores { get; set; }
            public decimal? MontoTrabajadores { get; set; }
            public short? NumPracticantes { get; set; }
            public decimal? MontoPracticantes { get; set; }
        }

        public class Vehiculo
        {
            public string Empresa { get; set; }
            public short? NumVehiculo { get; set; }
            public decimal? MontoAsegurado { get; set; }
            public decimal? TipoCambio { get; set; }
        }

        public class DetalleVehiculo
        {
            public string Descripcion { get; set; }
            public short? Cantidad { get; set; }
            public decimal? MontoAsegurado { get; set; }
            public decimal? valorTipoCambio { get; set; }
        }

        public class EmpresaTipoImporte
        {
            public short? IdEmpresa { get; set; }
            public short? IdTipoValorDeclarado { get; set; }
            public decimal? Monto { get; set; }
            public string empresa { get; set; }
        }

    }
}
