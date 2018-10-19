/// <reference path="../_namespace.js" />


var $registrosEliminar = [];
var $registrosArchivoEliminar = [];

$(document).ready(inicialize);
$(".TipoCambio").prop("disabled", true);

var waitingDialog = waitingDialog || (function ($) {
    'use strict';

    var $dialog = $(
        '<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-2" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">' +
        '<div class="modal-dialog modal-m">' +
        '<div class="modal-content">' +
        '<div class="modal-header"><h3 style="margin:0;"></h3></div>' +
        '<div class="modal-body">' +
        '<img src="../Scripts/Images/loading.gif" style="display: block;margin-left: auto; margin-right: auto;" >' +
        '</div>' +
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
            $dialog.find('h3').text(message);
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
    $("#divErrorDetalle").hide();
    $("#divErrorArchivo").hide();
    $("#IdVerDetalle").attr('disabled', 'disabled');


    if ($("#frmCRUDVD #IdEmpresa").val() !== undefined && $("#frmCRUDVD #IdEmpresa").val() !== '') {
        $("#frmCRUDVD #IdEmpresa").attr("class", "form-control camboDisabled");

        if ($('[id*=IdMoneda] option:selected').text() != 'Dolares') {
            $("#frmCRUDVD .TipoCambio").prop('disabled', true);
        } else {
            $("#frmCRUDVD .TipoCambio").prop('disabled', false);

        }
    }



    $("#ValorDeclaradoCabecera_FechaVigenciaIniModal").datepicker(
        {
            dateFormat: 'dd/mm/yy',
            beforeShow: function (input) {
                $(input).css({
                    "position": "relative",
                    "z-index": 2000
                });
            },
            onClose: function (selectedDate) {
                $("#ValorDeclaradoCabecera_FechaVigenciaFinModal").datepicker("option", "minDate", selectedDate);
            }
        });

    $("#ValorDeclaradoCabecera_FechaVigenciaFinModal").datepicker(
        {
            dateFormat: 'dd/mm/yy',
            beforeShow: function (input) {
                $(input).css({
                    "position": "relative",
                    "z-index": 2000
                });
            },
            onClose: function (selectedDate) {
                $("#ValorDeclaradoCabecera_FechaVigenciaIniModal").datepicker("option", "maxDate", selectedDate);
            }
        });

    $("#ValorDeclaradoCabecera_TipoCambio").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 4);//CAMBIAR
    });

    $("#ValorDeclaradoDetalle_Cantidad").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 2);
    });

    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 2);
    });

    $("#frmCRUDVD").keypress(function (e) {
        //Enter key
        if (e.which == 13) {
            return false;
        }
    });
    $("#frmCRUDVD").submit(function (e) {
        e.preventDefault();
        submitFormVD(this);
    });

    $('#idAgregar').click(function () {
      
        agregarRegistro();

    });

    $('#idModificar').click(function () {
        modificarRegistroDetalle(this);
    });


    $(document).on('click', '.borrar2', function (event) {

        let $row = $("#tbValorDeclaradoDetalle").DataTable().row($(this).parents("tr"));
        let $Id = $row.data().IdValorDeclaradoDetalle;


        //solo guardamos los que tengan ID, los otro no son necesario porque nunca se guardaron en bbdd
        if ($Id > 0) {

            var data = $row.data();

            let $obj = new Object();
            $obj.IdValorDeclaradoDetalle = data.IdValorDeclaradoDetalle;
            $obj.IdTipoValorDeclaradoDetalle = data.IdTipoValorDeclarado;
            $obj.IdUnidadMedidaDetalle = data.IdUnidadMedida;
            $obj.ImporteValorDeclarado = data.ImporteValorDeclarado;
            $obj.CantidadDetalle = data.Cantidad;
            $obj.IdMonedaDetalle = data.IdMoneda;
            $obj.IdEstado = 2; //eliminado lógico

            $registrosEliminar.push($obj);
        }
        $row.remove().draw();
        return;
    });

    $("#divModal").scroll(function () {
        $("#ValorDeclaradoCabecera_FechaVigenciaIniModal").datepicker('hide');

        $("ui-datepicker-div").css("display", "inline").fadeOut("slow");

        $("ui-datepicker-div").css("display", "inline").fadeOut("slow");

        $("#ValorDeclaradoCabecera_FechaVigenciaFinModal").datepicker('hide');
        $("ui-datepicker-div").css("display", "inline").fadeOut("slow");

    });

    let tableArchivos;
    let table;
    actualizaDataTableDatalle();

    //actualizamos la grilla de archivos
    let listaArchivos = {};
    if ($("#ValorDeclaradoCabecera_ListaArchivo").val() !== "") {
        listaArchivos = JSON.parse($("#ValorDeclaradoCabecera_ListaArchivo").val());
    }
    ActualizarTablaArchivos(listaArchivos);

    //Si el detalle tiene registros, el tipo de moneda no debe cambiar.
    if (CountValorDeclaradoDetalle() > 0) {

        $("#IdMoneda").attr("class", "form-control camboDisabled");
        if ($('[id*=IdMoneda] option:selected').text() == 'Soles') {
            $('#lblSimbolo').html('S/')
        }
        else if ($('[id*=IdMoneda] option:selected').text() == 'Dolares') {
            $('#lblSimbolo').html('$')
        }
    }

    //boton agregar debe estar activo al iniciar el VD
    $("#idModificar").prop('disabled', true);
    $("#idAgregar").prop('disabled', false);
    $("#IdVerDetalle").prop('disabled', true);

    if ($("#IdTipoValorDeclarado option:selected").val() === undefined || $("#IdTipoValorDeclarado option:selected").val() === '') {
        $("#IdFileDetalle").prop('disabled', true);
        $("#subir2").prop('disabled', true);
        $("#IdFileDetalle").val('');
    }


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

function validaDecimalesOld(e, thisT) {
    key = e.keyCode ? e.keyCode : e.which
    // backspace
    if (key == 8) return true
    // 0-9
    if (key > 47 && key < 58) {
        if (thisT.value == "") return true
        regexp = /.[0-9]{9}$/
        return !(regexp.test(thisT.value))
    }
    // .
    if (key == 46) {
        if (thisT.value == "") return false
        regexp = /^[0-9]+$/
        return regexp.test(thisT.value)
    }

    var n = thisT.value.indexOf(".");
    if (n > 0) {
        if (thisT.value.substring(n + 1) === undefined) {
            thisT.value = thisT.value + '0'
        }
    }

    return false
}

function completaTipoCambio(campo) {

    //var tipoCambio = campo.value;
    //var n = tipoCambio.indexOf(".");
    //if (n > 0 && (tipoCambio.substring(n + 1) === undefined || tipoCambio.substring(n + 1) === '')) {
    //    campo.value = tipoCambio + '00';
    //} else {
    //    campo.value = tipoCambio + '.00';
    //}

    //if (tipoCambio.charAt(0) == '.') {
    //    $(".TipoCambio").val("");
    //} 
    //campo.value = siniestros.ReplaceNumberWithCommas(campo.value);
}

function submitFormVD(frm) {

    var errores = [];
    var erroresDetalle = [];
    var erroresArchivo = [];

    var tipoCambio = $("#ValorDeclaradoCabecera_TipoCambio").val();
    var n = tipoCambio.indexOf(".");

    if ($("#frmCRUDVD #IdEmpresa").val() === undefined || $("#frmCRUDVD #IdEmpresa").val() === '') {
        errores.push("- Debe seleccionar una Empresa");
    } else if ($("#frmCRUDVD #IdMoneda").val() === undefined || $("#frmCRUDVD #IdMoneda").val() === '') {
        errores.push("- Debe seleccionar una Moneda");
    } else if ($("#ValorDeclaradoCabecera_FechaVigenciaIniModal").val() === undefined || $("#ValorDeclaradoCabecera_FechaVigenciaIniModal").val() === '') {
        errores.push("- Debe ingresar una Fecha de Inicio");
    } else if (n > 0 && (tipoCambio.substring(n + 1) === undefined || tipoCambio.substring(n + 1) === '')) {
        errores.push("- Debe ingresar una Tipo de Cambio con formato correcto");
    } else if (($("#frmCRUDVD #ValorDeclaradoCabecera_TipoCambio").val() === undefined ||
        $("#frmCRUDVD #ValorDeclaradoCabecera_TipoCambio").val() == '')
        && $("#frmCRUDVD #IdMoneda option:selected").text() == 'Dolares') {
        errores.push("- Debe ingresar un tipo de cambio");
    }


    //else if ($("#frmCRUDVD #IdMoneda").text() === undefined ||
    //    $("#frmCRUDVD #ValorDeclaradoCabecera_TipoCambio").val() === '') {
    //    errores.push("- Debe ingresar una Tipo de Cambio");
    //}
    //else if ($("#frmCRUDVD #ValorDeclaradoDetalle_ImporteValorDeclarado").val() === undefined || $("#frmCRUDVD #ValorDeclaradoDetalle_ImporteValorDeclarado").val() === '') {
    //    errores.push("- Debe ingresar un importe declarado");
    //}

    if ($("#frmCRUDVD #tbValorDeclaradoDetalle").find('tbody tr[role="row"]').length == 0) {
        errores.push("- No se ha agregado ninguna información a la grilla de datos.");
    }
    //else if ($('#frmCRUDVD #IdTipoValorDeclarado[class*="camboDisabled"]').length > 0) {
    //    errores.push("- Limpie Los datos de la fila seleccionada.");
    //}     
    if ($("#tbArchivosAdjuntos").DataTable().data().count() == 0) {
        $('#toast-container').html('');
        toastr.error("- No se ha agregado ninguna archivo .", {
            tapToDismiss: false
            , timeOut: 0
            , extendedTimeOut: 0
            , allowHtml: true
            , preventDuplicates: true
            , preventOpenDuplicates: true
            , newestOnTop: true
        });
        return false;
    }
    if (errores.length > 0) {
        mostrarError(errores);
    } else {

        //envio 0 porque este campo es obligatorio y debe enviarse con valor, pero no hace nada
        $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(0);
        getInsArchivos();
        getDelArchivos();
        getInsDetalleValorAgregado(frm);
        getDelDetalleValorAgregado(frm);
        //        $("#divModal #modalBody").empty().html('<img src="../../Scripts/Images/loading.gif" style="background-s;display: block;margin-left: auto; margin-right: auto;" >').fadeIn(500);
        siniestros.preload(1, function (close) {
            $(frm).find('#ValorDeclaradoDetalle_ImporteValorDeclarado').val(0);
            $(frm).find('#ValorDeclaradoCabecera_TipoCambio').val(siniestros.resetComas($(frm).find('#ValorDeclaradoCabecera_TipoCambio').val()));
            $(frm).find('#ValorDeclaradoDetalle_Cantidad').val(siniestros.resetComas($(frm).find('#ValorDeclaradoDetalle_Cantidad').val()));
            $.ajax({
                type: frm.method,
                url: frm.action,
                data: $(frm).serialize(),
                success: function (data) {
                    close();
                    $("#divModal h5.modal-title").html('Mensaje');
                    $("#divModal #modalBody").empty().html(data).fadeIn(500);
                    $("#divModal").modal("show");
                    actualizaDataTableNew("#tbValorDeclarado");
                },
                error: function (data) {
                    $("#divModal #modalBody").empty().html(data).fadeIn(500);
                }
            });
        });

    }

}

function actualizaDataTableDatalle() {

    var datosTablaDetalle = {};

    if ($("#ValorDeclaradoCabecera_ValorDeclaradoDetalle").val() !== "") {
        datosTablaDetalle = JSON.parse($("#ValorDeclaradoCabecera_ValorDeclaradoDetalle").val());
    }

    table = $("#tbValorDeclaradoDetalle").DataTable({
        data: datosTablaDetalle,
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        processing: true,
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        columns: [
            { "data": "IdValorDeclaradoDetalle" },
            { "data": "IdTipoValorDeclarado" },
            { "data": "TipoValorDeclaradoDesc" },
            { "data": "IdUnidadMedida" },
            { "data": "UnidadMedidaDesc" },
            { "data": "Cantidad" },
            { "data": "ImporteValorDeclarado" },
            { "data": "IdMoneda" },
            { "data": "MonedaDesc" },
            { "data": "FlagEdicion" }
        ],
        columnDefs: [
            {
                targets: [0, 1, 3, 7, 9],
                visible: false
            },

            {
                "width": "60px",
                className: "text-left",
                "targets": 2
            },
            {
                "width": "100px",
                className: "text-center",
                "targets": 4
            }, {
                className: "text-center",
                "targets": 7
            }, {
                "width": "60px",
                className: "numeric-right",
                "targets": [5],
                render: function (data, type, row) {

                    if (row.UnidadMedidaDesc == null) {
                        return '';
                    } else
                        return row.Cantidad;
                }
            }, {
                "width": "60px",
                className: "numeric-right",
                "targets": [6]
            },
            {
                "width": "20px",
                className: "text-center",
                "targets": [8]
            },
            {
                className: "dt-body-center dt-body-width-5",
                targets: [10],
                render: function (data, type, row) {
                    row.ImporteValorDeclarado = siniestros.ReplaceNumberWithCommas(row.ImporteValorDeclarado);
                    return '<button type="button" style="border-right-width: 1px;margin-right: 2px;" onclick="javascript:editarRegistroDetalle(this)"  class="btn btn-primary botonOp ti-pencil-alt" value="Editar"  /> '
                        + "" + '<button type="button" onclick="javascript:eliminarRegistro(this)"  class="btn btn-danger AnularBtn ti-trash borrar" value="Eliminar"  /> ';

                }
            }
            //{
            //    className: "dt-body-center dt-body-width-5",
            //    targets: [11],
            //    render: function (data, type, row) {
            //        return '<button type="button" onclick="javascript:eliminarRegistro(this)"  class="btn btn-danger AnularBtn ti-trash borrar" value="Eliminar"  /> ';
            //    }
            //}
        ]
    });
    table.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();
        table.row(rowId).data(data).draw();
    })

}

function addContadorTable() {

    let $rows = $("#tbValorDeclaradoDetalle tbody tr");
    let $cantCol = $rows.length; //-1 Quitando el ultimo registro de la fila del promedio y su valor.
    for (var i = 0; i < $cantCol; i++) {

        $rows.eq(i).find(".editarReg").val(i + 1);

    }
}

function agregarRegistro() {

    var erroresDetalle = [];

    if ($("#IdMoneda").val() === undefined || $("#IdMoneda").val() === '') {
        erroresDetalle.push("- No ha seleccionado un Tipo de Moneda");
    } else if ($("#IdTipoValorDeclarado").val() === undefined || $("#IdTipoValorDeclarado").val() === '') {
        erroresDetalle.push("- Debe seleccionar un Tipo de Valor Declarado");
    } else
        if (!$('#IdUnidadMedida').is(':disabled')) {
            if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
                erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
            }
        }

    if ($("#IdTipoValorDeclarado").val() != ''
        && $("#IdUnidadMedida").val() != '') {

        if ($("#ValorDeclaradoDetalle_Cantidad").val() == undefined || $("#ValorDeclaradoDetalle_Cantidad").val() == '') {

            erroresDetalle.push("- Debe seleccionar una cantidad");
        }

    }

    if (($('#ValorDeclaradoDetalle_Cantidad').prop('disabled') == false
        && ($('#ValorDeclaradoDetalle_Cantidad').val().trim() == '' ||
            $('#ValorDeclaradoDetalle_Cantidad').val().trim() == '0' ||
            $('#ValorDeclaradoDetalle_Cantidad').val() == 0))) {
        erroresDetalle.push("- Debe ingresar una cantidad para el tipo de valor declarado");
    }
    if (($('#ValorDeclaradoDetalle_ImporteValorDeclarado').prop('disabled') == false
        && $('#ValorDeclaradoDetalle_ImporteValorDeclarado').val().trim() == '')) {
        erroresDetalle.push("- Debe ingresar un importe para el tipo de valor declarado");
    }
    if (($('#IdFileDetalle').prop('disabled') == false
        && $('#IdFileDetalle').val().trim() == '')) {
        erroresDetalle.push("- No se cargo un archivo");
    }


    if (($('#ValorDeclaradoDetalle_Cantidad').prop('disabled') == false
        && $('#ValorDeclaradoDetalle_Cantidad').val() == 0)) {
        erroresDetalle.push("- Debe ingresar una cantidad mayor a '0'");
    }


    if ($('#ValorDeclaradoDetalle_ImporteValorDeclarado').prop('disabled') == false
        && ($('#ValorDeclaradoDetalle_ImporteValorDeclarado').val().trim() == '0'
            || $('#ValorDeclaradoDetalle_ImporteValorDeclarado').val() == 0)
    ) {
        erroresDetalle.push("- Debe ingresar un importe mayor a '0'");
    }

    var existe = 1;
    table.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();
        if (parseInt($("#IdTipoValorDeclarado").val()) === parseInt(data.IdTipoValorDeclarado)) {
            existe = 2;
        }

    })

    if (existe === 2) {
        erroresDetalle.push("- Tipo de Valor Declarado ya ha sido añadido");
    }

    if (erroresDetalle.length > 0) {
        $('#divErrorDetalle').removeClass('alert-success').addClass('alert-danger')
        mostrarErrorDetalle(erroresDetalle);
    } else {

        agregarRegistroOK();

    }
}

function agregarRegistroOK() {
    $("#divErrorDetalle").hide();

    let $rows = $("#tbValorDeclaradoDetalle tbody tr");
    let $last = $rows.length - 1;
    let $registroSiguiente = $rows.length + 1;

    var detalle = {
        IdValorDeclaradoDetalle: 0,
        IdTipoValorDeclarado: $("#IdTipoValorDeclarado").val(),
        TipoValorDeclaradoDesc: $("#IdTipoValorDeclarado option:selected").text(),
        IdUnidadMedida: $("#IdUnidadMedida").val(),
        UnidadMedidaDesc: ($("#IdUnidadMedida").val() !== undefined && $("#IdUnidadMedida").val() !== '') ? $("#IdUnidadMedida option:selected").text() : '',
        ImporteValorDeclarado: $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val(),
        Cantidad: siniestros.resetComas($("#ValorDeclaradoDetalle_Cantidad").val()),
        IdMoneda: $("#IdMoneda").val(),
        MonedaDesc: $("#IdMoneda option:selected").text(),
        FlagEdicion: 0,
        Accion: '<td><button type="button" onclick="javascript:eliminarRegistro(this)" class="btn btn-default borrar" id="btnEditProg">Eliminar</button></td>'
    };
    $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(0) //cuando se agrega registro se tiene que poner el id a cero

    if ($("#IdFileDetalle").val() !== '') {

        jsLeerExcel();
        $("#tbValorDeclaradoDetalle").DataTable().row.add(detalle).draw();

        if (registrosError.length > 0) {
            CrearArchivoErrores(registrosError);
            registrosError = 0;
        }
    } else {

        $("#tbValorDeclaradoDetalle").DataTable().row.add(detalle).draw();
    }

    //desabilitamos el Tipo de Moneda
    if (CountValorDeclaradoDetalle() > 0) {
        if ($('[id*=IdMoneda] option:selected').text() == 'Soles') {
            $('#lblSimbolo').html('S/')
        }
        else if ($('[id*=IdMoneda] option:selected').text() == 'Dolares') {
            $('#lblSimbolo').html('$')
        }
        $("#IdMoneda").attr("class", "form-control camboDisabled");
        //$("#IdMoneda").prop('disabled', true);
    }

    $("#IdTipoValorDeclarado").val('');
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val('');
    $("#ValorDeclaradoDetalle_Cantidad").val('');
    $("#IdUnidadMedida").val('');
    $("#idModificar").prop('disabled', true);
    $("#IdVerDetalle").prop('disabled', true);
    $("#idAgregar").prop('disabled', false);

    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', false);
    $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', false);
    $("#IdUnidadMedida").prop('disabled', false);
    $("#IdFileDetalle").prop('disabled', true);
    $("#subir2").prop('disabled', true);
    $("#IdFileDetalle").val('');
}

function eliminarRegistro(registro) {
    siniestros.mensajeAlert(0, '¿Está seguro de eliminar el Valor Declarado de la Lista?', function () {
        let $row = $("#tbValorDeclaradoDetalle").DataTable().row($(registro).parents("tr"));
        let $Id = $row.data().IdValorDeclaradoDetalle;


        //solo guardamos los que tengan ID, los otro no son necesario porque nunca se guardaron en bbdd
        if ($Id > 0) {

            var data = $row.data();

            let $obj = new Object();
            $obj.IdValorDeclaradoDetalle = data.IdValorDeclaradoDetalle;
            $obj.IdTipoValorDeclaradoDetalle = data.IdTipoValorDeclarado;
            $obj.IdUnidadMedidaDetalle = data.IdUnidadMedida;
            $obj.ImporteValorDeclarado = data.ImporteValorDeclarado;
            $obj.CantidadDetalle = data.Cantidad;
            $obj.IdMonedaDetalle = data.IdMoneda;
            $obj.IdEstado = 0; //eliminado lógico

            $registrosEliminar.push($obj);
        }
        $row.remove().draw();

        if (CountValorDeclaradoDetalle() === 0) {
            $("#IdMoneda").removeClass("camboDisabled");
            //$("#IdMoneda").prop('disabled', false);
        }

        //limpiamos los inputs
        $("#IdTipoValorDeclarado").val('');
        $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val('');
        $("#ValorDeclaradoDetalle_Cantidad").val('');
        $("#IdUnidadMedida").val('');
        $("#IdTipoValorDeclarado").removeClass("camboDisabled");
        $("#idModificar").prop('disabled', true);
        $("#IdVerDetalle").prop('disabled', true);
        $("#idAgregar").prop('disabled', false);

        $("#divError").hide();
        $("#divErrorDetalle").hide();
    })


}
var nroFila = 0;
function editarRegistroDetalle(registro) {

    var $d = $(registro).parent("td");
    nroFila = $d.parent().parent().children().index($d.parent()); //obtenemos numero de fila para despues modificarlo

    let $row = $("#tbValorDeclaradoDetalle").DataTable().row($(registro).parents("tr"));

    //
    var data = $row.data();


    $("#IdTipoValorDeclarado").val(data.IdTipoValorDeclarado);
    DevuelveFlagsPorIdTipoValorDeclarado();
    $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(data.IdValorDeclaradoDetalle);
    $("#IdUnidadMedida").val(data.IdUnidadMedida);
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val(data.ImporteValorDeclarado);
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").trigger('change');
    $("#ValorDeclaradoDetalle_Cantidad").val(data.Cantidad);
    $("#ValorDeclaradoDetalle_Cantidad").trigger('change');
    $("#IdTipoValorDeclarado").attr("class", "form-control camboDisabled");

    $("#IdVerDetalle").attr('data-replace', 'false');
    //deshabilitamos esta opcion para no confundir funcionalidad.
    $("#idAgregar").prop('disabled', true);
    $("#IdVerDetalle").prop('disabled', false);
    $("#idModificar").prop('disabled', false);
    $("#divError").hide();
    $("#divErrorDetalle").hide();

}

function modificarRegistroDetalle(registro) {

    var erroresDetalle = [];

    if ($("#IdMoneda").val() === undefined || $("#IdMoneda").val() === '') {
        erroresDetalle.push("- No ha seleccionado un Tipo de Moneda");
    } else if ($("#IdTipoValorDeclarado").val() === undefined || $("#IdTipoValorDeclarado").val() === '') {
        erroresDetalle.push("- Debe seleccionar un Tipo de Valor Declarado");
    } else
        if (!$('#IdUnidadMedida').is(':disabled')) {
            if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
                erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
            }
        }



    if (($('#ValorDeclaradoDetalle_Cantidad').prop('disabled') == false
        && $('#ValorDeclaradoDetalle_Cantidad').val() == '')) {
        erroresDetalle.push("- Debe ingresar una cantidad para el tipo de valor declarado");
    }
    if (($('#ValorDeclaradoDetalle_ImporteValorDeclarado').prop('disabled') == false
        && $('#ValorDeclaradoDetalle_ImporteValorDeclarado').val().trim() == '')) {
        erroresDetalle.push("- Debe ingresar un importe para el tipo de valor declarado");
    }
    //si no esta desabilitado

    if (($('#ValorDeclaradoDetalle_Cantidad').prop('disabled') == false
        && $('#ValorDeclaradoDetalle_Cantidad').val().trim() == 0)) {
        erroresDetalle.push("- Debe ingresar una cantidad mayor a '0'");
    }


    if (($('#ValorDeclaradoDetalle_ImporteValorDeclarado').prop('disabled') == false
        && (siniestros.resetComas($('#ValorDeclaradoDetalle_ImporteValorDeclarado').val()) == '0'
            || $('#ValorDeclaradoDetalle_ImporteValorDeclarado').val() == 0)
    )) {
        erroresDetalle.push("- Debe ingresar un importe mayor a '0'");
    }
    //if ($("#IdMoneda").val() === undefined || $("#IdMoneda").val() === '') {
    //    erroresDetalle.push("- No ha seleccionado un Tipo de Moneda");
    //} else if ($("#IdTipoValorDeclarado").val() === undefined || $("#IdTipoValorDeclarado").val() === '') {
    //    erroresDetalle.push("- Debe seleccionar un Tipo de Valor Declarado");
    //} else if (!$('#IdUnidadMedida').is(':disabled')) {
    //    if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
    //        erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
    //    }
    //}

    //if ($("#ValorDeclaradoDetalle_Cantidad").val() !== undefined && $("#ValorDeclaradoDetalle_Cantidad").val() !== '' && $("#ValorDeclaradoDetalle_Cantidad").val() !== '0') {
    //    if (!$('#IdUnidadMedida').is(':disabled')) {
    //        if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
    //            erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
    //        }
    //    }


    //}

    if (erroresDetalle.length > 0) {
        mostrarErrorDetalle(erroresDetalle);
    } else {
        $("#divErrorDetalle").hide();

        let $rows = $("#tbValorDeclaradoDetalle tbody tr");
        let $last = $rows.length - 1;
        let $registroSiguiente = $rows.length + 1;

        var detalle = {
            IdValorDeclaradoDetalle: $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(),
            IdTipoValorDeclarado: $("#IdTipoValorDeclarado").val(),
            TipoValorDeclaradoDesc: $("#IdTipoValorDeclarado option:selected").text(),
            IdUnidadMedida: $("#IdUnidadMedida").val(),
            UnidadMedidaDesc: ($("#IdUnidadMedida").val() !== undefined && $("#IdUnidadMedida").val() !== '') ? $("#IdUnidadMedida option:selected").text() : '',
            ImporteValorDeclarado: $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val(),
            Cantidad: ($("#ValorDeclaradoDetalle_Cantidad").val() == '0' && $("#IdUnidadMedida").val() == '') ? '' : siniestros.resetComas($("#ValorDeclaradoDetalle_Cantidad").val()).replace(/\.00/g, ""),
            IdMoneda: $("#IdMoneda").val(),
            MonedaDesc: $("#IdMoneda option:selected").text(),
            FlagEdicion: -1,
            Accion: '<td><button type="button" onclick="javascript:eliminarRegistro(this)" class="btn btn-default borrar" id="btnEditProg">Eliminar</button></td>'
        };

        $("#divError").hide();
        $("#divErrorDetalle").hide();

        if ($("#IdFileDetalle").val() !== '') {

            jsLeerExcel();
            table.row(nroFila).data(detalle).draw();

            if (registrosError.length > 0) {
                CrearArchivoErrores(registrosError);
                registrosError = 0;
            }
        } else {

            table.row(nroFila).data(detalle).draw();
        }



        $("#IdTipoValorDeclarado").val('');
        $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val('');
        $("#ValorDeclaradoDetalle_Cantidad").val('');
        $("#IdUnidadMedida").val('');
        $("#IdTipoValorDeclarado").removeClass("camboDisabled");
        $("#idAgregar").prop('disabled', false);
        $("#idModificar").prop('disabled', true);
        $("#IdVerDetalle").prop('disabled', true);

        $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', false);
        $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', false);
        $("#IdUnidadMedida").prop('disabled', false);
        $("#IdFileDetalle").prop('disabled', true);
        $("#subir2").prop('disabled', true);
        $("#IdFileDetalle").val('');
    }

}

function CountValorDeclaradoDetalle() {
    //valida si tabla tiene registros, con el metodo tradicional no funciona bien por eso se hace de esta forma.
    let $json = [];
    table.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();

        let $obj = new Object();
        $obj.IdValorDeclaradoDetalle = data.IdValorDeclaradoDetalle;
        $json.push($obj);
    })

    return $json.length;
}

function getInsDetalleValorAgregado(frm) {

    let $json = [];
    let $rows = $("#tbValorDeclaradoDetalle tbody tr");
    let $cantCol = $rows.length; //-1 Quitando el ultimo registro de la fila del promedio y su valor.


    table.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();

        let $obj = new Object();
        $obj.IdValorDeclaradoDetalle = data.IdValorDeclaradoDetalle;
        $obj.IdTipoValorDeclaradoDetalle = data.IdTipoValorDeclarado;
        $obj.IdUnidadMedidaDetalle = data.IdUnidadMedida;
        $obj.ImporteValorDeclarado = siniestros.resetComas(data.ImporteValorDeclarado);
        $obj.CantidadDetalle = data.Cantidad;
        $obj.IdMonedaDetalle = data.IdMoneda;
        $obj.FlagEdicion = data.FlagEdicion;
        $json.push($obj);
    })

    $("#frmCRUDVD #ValorDeclaradoCabecera_ValorDeclaradoDetalle").val(JSON.stringify($json));


};

function getDelDetalleValorAgregado(frm) {
    $("#frmCRUDVD #ValorDeclaradoCabecera_ValorDeclaradoDetalleEliminado").val(JSON.stringify($registrosEliminar));
}

function adjuntarArchivo() {
    var erroresArchivo = [];
    var errores = [];
    var erroresDetalle = [];
    var erroresArchivo = [];

    if (document.getElementById("File").files[0] !== undefined) {
        var PesoFile = parseFloat(document.getElementById("File").files[0].size / 1024); //valor del archivo
        var MaxSizeArchivo = parseFloat($("#MaxSizeArchivo").val()); //valor del web.config 2048

        if (PesoFile > MaxSizeArchivo) {
            erroresArchivo.push("- Archivo muy pesado");
        }

        if (erroresArchivo.length > 0) {
            mostrarErrorArchivo(erroresArchivo);
        } else {
            $("#divErrorArchivo").hide();
            let $json = [];
            let $rows = $("#tbArchivosAdjuntos tbody tr");


            tableArchivos.rows().every(function (rowId, tableLoop, rowLoop) {
                var data = this.data();

                let $obj = new Object();
                $obj.IdValorDeclarado = data.IdValorDeclarado;
                $obj.IdArchivo = data.IdArchivo;
                $obj.NombreArchivo = data.NombreArchivo;
                $obj.NombreAsignado = data.NombreAsignado;
                $obj.Formato = data.Formato;
                $obj.RutaArchivo = data.RutaArchivo;
                $obj.IdEstado = data.IdEstado;
                $json.push($obj);
            })

            var fd = new FormData();
            fd.append("File", document.getElementById("File").files[0]);
            fd.append("ArchivoList", JSON.stringify($json));

            $.ajax({
                url: "ValorDeclarado/AdjuntarArchivo",
                data: fd,
                processData: false,
                contentType: false,
                type: "POST",
                success: function (data) {
                    if (!data.esError) {
                        $("#File").val('')
                        ActualizarTablaArchivos(data);
                    } else {
                        var errores = [];
                        errores.push(data.mensaje);
                        mostrarErrorArchivo(errores);
                    }
                },
                failure: function (data) {
                    $("#divError").empty().html(data);
                    $("#divError").show();
                },
                error: function (data) {
                    $("#divError").empty().html(data);
                    $("#divError").show();
                }
            });
        }
    } else {
        errores.push("- Debe seleccionar un archivo");
        mostrarError(errores);
    }


}

function ActualizarTablaArchivos(listaArchivos) {
    tableArchivos = $("#tbArchivosAdjuntos").DataTable({
        data: listaArchivos,
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        processing: true,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        columns: [
            { "data": "IdValorDeclarado" }, { "data": "IdArchivo" }, { "data": "NombreArchivo" }, { "data": "NombreAsignado" },
            { "data": "Formato" }, { "data": "RutaArchivo" }, { "data": "IdEstado" }
        ],
        columnDefs: [
            {
                className: "dt-body-center dt-body-width-4",
                targets: [0, 1, 3, 4, 5, 6],
                visible: false
            },
            {
                className: "dt-body-center dt-body-width-5",
                targets: [7],
                render: function (data, type, row) {



                    return "<button type='button' style='border-right-width: 1px;margin-right:15px;margin-left: 150px;' class='btn btn-success AnularBtn ico-descargar' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>" + '  ' + '<button type="button" onclick="javascript:eliminarRegistroArchivo(this)"  class="btn btn-danger AnularBtn ti-trash borrar ico-borrar" value="Eliminar"  /> ';


                }
            }
            //{
            //    className: "dt-body-center dt-body-width-3",
            //    targets: [7],
            //    render: function (data, type, row) {
            //        //return "<button type='button' class='btn btn-success AnularBtn ti-save' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>";
            //        return "<button type='button' class='btn AnularBtn ico-descargar' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>";

            //    }
            //}
        ]
    });
}

function eliminarRegistroArchivo(registro) {
    siniestros.mensajeAlert(0, '¿Esta seguro en Eliminar el archivo de la lista?', function () {
        let $row = $("#tbArchivosAdjuntos").DataTable().row($(registro).parents("tr"));
        let $Id = $row.data().IdArchivo;


        //solo guardamos los que tengan ID, los otro no son necesario porque nunca se guardaron en bbdd
        if ($Id > 0) {

            var data = $row.data();

            let $obj = new Object();
            $obj.IdValorDeclarado = data.IdValorDeclarado;
            $obj.IdArchivo = data.IdArchivo;
            $obj.NombreArchivo = data.NombreArchivo;
            $obj.NombreAsignado = data.NombreAsignado;
            $obj.Formato = data.Formato;
            $obj.RutaArchivo = data.RutaArchivo;
            $obj.IdEstado = 2;

            $registrosArchivoEliminar.push($obj);
        }
        $row.remove().draw();
    })

}

function verArchivo(NombreArchivo, NombreAsignado, Formato) {
    var parametros = {
        NombreArchivo: NombreArchivo,
        NombreAsignado: NombreAsignado,
        Formato: Formato
    };
    $.ajax({
        url: "ValorDeclarado/ValidarDescarga",
        data: parametros,
        type: 'GET',
        success: function (data) {
            if (!data.esError) {
                window.location = "DescargarArchivo?NombreArchivo=" + NombreArchivo + "&NombreAsignado=" + NombreAsignado + "&Formato=" + Formato;
            } else {
                var errores = [];
                errores.push(data.mensaje);
                mostrarErrorArchivo(errores);
            }

        },
        failure: function (data) {
            $("#divError").empty().html(data);
            $("#divError").show();
        },
        error: function (data) {
            $("#divError").empty().html(data);
            $("#divError").show();
        }
    });


}


function getInsArchivos(frm) {

    let $json = [];
    let $rows = $("#tbArchivosAdjuntos tbody tr");
    let $cantCol = $rows.length; //-1 Quitando el ultimo registro de la fila del promedio y su valor.


    tableArchivos.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();

        let $obj = new Object();
        $obj.IdValorDeclarado = data.IdValorDeclarado;
        $obj.IdArchivo = data.IdArchivo;
        $obj.NombreArchivo = data.NombreArchivo;
        $obj.NombreAsignado = data.NombreAsignado;
        $obj.Formato = data.Formato;
        $obj.RutaArchivo = data.RutaArchivo;
        $obj.IdEstado = data.IdEstado;
        $json.push($obj);
    })

    $("#frmCRUDVD #ValorDeclaradoCabecera_ListaArchivo").val(JSON.stringify($json));

};

function getDelArchivos(frm) {
    $("#frmCRUDVD #ValorDeclaradoCabecera_ListaArchivoEliminado").val(JSON.stringify($registrosArchivoEliminar));
}

function validaCambioMoneda() {
    var errores = [];

    var count = $("#tbValorDeclaradoDetalle tbody tr").length;
    if (count > 1) {
        errores.push("- Para cambiar la Moneda, primero debe eliminar el Detalle del Valor Declarado");
        mostrarError(errores);
        return;
    }

    if ($('[id*=IdMoneda] option:selected').text() != "Dolares") {
        $(".TipoCambio").prop("disabled", true);
        $(".TipoCambio").val("");
    } else {
        $(".TipoCambio").prop("disabled", false);
    }

    if ($('[id*=IdMoneda] option:selected').text() == 'Soles') {
        $('#lblSimbolo').html('S/')
    }
    else if ($('[id*=IdMoneda] option:selected').text() == 'Dolares') {
        $('#lblSimbolo').html('$')
    }
}
var registrosError = "";
function jsLeerExcel() {

    var erroresDetalle = [];
    $("#divErrorDetalle").hide();
    $("#divErrorArchivo").hide();

    if ($("#IdTipoValorDeclarado option:selected").val() !== undefined && $("#IdTipoValorDeclarado option:selected").val() !== '') {


        var xhr = new XMLHttpRequest();
        var fd = new FormData();
        fd.append("File", document.getElementById("IdFileDetalle").files[0]);
        fd.append("IdTipoValorDeclarado", $("#IdTipoValorDeclarado").val());
        $.ajax({
            url: "ValorDeclarado/LeerExcel",
            data: fd,
            async: false,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {

                if (!data.esError) {
                    if (parseInt($("#IdTipoValorDeclarado").val()) === 3) {
                        $("#ValorDeclaradoDetalleComplementoVH").val(data.RegistroVDDC);
                    } else if (parseInt($("#IdTipoValorDeclarado").val()) === 2) {
                        $("#ValorDeclaradoDetalleComplementoTRAB").val(data.RegistroVDDC);
                    } else if (parseInt($("#IdTipoValorDeclarado").val()) === 1) {
                        $("#ValorDeclaradoDetalleComplementoPRAC").val(data.RegistroVDDC);
                    }

                    if (data.ArchivoIncorrecto === true) {
                        $('#IdVerDetalle').attr('disabled', 'disabled');
                        $('#IdVerDetalle').prop('disabled', true);

                        erroresDetalle.push(data.Mensaje);
                        mostrarErrorDetalle(erroresDetalle);
                        return;
                    } else if (parseInt(data.NroRegistrosError) === 0) {

                        erroresDetalle.push("-Archivo no contiene errores.");
                        erroresDetalle.push("-Total de Registros de Archivo: " + data.NroRegistrosTotal);
                        mostrarErrorDetalle(erroresDetalle);
                        $('#divErrorDetalle').removeClass('alert-danger')
                        $('#divErrorDetalle').addClass('alert-success')

                        $('#ValorDeclaradoDetalle_Cantidad').val(data.NroRegistrosTotal);
                        $('#ValorDeclaradoDetalle_ImporteValorDeclarado').val(data.Total);
                        $('#ValorDeclaradoDetalle_ImporteValorDeclarado').trigger('change');

                    } else {
                        erroresDetalle.push("-Archivo contiene errores pero puede procesarse. Ver archivo de Errores.");
                        erroresDetalle.push("-Total de Registros de Archivo: " + data.NroRegistrosTotal);
                        erroresDetalle.push("-Total de Registros Error: " + data.NroRegistrosError);


                        mostrarErrorDetalle(erroresDetalle);
                        registrosError = data.RegistrosError;
                        //CrearArchivoErrores(data.RegistrosError);
                    }

                    if ($("#IdVerDetalle").attr('data-mostrar') == 'true') {
                        $("#IdVerDetalle").prop('disabled', false)
                        if ($('#ValorDeclaradoDetalle_IdValorDeclaradoDetalle').val() > 0) {
                            $("#IdVerDetalle").attr('data-replace', true)
                        }
                    }
                } else {
                    var errores = [];
                    errores.push(data.mensaje);
                    mostrarErrorDetalle(errores);
                    $('#IdFileDetalle').val('');
                    $("#IdVerDetalle").prop('disabled', true);
                }


            },
            failure: function (data) {

                $("#divError").empty().html(data);
                $("#divError").show();

            },
            error: function (data) {

                $("#divError").empty().html(data);
                $("#divError").show();

            }
        });

    } else {
        erroresDetalle.push("- Debe seleccionar un Tipo de Valor Declarado");
        mostrarErrorDetalle(erroresDetalle);

    }
}

function CrearArchivoErrores(RegistrosError) {
    var parametros = {
        RegistrosError: RegistrosError
    };
    //var fd = new FormData();
    //fd.append("RegistrosError", RegistrosError);

    $.ajax({
        url: "ValorDeclarado/CrearArchivoErrores",
        data: parametros,
        type: "Post",
        success: function (data) {

            window.location = "ValorDeclarado/DescargarArchivoError?NombreArchivo=Errores&NombreAsignado=Errores&Formato=.txt";
        },
        failure: function (data) {
            $("#divError").empty().html(data);
            $("#divError").show();
        },
        error: function (data) {
            $("#divError").empty().html(data);
            $("#divError").show();
        }
    });
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

    $("#divErrorDetalle").hide();
    $("#divErrorArchivo").hide();

    $("#divError").empty().html(html);
    $("#divError").show();
}

function mostrarErrorDetalle(errores) {

    var html;

    //html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    html = "";

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }
    $("#divError").hide();
    $("#divErrorArchivo").hide();

    $("#divErrorDetalle").empty().html(html);
    $("#divErrorDetalle").show();
}

function mostrarErrorArchivo(errores) {

    var html;

    //html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    html = "";

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }
    $("#divError").hide();
    $("#divErrorDetalle").hide();

    $("#divErrorArchivo").empty().html(html);
    $("#divErrorArchivo").show();
}

function cambioUnidadMedida() {
    $("#divErrorDetalle").hide();
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val('');
    $("#ValorDeclaradoDetalle_Cantidad").val('');
}

function DevuelveFlagsPorIdTipoValorDeclarado() {
    $('#divErrorDetalle').removeClass('alert-success').addClass('alert-danger')

    $("#divErrorDetalle").hide();
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', false);
    $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', false);
    $("#IdUnidadMedida").prop('disabled', false);
    $("#IdFileDetalle").prop('disabled', false);
    $("#subir2").prop('disabled', false);
    $("#IdFileDetalle").val('');
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val('');
    $("#ValorDeclaradoDetalle_Cantidad").val('');
    $("#IdUnidadMedida").val('');

    $("#IdVerDetalle").attr('disabled', 'disabled');

    if ($("#IdTipoValorDeclarado option:selected").val() !== undefined && $("#IdTipoValorDeclarado option:selected").val() !== '') {

        $.ajax({
            type: 'GET',
            url: 'ValorDeclarado/DevuelveFlagsPorIdTipoValorDeclarado',
            data: {
                IdTipoValorDeclarado: parseInt($("#IdTipoValorDeclarado option:selected").val())
            },
            success: function (data) {

                if (typeof (data.AfectaCantidad) == 'undefined') {
                    $("#divFrontModal").find('.modal-dialog').removeAttr('style');
                    $("#divFrontModal").modal("show");
                    $("#divFrontModal #modalBody").empty().html(data);

                } else {
                    if (data.AfectaCantidad === false) {
                        $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', true);
                        $("#IdUnidadMedida").prop('disabled', true);
                    }
                    if (data.AfectaImporte === false) {
                        $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', true);
                    }

                    if (data.PermiteCargaDetalle === false) {

                        $("#IdFileDetalle").prop('disabled', true);
                        $("#subir2").prop('disabled', true);
                        $("#IdVerDetalle").attr('disabled', 'disabled');
                    } else {
                        $("#IdVerDetalle").attr('data-mostrar', true);
                    }

                }


            },
            error: function (data) {

                $("#divFrontModal").find('.modal-dialog').removeAttr('style');
                $("#divFrontModal").modal("show");

                //$("#divFrontModal #modalBody").empty().load(a.href);
                $("#divFrontModal #modalHeader h5").text("error en el servidor 500. verificar conexion");
            }
        });
    } else {
        $("#IdFileDetalle").prop('disabled', true);
        $("#subir2").prop('disabled', true);
        $("#IdFileDetalle").val('');
    }
}

function openModalVDDC() {
    //e.preventDefault();
    
    $("#divFrontModal").find('.modal-dialog').removeAttr('style');
    $("#divFrontModal").modal("show");
    //$("#divFrontModal #modalBody").empty().load(a.href);
    $("#divFrontModal #modalHeader h5").text("Detalle de Valor Declarado Complemento");
    //$("#divFrontModal #modalFooter").hide();

    //aqui

    if ($("#IdTipoValorDeclarado").val() == '3') {

        verFormVDDC();
    } else {
        verFormVDDC_Trab();
    }

}

function verFormVDDC() {
    var parametros = {
        IdValorDeclaradoDetalle:
            ($("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val() == '' || ($('#ValorDeclaradoDetalle_IdValorDeclaradoDetalle').val() != '0'
                && $("#IdVerDetalle").attr('data-replace') == 'true'))
                ? 0
                : $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(),
        IdTipoValorDeclarado: $("#IdTipoValorDeclarado option:selected").val()
    };
    $.ajax({
        type: "GET",
        url: "ValorDeclarado/VerValorDeclaradoDetalleComplementoVH",
        data: parametros,
        success: function (data) {
       
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
            $("#divFrontModal").attr('style', 'z-index:1051;background:#2f2d2d6b');
            $('#divFrontModal  [data-dismiss="modal"]').unbind('click')
            $('#divFrontModal  [data-dismiss="modal"]').on('click', function () {

                // do something…
                $('#divModal').removeAttr('style');
                $('#divModal').attr('style', 'display:block');
                $('body').css('overflow', 'hidden');
                $('#divFrontModal [data-dismiss="modal"]').unbind('click');
            })
            $('#divModal').attr('style', 'overflow:hidden;display:block');
            //actualizaDataTableDatalleComplemento(data);
        },
        error: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
        }
    });

}

function openModalVDDC_Trab() {
    //e.preventDefault();

    $("#divFrontModal").modal("show");
    verFormVDDC_Trab();
}

function verFormVDDC_Trab() {
    //
    var parametros = {
        IdValorDeclaradoDetalle: (
            $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val() == ''
            ||
            ($('#ValorDeclaradoDetalle_IdValorDeclaradoDetalle').val() != '0'
                && $("#IdVerDetalle").attr('data-replace') == 'true')
        ) ? 0 : $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(),
        IdTipoValorDeclarado: $("#IdTipoValorDeclarado option:selected").val()
    };
    $.ajax({
        type: "GET",
        url: "ValorDeclarado/VerValorDeclaradoDetalleComplementoTrab",
        data: parametros,
        success: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
            $("#divFrontModal").attr('style', 'z-index:1051;background:#2f2d2d6b')
            $('#divFrontModal  [data-dismiss="modal"]').unbind('click')
            $('#divFrontModal  [data-dismiss="modal"]').on('click', function () {

                // do something…
                $('#divModal').removeAttr('style');
                $('#divModal').attr('style', 'display:block');
                $('body').css('overflow', 'hidden');
                $('#divFrontModal [data-dismiss="modal"]').unbind('click');
            })
            $('#divModal').attr('style', 'overflow:hidden;display:block');
        },
        error: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
        }
    });

}

//archivo
function comprueba_extension(archivo) {

    if (typeof (document.getElementById('IdFileDetalle').files[0]) == 'undefined') {
        erroresDetalle.push("- Error no ha cargado ningun archivo");
        mostrarErrorDetalle(erroresDetalle);
        return;
    }
    $("#divErrorDetalle").hide();
    var archivo = document.getElementById('IdFileDetalle').files[0].name;
    var erroresDetalle = [];
    extensiones_permitidas = new Array(".xlsx", ".xls");
    mierror = "";
    if (!archivo) {
        erroresDetalle.push("- No has seleccionado ningún archivo");
        mostrarErrorDetalle(erroresDetalle);
    } else {
        $('#IdVerDetalle').removeAttr('disabled')
        //recupero la extensión de este nombre de archivo 
        extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase();
        //alert (extension); 
        //compruebo si la extensión está entre las permitidas 
        permitida = false;
        for (var i = 0; i < extensiones_permitidas.length; i++) {
            if (extensiones_permitidas[i] == extension) {
                permitida = true;
                break;
            }
        }
        if (!permitida) {
            mierror = "Comprueba la extensión de los archivos a subir. \nSólo se pueden subir archivos con extensiones: " + extensiones_permitidas.join();
            erroresDetalle.push("- Sólo se pueden subir archivos con extensiones: " + extensiones_permitidas.join());
            $("#IdFileDetalle").val('')
            mostrarErrorDetalle(erroresDetalle);
        } else {
            //submito! 
            //alert("Todo correcto. Voy a submitir el formulario.");

            return 1;
        }
    }
    return 0;
}

function blockPageLoad() {
    $.blockUI({
        message: '<h1><img  src="./images/loading.gif" height="150" width="150"/></h1>',
        css: {
            border: 'none',
            backgroundColor: 'transparent'
        }
    });
}

$(document).ready(function () {

    $('#subir').click(function () {

        $('#File').trigger('click');

    })
    $('#File').change(function () {
        adjuntarArchivo();
    })


    $('#subir2').click(function () {
        $('#IdFileDetalle').trigger('click');

    })
    $('#IdFileDetalle').change(function () {
        $('#divErrorDetalle').removeClass('alert-success').addClass('alert-danger')
        $("#IdVerDetalle").attr('disabled', 'disabled')
        comprueba_extension();
        jsLeerExcel();
        if (registrosError.length > 0) {
            $('#IdFileDetalle').val('');
            $("#IdVerDetalle").attr('disabled', 'disabled')
            CrearArchivoErrores(registrosError);
            registrosError = 0;
        }
    })

    $('#IdFileDetalle').click(function () {
        var erroresDetalle = [];
        if ($("#IdTipoValorDeclarado option:selected").text().trim() == 'Cantidad de Trabajadores'
            || $("#IdTipoValorDeclarado option:selected").text().trim() == 'Cantidad de Vehículos'
            || $("#IdTipoValorDeclarado option:selected").text().trim() == 'Cantidad de Practicantes') {
            if ($('#IdUnidadMedida').val() == '' || typeof ($('#IdUnidadMedida').val()) == 'undefined') {
                erroresDetalle.push("- seleccione una unidad de medida para cargar el archivo");
                mostrarErrorDetalle(erroresDetalle);
                return false;;
            }
        }

    })



})