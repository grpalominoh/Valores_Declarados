 
var siniestros = {};
siniestros.url = "http://localhost:53134/"
siniestros.ReplaceNumberWithCommas = function (valor) {

    if (valor != null && valor != '') {
        var n = valor.toString().split(".");
        n[0] = n[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        valor = n.join(".");
        return (valor.indexOf('.') < 0 && valor.indexOf(".00") < 0) ? valor + ".00" : valor;
    } else {
        return 0;
    }
}
siniestros.resetComas = function (valor) {
    if (valor != null) {
        if (valor.toString().trim() != '')
            return valor.toString().replace(/,/g, '');
        else {
            return valor;
        }
    } else {
        return valor;
    }
}




