using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SiniestrosSeguros.Web.Filters
{
    //CUANDO ocurre una exception en mi vista que es llamada por la accion
    public class ErrorFilterAttribute : HandleErrorAttribute
    {
        public override void OnException(ExceptionContext filterContext)
        {
            base.OnException(filterContext);
        }
    }
}