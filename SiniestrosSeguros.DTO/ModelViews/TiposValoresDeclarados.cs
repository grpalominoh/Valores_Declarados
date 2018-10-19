using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class TiposValoresDeclarados
    {
        public class CrearTipoValorDeclaradoModelView
        {
            public short? IdTipoValorDeclarado { get; set; }

            [Required, Display(Name = "Nombre")]
            public string Nombre{ get; set; }

            [Required, Display(Name = "Descripción")]
            public string Descripcion{ get; set; }

            [Required, Display(Name = "Afecta Importe")]
            public bool AfectaImporte{ get; set; }

            [Required, Display(Name = "Afecta Cantidad")]
            public bool AfectaCantidad { get; set; }

            [Required, Display(Name = "Permite Carga de Detalle")]
            public bool PermiteCargaDetalle { get; set; }

            [Required, Display(Name = "Activo")]
            public bool IdEstado { get; set; }
        }

        public class EditarTipoValorDeclaradoModelView
        {
            [Required, Display(Name = "IdTipoValorDeclarado")]
            public short IdTipoValorDeclarado { get; set; }

            [Required, Display(Name = "Nombre")]
            public string Nombre { get; set; }

            [Required, Display(Name = "Descripción")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Afecta Importe")]
            public bool AfectaImporte { get; set; }

            [Required, Display(Name = "Afecta Cantidad")]
            public bool AfectaCantidad { get; set; }

            [Required, Display(Name = "Permite Carga de Detalle")]
            public bool PermiteCargaDetalle { get; set; }

            [Required, Display(Name = "Activo")]
            public bool IdEstado { get; set; }
        }

        public class VerTipoValorDeclaradoModelView
        {
            [Required, Display(Name = "IdTipoValorDeclarado")]
            public short IdTipoValorDeclarado { get; set; }

            [Required, Display(Name = "Nombre")]
            public string Nombre { get; set; }

            [Required, Display(Name = "Descripción")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Afecta Importe")]
            public bool AfectaImporte { get; set; }

            [Required, Display(Name = "Afecta Cantidad")]
            public bool AfectaCantidad { get; set; }

            [Required, Display(Name = "Permite Carga de Detalle")]
            public bool PermiteCargaDetalle { get; set; }

            [Required, Display(Name = "IdEstado")]
            public bool IdEstado { get; set; }

            [Display(Name = "Activo")]
            public string Estado { get; set; }
        }

    }
}
