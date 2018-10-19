using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SiniestrosSeguros.Web.Startup))]
namespace SiniestrosSeguros.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
