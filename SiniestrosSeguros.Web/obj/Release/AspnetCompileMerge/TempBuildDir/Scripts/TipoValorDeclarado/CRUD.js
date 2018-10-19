$(document).ready(inicialize);

function inicialize() {

    $("#divError").hide();

    $("#frmCRUDTVD").submit(function (e) {

        e.preventDefault();
        submitFormTVD(this);

    });

    if ($("#IdTipoValorDeclarado").val() === "" || $("#IdTipoValorDeclarado").val() === undefined || $("#IdTipoValorDeclarado").val() === null || $("#IdTipoValorDeclarado").val() === 0) {
        $("#IdEstado").attr('checked', true);
    } else if ($("#IdTipoValorDeclarado").val() !== "" || $("#IdTipoValorDeclarado").val() !== undefined || $("#IdTipoValorDeclarado").val() !== null || $("#IdTipoValorDeclarado").val() !== 0) {
        var parametros = {
            IdTipoValorDeclarado: $("#IdTipoValorDeclarado").val()
        }
        //$.ajax({
        //    type: "POST",
        //    url: "TipoValorDeclarado/GetCountExistsTipoValorDeclaradoInValorDeclarado",
        //    data: parametros,
        //    success: function (data) {
        //        if (data > 0) {
        //            //alert("No se puede deshabilitar porque ya está siendo usado en un Valor Declarado ");
        //            $("#IdEstado").prop('disabled', true);
        //            // return;
        //        }
        //    },
        //    error: function (data) {

        //    }
        //});

    }

}

function submitFormTVD(frm) {

    var nombre = $("#Nombre").val();
    var descripcion = $("#Descripcion").val();
    var errores = [];
    if (nombre == '') {
        errores.push('- El campo nombre es obligatorio');
    }
    if (descripcion == '') {
        errores.push('- El campo descripción es obligatorio');
    } 
    if ($('#AfectaImporte').prop('checked') == false
        && $('#AfectaCantidad').prop('checked') == false
        && $('#PermiteCargaDetalle').prop('checked') == false)
        errores.push('Debe marcar una de las opciones mostradas');

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
            actualizaDataTable("#tbTipoValorDeclarado");
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



