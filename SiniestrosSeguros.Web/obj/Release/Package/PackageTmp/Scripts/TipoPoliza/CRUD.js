$(document).ready(inicialize);

function inicialize() {

    $("#divError").hide();

    $("#frmCRUDTipoPoliza").submit(function (e) {

        e.preventDefault();
        submitFormTipoPoliza(this);

    });
}

function submitFormTipoPoliza(frm) {

    var abreviatura = $("#Abreviatura").val();
    var descripcion = $("#Descripcion").val();
    var errores = [];
    if (abreviatura == '') {
        errores.push('- El campo abreviatura es obligatorio');
    }
    if (descripcion == '') {
        errores.push('- El campo descripción es obligatorio');
    }

    if (errores.length > 0) {
        mostrarError(errores);
        return;
    }

    $.ajax({
        type: frm.method,
        url: frm.action,
        data: $(frm).serialize(),
        success: function (data) {
            $("#divModal #modalBody").empty().html(data).fadeIn(500);
            actualizaDataTable("#tbTipoPoliza");
        },
        error: function (data) {
            $("#divModal #modalBody").empty().html(data).fadeIn(500);
        }
    });

}

//FUNCION PARA QUE SOLO PERMITA INGRESAR NUMEROS, LETRAS, Y " ,.;:-_"
function soloNumerosLetrasGuionesComas(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz ,.;:-_0123456789";
    especiales = "8-37-39-46";

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial) {
        return false;
    }
}

function mostrarError(errores) {
    var html;
    if (errores.length == 1) {
      
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    } else {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    }

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }
    $("#divError").empty().html(html);
    $("#divError").show();           
}
