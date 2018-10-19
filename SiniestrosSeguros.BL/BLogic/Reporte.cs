using SiniestrosSeguros.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static SiniestrosSeguros.DTO.ModelCustoms.Reportes;

namespace SiniestrosSeguros.BL.BLogic
{
    public class Reporte
    {

        SegurosDBEntities context = new SegurosDBEntities();

        public List<Patrimonial> ObtenerInfoPatrimonial(short IdTipoPoliza, short? idEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            List<Patrimonial> lista = null;
            try
            {
                lista = (from t in context.SP_S_ReportePatrimonial(IdTipoPoliza, idEmpresa, fechaInicio, fechaFin).ToList()
                         select new Patrimonial()
                         {
                             IdTipoPoliza = t.IdDivisionPoliza,
                             TipoPoliza = t.Descripcion,
                             IdEmpresa = t.IdEmpresa,
                             Empresa = t.NombreCorto,
                             IdTipoValorDeclarado = t.IdTipoValorDeclarado,
                             TipoValorDeclarado = t.Nombre,
                             Importe = t.Importe
                         }).ToList();
            }
            catch (Exception ex)
            {
                lista = null;
                throw ex;
            }

            return lista;
        }

        public List<DTO.ModelCustoms.Reportes.Vehiculo> ObtenerInfoVehiculo(short IdTipoPoliza, short? idEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            List<DTO.ModelCustoms.Reportes.Vehiculo> lista = null;
            short valorDefecto = 0;
            try
            {
                lista = (from t in context.SP_S_ReporteVehiculo(IdTipoPoliza, idEmpresa, fechaInicio, fechaFin).ToList()
                         select new DTO.ModelCustoms.Reportes.Vehiculo()
                         {
                             Empresa = t.NombreCorto,
                             NumVehiculo = t.Cantidad == null ? valorDefecto : (short)t.Cantidad,
                             MontoAsegurado = t.Importe
                         }).ToList();
            }
            catch (Exception ex)
            {
                lista = null;
                throw ex;
            }

            return lista;
        }

        public List<Personal> ObtenerInfoPersonal(short IdTipoPoliza, short? idEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            List<Personal> lista = null;
            short valorDefecto = 0;
            try
            {
                lista = (from t in context.SP_S_ReportePersonal(IdTipoPoliza, idEmpresa, fechaInicio, fechaFin).ToList()
                         select new Personal()
                         {
                             Empresa = t.Empresa,
                             NumTrabajadores = t.CantidadTrabajadores == null ? valorDefecto : (short)t.CantidadTrabajadores,
                             MontoTrabajadores = t.ImporteTrabajadores,
                             NumPracticantes = t.CantidadPracticantes == null ? valorDefecto : (short)t.CantidadPracticantes,
                             MontoPracticantes = t.ImportePracticantes
                         }).ToList();
            }
            catch (Exception ex)
            {
                lista = null;
                throw ex;
            }

            return lista;
        }

        public List<DetalleVehiculo> ObtenerInfoVehiculoDetalle(short IdEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            List<DetalleVehiculo> lista = null;
            short valorDefecto = 0;
            try
            {
                lista = (from t in context.SP_S_ReporteVehiculoDetalle(IdEmpresa, fechaInicio, fechaFin).ToList()
                         select new DetalleVehiculo()
                         {
                             Descripcion = t.Constante,
                             Cantidad = t.Cantidad == null ? valorDefecto : (short)t.Cantidad,
                             MontoAsegurado = t.Importe
                         }).ToList();
            }
            catch (Exception ex)
            {
                lista = null;
                throw ex;
            }

            return lista;
        }

    }
}
