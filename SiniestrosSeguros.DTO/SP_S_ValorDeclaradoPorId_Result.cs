//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SiniestrosSeguros.DTO
{
    using System;
    
    public partial class SP_S_ValorDeclaradoPorId_Result
    {
        public int IdValorDeclarado { get; set; }
        public short IdEmpresa { get; set; }
        public System.DateTime FechaVigenciaInicio { get; set; }
        public Nullable<System.DateTime> FechaVigenciaTermino { get; set; }
        public string RutaArchivo { get; set; }
        public Nullable<short> IdMoneda { get; set; }
        public Nullable<decimal> TipoCambio { get; set; }
        public short IdEstado { get; set; }
    }
}