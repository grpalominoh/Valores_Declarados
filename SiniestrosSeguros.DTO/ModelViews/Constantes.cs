using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelViews
{
    public class Constantes
    {
        public class CrearConstanteModelView
        {
            [Required, Display(Name = "ID")]
            public short IdConstante { get; set; }

            [Required, Display(Name = "ID Padre")]
            public short IdPadre { get; set; }

            [Required, Display(Name = "Nombre")]
            public string Constante { get; set; }

            [Display(Name = "Descripción")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Cod Grupo")]
            public string CodigoAgrupador { get; set; }

            [Required, Display(Name = "Orden")]
            public short Orden { get; set; }

            [Display(Name = "Tag")]
            public string Tag { get; set; }

            [Required, Display(Name = "Estado")]
            public Boolean IdEstado { get; set; }

            [Required, Display(Name = "Agrupación")]
            public string ConstantePadre { get; set; }
        }

        public class EditarConstanteModelView
        {
            [Required, Display(Name = "ID")]
            public short IdConstante { get; set; }

            [Required, Display(Name = "Nombre")]
            public string Constante { get; set; }

            [Display(Name = "Descripción")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Cod Grupo")]
            public string CodigoAgrupador { get; set; }

            [Required, Display(Name = "Orden")]
            public short Orden { get; set; }

            [Display(Name = "Tag")]
            public string Tag { get; set; }

            [Required, Display(Name = "Estado")]
            public Boolean IdEstado { get; set; }

            [Required, Display(Name = "Agrupación")]
            public string ConstantePadre { get; set; }
        }

        public class VerConstanteModelView
        {
            [Display(Name = "ID")]
            public short IdConstante { get; set; }

            [Required, Display(Name = "ID Padre")]
            public short? IdPadre { get; set; }

            [Required, Display(Name = "Nombre")]
            [MaxLength(128,ErrorMessage ="La longitud permitida es 128")]
            public string Constante { get; set; }

            [Display(Name = "Descripción")]
            [MaxLength(256, ErrorMessage = "La longitud permitida es 256")]
            public string Descripcion { get; set; }

            [Required, Display(Name = "Código de Grupo")]
            public string CodigoAgrupador { get; set; }

            [Required, Display(Name = "Orden")]
            public short Orden { get; set; }

            [Display(Name = "Tag")]
            [MaxLength(32, ErrorMessage = "La longitud permitida es 32")]
            public string Tag { get; set; }

            [Required, Display(Name = "Estado")]
            public Boolean IdEstado { get; set; }

            [Display(Name = "Estado")]
            public string Estado { get; set; }

            [Required, Display(Name = "Agrupación")]
            public string ConstantePadre { get; set; }
        }
    }
}
