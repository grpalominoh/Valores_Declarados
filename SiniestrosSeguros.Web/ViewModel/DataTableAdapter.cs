using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SiniestrosSeguros.Web.ViewModel
{
    public class DataTableAdapter<T> where T : class
    {
     
        [JsonProperty("draw")]
        public int Draw { get; set; } 
        [JsonProperty("recordsTotal")]
        public int RecordsTotal { get; set; }    
        [JsonProperty("recordsFiltered")]
        public int RecordsFiltered { get; set; }  
        [JsonProperty("data")]
        public List<T> Data { get; set; } 
        [JsonProperty("error")]
        public string Error { get; set; }

    }
}