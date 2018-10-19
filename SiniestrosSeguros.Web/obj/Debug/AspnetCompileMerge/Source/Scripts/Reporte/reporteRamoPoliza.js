$(document).ready(inicialize);

var waitingDialog = waitingDialog || (function ($) {
    'use strict';

    var $dialog = $(
        '<div id="ModalCarga" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">' +
        '<div class="modal-dialog modal-m">' +
        '<div class="modal-content" style="background:#78797b00;border:0">' +
        '<div class="modal-body">' +
        '<div style="margin-left:100px;display: block;margin-right: auto;background-size: 50px;height:60px;width: 120px;background-image: url(../../Scripts/Images/loading.gif);background-repeat: no-repeat;"></div>' + ''+
        '</div>' +
        '</div></div></div>');

    return {
        show: function (message, options) {
            if (typeof options === 'undefined') {
                options = {};
            }
            if (typeof message === 'undefined') {
                message = 'Procesando...';
            }
            var settings = $.extend({
                dialogSize: 'm',
                progressType: '',
                onHide: null // This callback runs after the dialog was hidden
            }, options);

            $dialog.find('.modal-dialog').attr('class', 'modal-dialog').addClass('modal-' + settings.dialogSize);
            $dialog.find('.progress-bar').attr('class', 'progress-bar');
            if (settings.progressType) {
                $dialog.find('.progress-bar').addClass('progress-bar-' + settings.progressType);
            }
     
            if (typeof settings.onHide === 'function') {
                $dialog.off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
                    settings.onHide.call($dialog);
                });
            }
            $dialog.modal();
        },

        hide: function () {
            $dialog.modal('hide');
        }
    };

})(jQuery);

function inicialize() {
    $("#divError").hide();
    $("#detalleVehiculo").hide();

    $("#FechaVigenciaIni").datepicker(
        {
            dateFormat: 'dd/mm/yy',
            onClose: function (selectedDate) {
                $("#FechaVigenciaFin").datepicker("option", "minDate", selectedDate);
            }
        });

    $("#FechaVigenciaFin").datepicker(
        {
            dateFormat: 'dd/mm/yy',
            onClose: function (selectedDate) {
                $("#FechaVigenciaIni").datepicker("option", "maxDate", selectedDate);
            }
        });

    $('#FechaVigenciaIni').val('');
    $('#FechaVigenciaFin').val('');

}

function descargarReporte() {
    $("#divError").hide();

    if ($("#selRamoPoliza option:selected").val() == '') {
        var errores = [];
        errores.push("Debe seleccionar un ramo de poliza");
        mostrarError(errores);
        return;
    }
    if ($("#FechaVigenciaIni").val() == ''
        || $("#FechaVigenciaFin").val() == '') {
        var errores = [];
        errores.push("Debe Ingresar un rango de fechas");
        mostrarError(errores);
        return;
    }
    var IdEmpresa = 0;
    if ($("#selRamoPoliza").val() != '') {
        IdEmpresa = $("#ListaEmpresa option:selected").val();
    }

    var fecIni, fecFin;
    if ($('#FechaVigenciaIni').val() != '') {
        fecIni = convertToFormatController($('#FechaVigenciaIni').val());
        if ($('#FechaVigenciaFin').val() != '') {
            fecFin = convertToFormatController($('#FechaVigenciaFin').val());
        } else {
            var errores = [];
            errores.push("Debe ingresar la fecha fin");
            mostrarError(errores);
            return;
        }
    }
    waitingDialog.show();
    var parametros = {
        IdConstante: $("#selRamoPoliza option:selected").val(),
        IdEmpresa: IdEmpresa,
        FechaInicio: fecIni,
        FechaFin: fecFin,
        chkDetalle: $('#chkDetalle').prop('checked') == true ? 's' : 'n'
    };

    $.ajax({
        type: 'GET',
        url: 'EscribeExcel',
        data: parametros,
        success: function (data) {
            setTimeout(function () { waitingDialog.hide(); }, 1000);
            window.location = "DescargaReporte";
        },
        error: function (data) {
            setTimeout(function () { waitingDialog.hide(); }, 1000);
            var errores = [];
            errores.push("Ocurrió un error al procesar la descarga.");
            mostrarError(errores);
        }
    });

}

function mostrarDetalle() {
     
    if ($("#selRamoPoliza option:selected").text().trim() == 'Véhiculos'
        && $('#ListaEmpresa option:selected').val().trim() != '') {
        $("#chkDetalle").prop('checked', false);
        $("#chkDetalle").prop('disabled', false);
    } else {
        $("#chkDetalle").prop('checked', false);
        $("#chkDetalle").prop('disabled', true);
    }
}

function mostrarError(errores) {
    var html;
    if (errores.length === 1) {
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

function convertToDate(value) {//formato dd/MM/yyyy
    var fecha = value.split("/");
    var fechaISO = fecha[2] + "/" + fecha[1] + "/" + fecha[0];
    return new Date(fechaISO);
}

function convertToFormatController(value) {//formato dd/MM/yyyy
    var fecha = value.split("/");
    return fecha[2] + "-" + fecha[1] + "-" + fecha[0];
}
