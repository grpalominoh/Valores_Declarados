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
    
    public partial class SP_S_ValorDeclaradoDetalleDisgregado_PorIdValorDeclarado_Result
    {
        public int IdValorDeclaradoDetalleDisgregado { get; set; }
        public int IdValorDeclaradoDetalle { get; set; }
        public short IdTipoValorDeclarado { get; set; }
        public string TipoValorDeclarado { get; set; }
        public short IdTipoPoliza { get; set; }
        public string RamoPoliza { get; set; }
        public short IdDivisionPoliza { get; set; }
        public string DivisionPoliza { get; set; }
        public Nullable<short> IdUnidadMedida { get; set; }
        public string UnidadMedida { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<short> IdMoneda { get; set; }
        public string Moneda { get; set; }
        public Nullable<decimal> ImporteValorDeclarado { get; set; }
    }
}