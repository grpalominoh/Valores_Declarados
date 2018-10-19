using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class Vehiculo
    {
        public class VehiculosModelView
        {
            public int IdVehiculo { get; set; }
            public short IdEmpresa { get; set; }
            public short IdUnidadNegocio { get; set; }
            public short IdCentroCosto { get; set; }
            public short IdTipoVehiculo { get; set; }
            public short IdMarca { get; set; }
            public int IdModelo { get; set; }
            public string PlacaAnterior { get; set; }
            public string Placa { get; set; }
            public string SerieCarroceria { get; set; }
            public string SerieMotor { get; set; }
            public string Clase { get; set; }
            public short AnoFabricado { get; set; }
            public short IdColor { get; set; }
            public short NroAsientos { get; set; }
            public short TimonCambiado { get; set; }
            public short IdMoneda { get; set; }
            public decimal ValorComercial { get; set; }
            public short IdEstado { get; set; }
            public DateTime FechaInicio { get; set; }
            public DateTime FechaFin { get; set; }
        }
    }
}
