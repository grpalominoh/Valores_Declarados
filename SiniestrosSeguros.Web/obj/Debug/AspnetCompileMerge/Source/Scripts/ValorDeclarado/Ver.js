

var $registrosEliminar = [];
var $registrosArchivoEliminar = [];

$(document).ready(inicialize);

var waitingDialog = waitingDialog || (function ($) {
    'use strict';

    var $dialog = $(
        '<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-3" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">' +
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

    if ($("#frmCRUDVD #IdEmpresa").val() !== undefined && $("#frmCRUDVD #IdEmpresa").val() !== '') {
        $("#frmCRUDVD #IdEmpresa").attr("class", "form-control camboDisabled");
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
        return validarDecimales(e, this, 9, 2);
    });

    $("#ValorDeclaradoDetalle_Cantidad").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 2);
    });

    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").on('keypress', function (e) {
        return validarDecimales(e, this, 9, 2);
    });

    $("#frmCRUDVD").submit(function (e) {
        e.preventDefault();
        submitFormVD(this);
    });

    $('#idAgregar').click(function () {
        //waitingDialog.show(); 
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
    }

    //boton agregar debe estar activo al iniciar el VD
    $("#idModificar").prop('disabled', true);
    $("#idAgregar").prop('disabled', false);
    $("#IdVerDetalle").prop('disabled', true);

    if ($("#IdTipoValorDeclarado option:selected").val() === undefined || $("#IdTipoValorDeclarado option:selected").val() === '') {
        $("#IdFileDetalle").prop('disabled', true);
        $("#IdFileDetalle").val('');
    }

    $("#frmCRUDVD #ValorDeclaradoCabecera_TipoCambio").prop('disabled', true);
    $("#frmCRUDVD #ValorDeclaradoCabecera_FechaVigenciaIniModal").prop('disabled', true);
    $("#frmCRUDVD #ValorDeclaradoCabecera_FechaVigenciaFinModal").prop('disabled', true);
    $("#frmCRUDVD #IdEmpresa").prop('disabled', true);
    $("#frmCRUDVD #IdMoneda").prop('disabled', true);
    $("#frmCRUDVD #File").prop('disabled', true);
    $("#idAgregar").prop('disabled', true);
    $("#frmCRUDVDDetalle #IdTipoValorDeclarado").prop('disabled', true);
    $("#frmCRUDVDDetalle #IdUnidadMedida").prop('disabled', true);
    $("#frmCRUDVDDetalle #ValorDeclaradoDetalle_Cantidad").prop('disabled', true);
    $("#frmCRUDVDDetalle #ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', true);
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
    var tipoCambio = campo.value;
    var n = tipoCambio.indexOf(".");
    if (n > 0 && (tipoCambio.substring(n + 1) === undefined || tipoCambio.substring(n + 1) === '')) {
        campo.value = tipoCambio + '00';
    }
    campo.value = siniestros.ReplaceNumberWithCommas(campo.value);
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

        $.ajax({
            type: frm.method,
            url: frm.action,
            data: $(frm).serialize(),
            success: function (data) {
                $("#divModal #modalBody").empty().html(data).fadeIn(500);
                actualizaDataTableNew("#tbValorDeclarado");
            },
            error: function (data) {
                $("#divModal #modalBody").empty().html(data).fadeIn(500);
            }
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
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        processing: true,
        columns: [
            { "data": "IdValorDeclaradoDetalle" }, { "data": "IdTipoValorDeclarado" }, { "data": "TipoValorDeclaradoDesc" }, { "data": "IdUnidadMedida" },
            { "data": "UnidadMedidaDesc" }, { "data": "Cantidad" }, { "data": "ImporteValorDeclarado" }, { "data": "IdMoneda" }, { "data": "MonedaDesc" }, { "data": "FlagEdicion" }
        ],
        columnDefs: [
            {
                targets: [0, 1, 3, 7, 9],
                visible: false
            }, {

                className: "text-left",
                "targets": 2
            },
            {
                "width": "60px",
                className: "dt-body-center",
                "targets": 2
            },
            {
                "width": "60px",
                className: "dt-body-center",
                "targets": 4
            }, {

                className: "numeric-right",
                "targets": [6]
            },
            {
                "width": "20px",
                className: "dt-body-center",
                "targets": [8]
            }, {

                className: "numeric-right",
                "targets": [5],
                render: function (data, type, row) {
                    // row.Cantidad = siniestros.ReplaceNumberWithCommas(row.Cantidad);
                    return row.Cantidad;
                }
            },
            {
                targets: [6],
                render: function (data, type, row) {
                    row.ImporteValorDeclarado = siniestros.ReplaceNumberWithCommas(row.ImporteValorDeclarado);
                    return row.ImporteValorDeclarado;
                }
            },
            {
                className: "dt-body-center dt-body-width-5",
                targets: [10],
                render: function (data, type, row) {
                    return '<button type="button" onclick="javascript:editarRegistroDetalle(this)"  class="btn btn-primary botonOp ti-pencil-alt" value="Editar"  /> ';
                }
            }
            //{
            //    className: "dt-body-center dt-body-width-5",
            //    targets: [11],
            //    render: function (data, type, row) {
            //        return '<button type="button" onclick="javascript:eliminarRegistro(this)"  class="btn btn-danger AnularBtn ti-trash" value="Eliminar"  hidden/> ';
            //    }
            //}
        ]
    });

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
    } else if (!$('#IdUnidadMedida').is(':disabled')) {
        if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
            erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
        }
    }

    if ($("#ValorDeclaradoDetalle_Cantidad").val() !== undefined && $("#ValorDeclaradoDetalle_Cantidad").val() !== '') {
        if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
            erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
        }

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
    $("#IdFileDetalle").val('');
}

function eliminarRegistro(registro) {
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

}
var nroFila = 0;
function editarRegistroDetalle(registro) {

    var $d = $(registro).parent("td");
    nroFila = $d.parent().parent().children().index($d.parent()); //obtenemos numero de fila para despues modificarlo

    let $row = $("#tbValorDeclaradoDetalle").DataTable().row($(registro).parents("tr"));


    var data = $row.data();

    $("#IdTipoValorDeclarado").val(data.IdTipoValorDeclarado);
    DevuelveFlagsPorIdTipoValorDeclarado();
    $("#ValorDeclaradoDetalle_IdValorDeclaradoDetalle").val(data.IdValorDeclaradoDetalle);
    $("#IdUnidadMedida").val(data.IdUnidadMedida);
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val(data.ImporteValorDeclarado);
    $("#ValorDeclaradoDetalle_Cantidad").val(data.Cantidad);
    $("#IdTipoValorDeclarado").attr("class", "form-control camboDisabled");

    //deshabilitamos esta opcion para no confundir funcionalidad.
    $("#idAgregar").prop('disabled', true);
    $("#IdVerDetalle").prop('disabled', false);
    $("#idModificar").prop('disabled', true);
    $("#divError").hide();
    $("#divErrorDetalle").hide();

}

function modificarRegistroDetalle(registro) {
    alert('dd')
    var erroresDetalle = [];

    if ($("#IdMoneda").val() === undefined || $("#IdMoneda").val() === '') {
        erroresDetalle.push("- No ha seleccionado un Tipo de Moneda");
    } else if ($("#IdTipoValorDeclarado").val() === undefined || $("#IdTipoValorDeclarado").val() === '') {
        erroresDetalle.push("- Debe seleccionar un Tipo de Valor Declarado");
    } else if (!$('#IdUnidadMedida').is(':disabled')) {
        if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
            erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
        }
    }

    if ($("#ValorDeclaradoDetalle_Cantidad").val() !== undefined && $("#ValorDeclaradoDetalle_Cantidad").val() !== '' && $("#ValorDeclaradoDetalle_Cantidad").val() !== '0') {
        if ($("#IdUnidadMedida").val() === undefined || $("#IdUnidadMedida").val() === '') {
            erroresDetalle.push("- Debe seleccionar una Unidad de Medida");
        }

    }

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
            Cantidad: siniestros.resetComas($("#ValorDeclaradoDetalle_Cantidad").val()),
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

        $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', false);
        $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', false);
        $("#IdUnidadMedida").prop('disabled', false);
        $("#IdFileDetalle").prop('disabled', true);
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
        $obj.ImporteValorDeclarado = data.ImporteValorDeclarado;
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
    if (document.getElementById("File").files[0] !== undefined) {
        var PesoFile = parseFloat(document.getElementById("File").files[0].size / 1024); //valor del archivo
        var MaxSizeArchivo = parseFloat($("#MaxSizeArchivo").val()); //valor del web.config

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
                url: "AdjuntarArchivo",
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
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        processing: true,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        columns: [
            { "data": "IdValorDeclarado" }, { "data": "IdArchivo" }, { "data": "NombreArchivo" }, { "data": "NombreAsignado" },
            { "data": "Formato" }, { "data": "RutaArchivo" }, { "data": "IdEstado" }
        ],
        columnDefs: [
            {
                targets: [0, 1, 3, 4, 5, 6],
                visible: false
            },
            {
                className: "dt-body-center dt-body-width-8",
                targets: [7],
                render: function (data, type, row) {
                    return "<button type='button' class='btn btn-success AnularBtn ico-descargar'  onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga' >";
                    + '<button type="button" onclick="javascript:eliminarRegistroArchivo(this)"  class="btn btn-danger AnularBtn ti-trash borrar" value="Eliminar" hidden /> ';
                }
            },
            //{
            //    className: "dt-body-center dt-body-width-5",
            //    targets: [7],
            //    render: function (data, type, row) {
            //        return "<button type='button' class='btn btn-success AnularBtn ico-descargar'  onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga' >";
            //    }
            //}
        ]
    });
}

function eliminarRegistroArchivo(registro) {
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
}

function verArchivo(NombreArchivo, NombreAsignado, Formato) {
    var parametros = {
        NombreArchivo: NombreArchivo,
        NombreAsignado: NombreAsignado,
        Formato: Formato
    };
    $.ajax({
        url: "ValidarDescarga",
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
            url: "LeerExcel",
            data: fd,
            async: false,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
                //waitingDialog.hide(); 
                if (!data.esError) {
                    if (parseInt($("#IdTipoValorDeclarado").val()) === 3) {
                        $("#ValorDeclaradoDetalleComplementoVH").val(data.RegistroVDDC);
                    } else if (parseInt($("#IdTipoValorDeclarado").val()) === 2) {
                        $("#ValorDeclaradoDetalleComplementoTRAB").val(data.RegistroVDDC);
                    } else if (parseInt($("#IdTipoValorDeclarado").val()) === 1) {
                        $("#ValorDeclaradoDetalleComplementoPRAC").val(data.RegistroVDDC);
                    }

                    if (data.ArchivoIncorrecto === true) {
                        erroresDetalle.push(data.Mensaje);
                        mostrarErrorDetalle(erroresDetalle);
                    } else if (parseInt(data.NroRegistrosError) === 0) {

                        erroresDetalle.push("-Archivo no contiene errores.");
                        erroresDetalle.push("-Total de Registros de Archivo: " + data.NroRegistrosTotal);
                        mostrarErrorDetalle(erroresDetalle);

                    } else {
                        erroresDetalle.push("-Archivo contiene errores pero puede procesarse. Ver archivo de Errores.");
                        erroresDetalle.push("-Total de Registros de Archivo: " + data.NroRegistrosTotal);
                        erroresDetalle.push("-Total de Registros Error: " + data.NroRegistrosError);
                        mostrarErrorDetalle(erroresDetalle);
                        registrosError = data.RegistrosError;
                        //CrearArchivoErrores(data.RegistrosError);
                    }
                } else {
                    erroresDetalle.push(data.mensaje);
                    mostrarError(erroresDetalle);
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
        url: "CrearArchivoErrores",
        data: parametros,
        type: "Post",
        success: function (data) {

            window.location = "DescargarArchivo?NombreArchivo=Errores&NombreAsignado=Errores&Formato=.txt";
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

    $("#divErrorDetalle").hide();
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', false);
    $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', false);
    $("#IdUnidadMedida").prop('disabled', false);
    $("#IdFileDetalle").prop('disabled', false);
    $("#IdFileDetalle").val('');
    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").val('');
    $("#ValorDeclaradoDetalle_Cantidad").val('');
    $("#IdUnidadMedida").val('');


    if ($("#IdTipoValorDeclarado option:selected").val() !== undefined && $("#IdTipoValorDeclarado option:selected").val() !== '') {

        $.ajax({
            type: 'GET',
            url: 'DevuelveFlagsPorIdTipoValorDeclarado',
            data: {
                IdTipoValorDeclarado: parseInt($("#IdTipoValorDeclarado option:selected").val())
            },
            success: function (data) {

                if (data.AfectaCantidad === false) {
                    $("#ValorDeclaradoDetalle_Cantidad").prop('disabled', true);
                    $("#IdUnidadMedida").prop('disabled', true);
                }
                if (data.AfectaImporte === false) {
                    $("#ValorDeclaradoDetalle_ImporteValorDeclarado").prop('disabled', true);
                }

                if (data.PermiteCargaDetalle === false) {
                    $('#IdVerDetalle').prop('disabled', true);
                    $("#IdFileDetalle").prop('disabled', true);
                }
            },
            error: function (data) {

            }
        });
    } else {
        $("#IdFileDetalle").prop('disabled', true);
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

    if ($("#IdTipoValorDeclarado").val() === '3') {
        verFormVDDC();
    } else {
        verFormVDDC_Trab();
    }

}

function verFormVDDC() {
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
        url: "VerValorDeclaradoDetalleComplementoVH",
        data: parametros,
        success: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
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
        url: "VerValorDeclaradoDetalleComplementoTrab",
        data: parametros,
        success: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
        },
        error: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
        }
    });

}

//archivo
function comprueba_extension(archivo) {

    $("#divErrorDetalle").hide();
    var archivo = document.getElementById('IdFileDetalle').files[0].name;
    var erroresDetalle = [];
    extensiones_permitidas = new Array(".xlsx", ".xls");
    mierror = "";
    if (!archivo) {
        erroresDetalle.push("- No has seleccionado ningún archivo");
        mostrarErrorDetalle(erroresDetalle);
    } else {
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