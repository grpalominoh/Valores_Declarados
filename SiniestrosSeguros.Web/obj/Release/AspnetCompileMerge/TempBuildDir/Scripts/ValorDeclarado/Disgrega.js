
var $registrosEliminar = []
var $registrosArchivoEliminar = [];

$(document).ready(inicialize);

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

function inicialize() {
    let table;
    let tableArchivos;
    let listaArchivos = {};
    if ($("#ListaArchivo").val() !== "") {
        listaArchivos = JSON.parse($("#ListaArchivo").val());
    }
    inicializaTablaDetalleDisgrega();
    actualizaTablaArchivos(listaArchivos);
    edit();
    $("#divError").hide();
    $("#divErrorDisgregacion").hide();

    $('#idAgregar').click(function () {
        $("#divErrorDisgregacion").hide();
        agregarRegistroDisgregacion();
    });




    $("#frmDisgregarVD").submit(function (e) {

        e.preventDefault();
        submitFormVD(this);

    });

}
function edit() {

    var edit = $('#edit');
    if (edit.val() == 1) {
        $('#idAgregar').hide();
        $('#frmDisgregarVD button[type="submit"]').hide();

    }
}
function inicializaTablaDetalleDisgrega() {

    var datosTablaDetalle = {};

    if ($("#ListaDisgregacion").val() !== "") {
        datosTablaDetalle = JSON.parse($("#ListaDisgregacion").val());
    }

    table = $("#tbValorDeclaradoDetalleDisgregado").DataTable({
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
            { "data": "IdValorDeclaradoDetalleDisgregado" }, { "data": "IdValorDeclaradoDetalle" }, { "data": "IdTipoValorDeclarado" },
            { "data": "TipoValorDeclarado" }, { "data": "IdRamoPoliza" }, { "data": "RamoPoliza" }, { "data": "IdTipoPoliza" },
            { "data": "TipoPoliza" }, { "data": "IdMoneda" }, { "data": "Moneda" }, { "data": "Importe" }, { "data": "IdUnidadMedida" },
            { "data": "UnidadMedida" }, { "data": "Cantidad" }
        ],
        columnDefs: [
            {
                targets: [0, 1, 2, 4, 6, 8, 11],
                visible: false
            }, {

                className: "numeric-right",
                "targets": [10]
            },
            {

                className: "numeric-right",
                "targets": [13],
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.Cantidad);
                }
            },
            {
                className: "text-left",
                "targets": [3, 5]
            },
            {
                className: "text-center",
                "targets": 9
            },
            {
                className: "dt-body-center dt-body-width-5",
                targets: [14],
                render: function (data, type, row) {
                    row.Importe = siniestros.ReplaceNumberWithCommas(row.Importe);
                    var edit = $('#edit');
                    if (edit.val() == 0) {
                        return '<button type="button" onclick="javascript:eliminarRegistro(this)"  class="btn btn-danger AnularBtn ti-trash borrar" value="Eliminar"> </button> ';

                    } else {
                        return "";
                    }
                }
            }
        ]
    });

    table.rows().every(function (rowId, tableLoop, rowLoop) {

        var data = this.data();
        table.row(rowId).data(data).draw();
    })
}
function verArchivo(NombreArchivo, NombreAsignado, Formato) {
    var parametros = {
        NombreArchivo: NombreArchivo,
        NombreAsignado: NombreAsignado,
        Formato: Formato
    };

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
                mostrarError(errores);
                $('#divError').find('span').html('Error');
                $('#divError').addClass('alert-danger');
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

function actualizaTablaArchivos(listaArchivos) {
    tableArchivos = $("#tbArchivosAdjuntos").DataTable({
        data: listaArchivos,
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        processing: true,
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
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
                className: "dt-body-center dt-body-width-10",
                targets: [7],
                render: function (data, type, row) {

                    var edit = $('#edit');

                    if (edit.val() == 0) {
                        return "<button type='button' style='border-right-width: 1px;margin-right: 30px;margin-left: 150px;' class='btn btn-success AnularBtn ico-descargar' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>" +
                            " " + '<button type="button" onclick="javascript:eliminarRegistroArchivo(this)"  class="btn btn-danger AnularBtn ti-trash borrar" value="Eliminar"  /> ';
                    } else {
                        return "<button type='button' style='border-right-width: 1px;margin-right: 30px;margin-left: 150px;' class='btn btn-success AnularBtn ico-descargar' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>";
                    }

                }
            }
            //{
            //    className: "dt-body-center dt-body-width-5",
            //    targets: [7],
            //    render: function (data, type, row) {
            //        return "<button type='button' class='btn btn-success AnularBtn ico-descargar' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>";
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

function getInsArchivos() {

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

    $("#ListaArchivo").val(JSON.stringify($json));
};

function getDelArchivos() {
    $("#ListaArchivosEliminados").val(JSON.stringify($registrosArchivoEliminar));
}


function agregarRegistroDisgregacion() {

    var errores = [];
    var table = $("#tbValorDeclaradoDetalleDisgregado").DataTable();

    if ($("#selTipoValorDeclarado option:selected").val() === undefined || $("#selTipoValorDeclarado option:selected").val() === '') {
        errores.push("- Debe seleccionar un Tipo de Valor Declarado");
    } else if ($("#selRamoPoliza option:selected").val() === undefined || $("#selRamoPoliza option:selected").val() === '') {
        errores.push("- Debe seleccionar un Ramo de Poliza");
    } else if ($("#selTipoPoliza option:selected").val() === undefined || $("#selTipoPoliza option:selected").val() === '') {
        errores.push("- Debe seleccionar un Tipo de Poliza");
    } else if (!$("#txtImporte").prop('disabled') && ($("#txtImporte").val() === undefined || $("#txtImporte").val() === '' || $("#txtImporte").val() == 0)) {
        errores.push("- Debe ingresar Importe");
    } else if (!$("#txtCantidad").prop('disabled') && ($("#txtCantidad").val() === undefined || $("#txtCantidad").val() === '' || $("#txtCantidad").val() == 0)) {
        errores.push("- Debe ingresar Cantidad");
    }

    if (errores.length > 0) {
        mostrarErrorDisgregacion(errores);
    } else {

        var existeDuplicidad = false;
        var existeInconsistencia = false;

        var importe = 0;
        var cantidad = 0;

        table.rows().every(function (rowId, tableLoop, rowLoop) {
            var data = this.data();
            if ($("#selTipoValorDeclarado option:selected").val() == data.IdTipoValorDeclarado &&
                $("#selRamoPoliza option:selected").val() == data.IdRamoPoliza && $("#selTipoPoliza option:selected").val() == data.IdTipoPoliza) {
                errores.push("No se pueden duplicar los mismos tipos de valor declarado, ramo de poliza y tipo de poliza.");
                existeDuplicidad = true;
                return;
            }
        })

        if (existeDuplicidad) {
            mostrarErrorDisgregacion(errores);
            return;
        }

        if (!$("#txtImporte").prop('disabled')) {

            var tipoValorDeclaradoDesc = $("#selTipoValorDeclarado option:selected").html();

            $('#tbValorDeclaradoDetalleDisgregado').find('tr > td:first-child').each(function () {
                if ($(this).html().toUpperCase() == tipoValorDeclaradoDesc.toUpperCase()) {
                    importe += parseFloat(siniestros.resetComas($('#tbValorDeclaradoDetalleDisgregado').find('tr > td:nth-child(0n+5)').html()));
                }
            })
            importe = importe + parseFloat(siniestros.resetComas($("#txtImporte").val()))
            if (importe > parseFloat(siniestros.resetComas($("#ImporteValorDeclarado").val()))) {
                errores.push('El valor del total del importe de disgregación no debe superar el valor del importe que es ' + siniestros.ReplaceNumberWithCommas($("#ImporteValorDeclarado").val()));
                existeInconsistencia = true;
            }
        }

        if (!$("#txtCantidad").prop('disabled')) {
            table.column(13).data().each(function (valorCantidad, numFila) {
                if (table.row(numFila).data().IdTipoValorDeclarado == $("#selTipoValorDeclarado option:selected").val()) {
                    cantidad += parseFloat(valorCantidad);
                }
            });
            var cantidadTotal = parseFloat(cantidad) + parseFloat(siniestros.resetComas($("#txtCantidad").val()));
            if (cantidadTotal > parseFloat($("#Cantidad").val())) {
                errores.push('El valor del total de la cantidad no debe superar el valor de la cantidad que es ' + $("#Cantidad").val());
                existeInconsistencia = true;
            }
        }

        if (existeInconsistencia) {
            mostrarErrorDisgregacion(errores);
            return;
        }

        let $rows = $("#tbValorDeclaradoDetalleDisgregado tbody tr");
        let $last = $rows.length - 1;
        let $registroSiguiente = $rows.length + 1;

        var cantidad, importe;

        if ($("#txtCantidad").prop('disabled')) {
            cantidad = null;
        } else {
            cantidad = siniestros.resetComas($("#txtCantidad").val())
        }

        if ($("#txtImporte").prop('disabled')) {
            importe = null;
        } else {
            importe = siniestros.resetComas($("#txtImporte").val());
        }

        var filaNueva = {
            IdValorDeclaradoDetalleDisgregado: 0,
            IdValorDeclaradoDetalle: $("#IdValorDeclaradoDetalle").val(),
            IdTipoValorDeclarado: $("#selTipoValorDeclarado option:selected").val(),
            TipoValorDeclarado: $("#selTipoValorDeclarado option:selected").text(),
            IdRamoPoliza: $("#selRamoPoliza option:selected").val(),
            RamoPoliza: $("#selRamoPoliza option:selected").text(),
            IdTipoPoliza: $("#selTipoPoliza option:selected").val(),
            TipoPoliza: $("#selTipoPoliza option:selected").text(),
            Importe: siniestros.ReplaceNumberWithCommas(importe),
            Cantidad: cantidad,
            IdUnidadMedida: ($("#IdUnidadMedida").val() == '' ? null : $("#IdUnidadMedida").val()),
            UnidadMedida: $("#txtUnidadMedida").text(),
            IdMoneda: $("#IdMoneda").val(),
            Moneda: $("#txtMoneda").text(),
            Accion: '<td><button type="button" onclick="javascript:eliminarRegistro(this)" class="btn btn-default borrar" id="btnEditProg">Eliminar</button></td>'
        };

        table.row.add(filaNueva).draw();


        $("#selTipoValorDeclarado").val('');
        $("#selRamoPoliza").val('');
        $("#selTipoPoliza").val('');
        $("#txtImporte").val('');
        $("#txtCantidad").val('');
        $("#IdUnidadMedida").val(null);
        $("#txtUnidadMedida").empty();
        $("#IdValorDeclaradoDetalle").val('');
        $("#txtCantidad").prop('disabled', false);
        $("#txtImporte").prop('disabled', false);
        $("#txtCntReal").empty();
        $("#txtImpReal").empty();
    }
}

//aqui
function actualizaControlesTipoValorDeclarado() {
    $("#txtCantidad").prop('disabled', false);
    $("#txtImporte").prop('disabled', false);
    $('#divError').find('span').html('Advertencia');
    $('#divError').hide();

    console.log($("#selTipoValorDeclarado option:selected").val());
    if ($("#selTipoValorDeclarado option:selected").val() != '') {
        $.ajax({
            type: 'GET',
            url: 'ObtenerInfoTipoValorDeclarado',
            data: {
                IdTipoValorDeclarado: parseInt($("#selTipoValorDeclarado option:selected").val()),
                IdValorDeclarado: parseInt($("#IdValorDeclarado").val())
            },
            success: function (data) {
                if (!data.esError) {
                    if (data.AfectaCantidad === 0) {
                        $("#txtCantidad").prop('disabled', true);
                    }
                    if (data.AfectaImporte === 0) {
                        $("#txtImporte").prop('disabled', true);
                    }
                    $("#txtUnidadMedida").empty().append(data.UnidadMedida);
                    $("#IdUnidadMedida").val(data.IdUnidadMedida);
                    $("#Cantidad").val(data.Cantidad);

                    $("#ImporteValorDeclarado").val(data.ImporteValorDeclarado);
                    $("#txtCntReal").empty().append(data.Cantidad + " ").append($("#txtUnidadMedida").text());



                    if ($("#txtMoneda").text() == "Soles") {
                        $("#txtImpReal").empty().append("S/ ").append(siniestros.ReplaceNumberWithCommas(data.ImporteValorDeclarado));

                    } else {
                        $("#txtImpReal").empty().append("$ ").append(siniestros.ReplaceNumberWithCommas(data.ImporteValorDeclarado));

                    }

                    // $("#txtImpReal").empty().append(data.ImporteValorDeclarado);

                    $("#IdValorDeclaradoDetalle").val(data.IdValorDeclaradoDetalle);
                } else {
                    var errores = [];
                    errores.push(data.mensaje);
                    mostrarError(errores);
                    $('#divError').find('span').html('Error');
                    $('#divError').addClass('alert-danger');
                }


            },
            error: function (data) {

            }
        });
    } else {
        $("#txtCntReal").empty();
        $("#txtImpReal").empty();
    }

}

function actualizaTipoPoliza() {
    $.ajax({
        type: 'GET',
        url: 'ObtenerTiposPolizas',
        data: { IdTipoPoliza: parseInt($("#selRamoPoliza option:selected").val()) },
        success: function (data) {

            $("#lstFiltrosEvaluar #selTipoPoliza").empty();
            $("#lstFiltrosEvaluar #selTipoPoliza").append($('<option>').text("Seleccione...").attr('value', ''));

            for (var i = 0; i < data.length; i++)
                $("#lstFiltrosEvaluar #selTipoPoliza").append($('<option>').text(data[i].Descripcion).attr('value', data[i].IdDivisionPoliza));

        },
        error: function (data) {

        }
    });

}

function eliminarRegistro(registro) {
    siniestros.mensajeAlert(0, '¿Esta seguro en Eliminar la Poliza de la lista?', function () {
        let $row = $("#tbValorDeclaradoDetalleDisgregado").DataTable().row($(registro).parents("tr"));
        let $Id = $row.data().IdValorDeclaradoDetalleDisgregado;
        //solo guardamos los que tengan ID, los otro no son necesario porque nunca se guardaron en bbdd
        if ($Id > 0) {

            var data = $row.data();

            let $obj = new Object();
            $obj.IdValorDeclaradoDetalleDisgregado = data.IdValorDeclaradoDetalleDisgregado;
            $registrosEliminar.push($obj);
        }
        $row.remove().draw();
    })
}

function obtenerDisgregacionEliminados() {
    $("#ListaEliminadosDisgregacion").val(JSON.stringify($registrosEliminar));
}

function submitFormVD(frm) {
    var errores = [];
    obtenerDatosDisgregacion();
    obtenerDisgregacionEliminados();
    getInsArchivos();
    getDelArchivos();

    if ($("#ListaDisgregacion").val().length <= 2) {
        errores.push('Debe disgregar el valor declarado');
    }

    if (errores.length > 0) {
        mostrarError(errores);
        return;
    }

    var parametros = {
        ListaDisgregacion: $("#ListaDisgregacion").val(),
        IdValorDeclarado: $("#IdValorDeclarado").val(),
        ListaEliminadosDisgregacion: $("#ListaEliminadosDisgregacion").val(),
        EstadoValorDeclarado: $("#EstadoValorDeclarado").val(),
        ListaArchivos: $("#ListaArchivo").val(),
        ListaArchivosEliminados: $("#ListaArchivosEliminados").val()
    }

    $.ajax({
        type: frm.method,
        url: frm.action,
        data: parametros,
        success: function (data) {
            $("#divModal #modalBody").empty().html(data).fadeIn(500);
            actualizaDataTableNew("#tbValorDeclarado");
        },
        error: function (data) {
            $("#divModal #modalBody").empty().html(data).fadeIn(500);
        }
    });

}

function obtenerDatosDisgregacion() {

    let $json = [];
    let $rows = $("#tbValorDeclaradoDetalleDisgregado tbody tr");
    let $cantCol = $rows.length; //-1 Quitando el ultimo registro de la fila del promedio y su valor.
    table.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();
        let $obj = new Object();
        $obj.IdValorDeclaradoDetalleDisgregado = data.IdValorDeclaradoDetalleDisgregado;
        $obj.IdValorDeclaradoDetalle = data.IdValorDeclaradoDetalle;
        $obj.IdRamoPoliza = data.IdRamoPoliza;
        $obj.IdTipoPoliza = data.IdTipoPoliza;
        $obj.ImporteValorDeclarado = data.Importe;
        $obj.IdUnidadMedida = data.IdUnidadMedida;
        $obj.Cantidad = data.Cantidad;
        $obj.IdMoneda = data.IdMoneda;
        $json.push($obj);
    })

    $("#ListaDisgregacion").val(JSON.stringify($json));

}

function adjuntarArchivo() {
    var errores = [];

    if (document.getElementById("File").files[0] !== undefined) {

        var PesoFile = parseFloat(document.getElementById("File").files[0].size / 1024); //valor del archivo
        var MaxSizeArchivo = parseFloat($("#MaxSizeArchivo").val()); //valor del web.config

        if (PesoFile > MaxSizeArchivo) {
            errores.push("- Archivo muy pesado");
        }
        else {
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
                        actualizaTablaArchivos(data);
                    } else {
                        var errores = [];
                        errores.push(data.mensaje);
                        mostrarError(errores);
                        $('#divError').find('span').html('Error');
                        $('#divError').addClass('alert-danger');
                    }
                },
                failure: function (data) {

                },
                error: function (data) {
                    if (data.esError) {

                        var errores = [];
                        errores.push(data.mensaje);
                        mostrarError(errores);

                    }
                }
            });
        }
    } else {
        errores.push("- Debe seleccionar un archivo");
        mostrarError(errores);
    }
}

function mostrarError(errores) {
    $('#divError').removeClass('alert-danger');
    var html;
    if (errores.length == 1) {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    } else {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    }

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }
    $('#divError').addClass('alert-warning');
    $("#divError").empty().html(html);
    $("#divError").show();
}

function mostrarErrorDisgregacion(errores) {
    $('#divErrorDisgregacion').removeClass('alert-danger');
    var html;
    if (errores.length == 1) {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    } else {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    }

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }
    $('#divErrorDisgregacion').addClass('alert-warning');
    $("#divErrorDisgregacion").empty().html(html);
    $("#divErrorDisgregacion").show();
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

function triggerSubir() {
    //$('#subir').click(function () {       
    //    $('#File').trigger('click');
    //    adjuntarArchivo();
    //})
}


$(document).ready(function () {

    $('#subir').click(function () {
        $('#File').trigger('click');

    })

    $('#File').change(function () {
        adjuntarArchivo();
    })

    $('input').keypress(function (event) {

        if (window.event && window.event.keyCode == 13) {
            event.preventDefault();
        }
        return !(window.event && window.event.keyCode == 13);
    })
})