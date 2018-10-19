
$(document).ready(inicialize);

function inicialize() {

    $("#divError").hide();
    var afecta = $("#Afecta").val();

    if (afecta == 'A') {
        $("#ImporteAjustado").prop('disabled', false);
        $("#CantidadAjustada").prop('disabled', false);
    } else if (afecta == 'I') {
        $("#CantidadAjustada").prop('disabled', true);
    } else if (afecta == 'C') {
        $("#ImporteAjustado").prop('disabled', true);
    }

    $("#ImporteAjustado").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 2);
    });

    $("#CantidadAjustada").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 2);
    });

    $("#frmAjustaValor").submit(function (e) {

        submitFormAjusteValor(this);
        e.preventDefault();
    });

}

function submitFormAjusteValor(frm) {

    var abreviatura = $("#Abreviatura").val();
    var descripcion = $("#Descripcion").val();
    var errores = [];
    if (!$("#ImporteAjustado").prop('disabled') && $("#ImporteAjustado").val() == '') {
        errores.push('- Debe ingresar el importe a ajustar');
    } else if (parseFloat($("#ImporteAjustado").val()) <= 0) {
        errores.push('- Debe ingresar un importe mayor a cero');
    }
    if (!$("#CantidadAjustada").prop('disabled') && $("#CantidadAjustada").val() == '') {
        errores.push('- Debe ingresar la cantidad a ajustar');
    } else if (parseFloat($("#CantidadAjustada").val()) <= 0) {
        errores.push('- Debe ingresar una cantidad mayor a cero');
    }
   
    $.ajax({
        url: '/ValorDeclarado/ImporteAjustado',
        type: 'post',
        async: false,
        data: {
            idValorDeclaradoDetalleDisgregado: $(frm).find('#IdValorDeclaradoDetalleDisgregado').val(),
            cantidadAjustada: siniestros.resetComas($('#frmAjustaValor #CantidadAjustada').val()) ,
            importeAjustado: siniestros.resetComas($('#frmAjustaValor #ImporteAjustado').val())
        },
        dataType: 'json',
        success: function (d) {
            if (d.length > 0) {
                if (d[0].error > 0) {                                             
                    var mensajes = d[0].mensaje.trim().split('|');                                         
                    if (mensajes.length >1) {
                        errores.push(mensajes[0]);
                        errores.push(mensajes[1]);
                    } else {
                        errores.push(mensajes[0]);
                    }
                }

            }
        }
    });
    if (errores.length > 0) {
        mostrarError(errores);
        return;
    }

    var valor = siniestros.resetComas($("#ImporteAjustado").val());
    var cantidadAjustada = siniestros.resetComas($("#CantidadAjustada").val());

    $("#ImporteAjustado").val(valor);
    $("#CantidadAjustada").val(cantidadAjustada);

    $.ajax({
        type: frm.method,
        url: frm.action,
        data: $(frm).serialize(),
        success: function (data) {
            $("#divFrontModalSmall").modal("hide");
            $("#divFrontModal").modal("show");
            $("#divFrontModal #modalHeader h5").text("Ajustar Valor Declarado");
            $("#divFrontModal #modalBody").empty().html(data);
            $("#divFrontModal #modalFooter").hide();
            actualizaTablaTipoPoliza("#tbTipoPoliza");
            actualizaDataTableNew("#tbValorDeclarado");
        },
        error: function (data) {

        }
    });

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

function validarDecimales(evt, thisT, parteEntera, parteDecimal) {
    var position = getCaretPosition(thisT);
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    var value = thisT.value;
    var n = value.indexOf(".");
    if (n > 0) {
        if (n == position.end) {
            value = value.substr(0, position.end) + String.fromCharCode(charCode) + "." + value.substr(n + 1, value.length);
        } else if (n > position.end) {
            value = value.substr(0, position.end) + String.fromCharCode(charCode) + value.substr(position.end, n - position.end) + "." + value.substr(n + 1, value.length + 1);
        } else {
            value = value.substr(0, position.end) + String.fromCharCode(charCode) + value.substr(position.end, value.length + 1);
        }
        if (value.split(".")[0].length > parteEntera || value.split(".")[1].length > parteDecimal) {
            return false;
        }
    }

    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function getCaretPosition(ctrl) {
    // IE < 9 Support
    if (document.selection) {
        ctrl.focus();
        var range = document.selection.createRange();
        var rangelen = range.text.length;
        range.moveStart('character', -ctrl.value.length);
        var start = range.text.length - rangelen;
        return { 'start': start, 'end': start + rangelen };
    }
    // IE >=9 and other browsers
    else if (ctrl.selectionStart || ctrl.selectionStart == '0') {
        return { 'start': ctrl.selectionStart, 'end': ctrl.selectionEnd };
    } else {
        return { 'start': 0, 'end': 0 };
    }
}

