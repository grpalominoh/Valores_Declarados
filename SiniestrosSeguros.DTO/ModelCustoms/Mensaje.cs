using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SiniestrosSeguros.DTO.ModelCustoms
{
    public class Mensaje
    {
        public string mensaje { get; set; }
        public bool esError { get; set; }
        public HttpStatusCode status { get; set; }
    }
}
