using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static SiniestrosSeguros.DTO.ModelViews.Vehiculo;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Vehiculo
    {
        SegurosDBEntities context = new SegurosDBEntities();

        public int ObtenerIdVehiculoPorPlaca(string Placa, short IdEstado)
        {

            VehiculosModelView VH = null;

            try
            {
                VH = (from t in context.SP_S_Vehiculo(IdEstado).ToList()
                      where t.Placa == Placa
                      select new VehiculosModelView()
                      {
                          IdVehiculo = t.IdVehiculo
                      }).FirstOrDefault();
                if (VH == null)
                {
                    VH = new VehiculosModelView();
                }
            }
            catch (Exception ex)
            {
                VH = null;
                throw ex;
            }

            return VH.IdVehiculo;
        }

        public int CrearVehiculoModalView(VehiculosModelView VH)
        {
            int IdVehiculoRetorno = 0;
            SegurosDBEntities context = new SegurosDBEntities();

            ObjectParameter IdVehiculo = null;
            IdVehiculo = new ObjectParameter("IdVehiculo", typeof(Int32));
            IdVehiculo.Value = DBNull.Value;

            context.SP_I_Vehiculo(
                                  IdVehiculo,
                                  VH.IdEmpresa,
                                  VH.IdUnidadNegocio,
                                  VH.IdCentroCosto,
                                  VH.IdTipoVehiculo,
                                  VH.IdMarca,
                                  VH.IdModelo,
                                  VH.PlacaAnterior,
                                  VH.Placa,
                                  VH.SerieCarroceria,
                                  VH.SerieMotor,
                                  VH.Clase, //  especificado por funcional
                                  VH.AnoFabricado,
                                  VH.IdColor,
                                  VH.NroAsientos,
                                  VH.TimonCambiado,
                                  VH.IdMoneda,
                                  VH.ValorComercial,
                                   VH.IdEstado,
                                   VH.FechaInicio,
                                   VH.FechaFin);

            IdVehiculoRetorno = Convert.ToInt32(IdVehiculo.Value);

            return IdVehiculoRetorno;
        }

        public int ActualizarVehiculoModalView(VehiculosModelView VH)
        {
            int IdVehiculoRetorno = 0;
            SegurosDBEntities context = new SegurosDBEntities();

            IdVehiculoRetorno = context.SP_U_Vehiculo(
                                  VH.IdVehiculo,
                                  VH.IdEmpresa,
                                  VH.IdUnidadNegocio,
                                  VH.IdCentroCosto,
                                  VH.IdTipoVehiculo,
                                  VH.IdMarca,
                                  VH.IdModelo,
                                  VH.PlacaAnterior,
                                  VH.Placa,
                                  VH.SerieCarroceria,
                                  VH.SerieMotor,
                                  VH.Clase, // especificado funcional
                                  VH.AnoFabricado,
                                  VH.IdColor,
                                  VH.NroAsientos,
                                  VH.TimonCambiado,
                                  VH.IdMoneda,
                                  VH.ValorComercial,
                                  VH.IdEstado,
                                  VH.FechaInicio,
                                  VH.FechaFin
                                  );

            return IdVehiculoRetorno;
        }
    }
}
