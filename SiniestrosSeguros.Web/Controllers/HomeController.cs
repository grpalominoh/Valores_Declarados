using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Reporting.WebForms;
using SiniestrosSeguros.BL;


namespace SiniestrosSeguros.Web.Controllers
{
    public class HomeController : Controller
    {
        BL.BLogic.TestLogic test = new BL.BLogic.TestLogic();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

    }
}
