using System.ComponentModel.DataAnnotations;
using static SiniestrosSeguros.DTO.ModelCustoms.TipoPoliza;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class TipoPoliza
    {

        public class TablaTipoPolizaModelView
        {
            [Required, Display(Name = "N°")]
            public short IdDivisionPoliza { get; set; }

            [Required, Display(Name = "Descripción")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Abreviatura")]
            public string Abreviatura { get; set; }

            [Required, Display(Name = "Aplica a Proveedor")]
            public string AplicaProveedor { get; set; }

            [Required, Display(Name = "Estado")]
            public bool IdEstado { get; set; }

            [Required, Display(Name = "Estado")]
            public string Estado { get; set; }

        }

        public class InicioTipoPolizaModelView
        {
            [Display(Name = "Ramo de Póliza")]
            public short IdConstante { get; set; }
            //public SelectList ListaRamoPoliza { get; set; }
            public TablaTipoPolizaModelView TablaPoliza { get; set; }
        }

        public class ModalTipoPolizaModelView
        {
            [Required, Display(Name = "ID")]
            public short IdDivisionPoliza { get; set; }

            [Required, Display(Name = "ID Tipo")]
            public short IdTipoPoliza { get; set; }

            [Required, Display(Name = "Descripción")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Abreviatura")]
            public string Abreviatura { get; set; }

            [Display(Name = "AplicaProveedor")]
            public bool AplicaProveedor { get; set; }

            [Display(Name = "IdEstado")]
            public bool IdEstado { get; set; }

            public TipoPolizaParamsModalView paramsModalView { get; set; }
        //[Required, Display(Name = "Estado")]
        //public string Estado { get; set; }
    }

    }
}
