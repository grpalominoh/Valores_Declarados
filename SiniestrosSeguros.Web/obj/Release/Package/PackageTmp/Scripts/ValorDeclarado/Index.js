/// <reference path="../_namespace.js" />
$(document).ready(inicialize);

function inicialize() {


    $('#IdEnviar').click(function () {
        $('#tbValorDeclarado').DataTable().clear();
        $('#tbValorDeclarado').DataTable().destroy();
        actualizaDataTableNew("#tbValorDeclarado");
    });
    actualizaDataTableNew("#tbValorDeclarado");

    $("a.InModal").click(function (e) {

        openModal(this, e);
    });

    $("#frmBusqValorDeclarado #FechaVigenciaIni").datepicker(
        {
            dateFormat: 'dd/mm/yy',
            onClose: function (selectedDate) {
                $("#frmBusqValorDeclarado #FechaVigenciaFin").datepicker("option", "minDate", selectedDate);
            },
            language: 'es'
        });

    $("#frmBusqValorDeclarado #FechaVigenciaFin").datepicker(
        {
            dateFormat: 'dd/mm/yy',
            onClose: function (selectedDate) {
                $("#frmBusqValorDeclarado #FechaVigenciaIni").datepicker("option", "maxDate", selectedDate);
            }
        });

    $("#divErrorIndex").hide();
}

function actualizaDataTableNew(table) {

    var IdEmpresa = ($('#IdEmpresa').val() !== null && $('#IdEmpresa').val() !== '') ? $('#IdEmpresa').val() : '0';
  
    var FechaVigenciaIni = ($('#FechaVigenciaIni').val().trim() == '') ? '01/01/1900' : $('#FechaVigenciaIni').val();
    var FechaVigenciaFin = ($('#FechaVigenciaFin').val().trim() == '') ? '01/01/9999': $('#FechaVigenciaFin').val() ;
    var IdEstado = ($('#IdEstado').val() !== null && $('#IdEstado').val() !== '') ? $('#IdEstado').val() : '0';
    $(table).DataTable({
        "bDestroy": true,
        searching: false,
        lengthChange: false,
        responsive: true,
        sort: false,
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        "processing": true,
        "serverSide": true,
        "ajax": {
            url: "ValorDeclarado/List?IdEmpresa=" + IdEmpresa + "&FechaVigenciaIni=" + FechaVigenciaIni + "&FechaVigenciaFin=" + FechaVigenciaFin + "&IdEstado=" + IdEstado,
            async: true,
        },
        "preDrawCallback": function (settings) {
            var api = this.api();
            // Output the data for the visible rows to the browser's console
            var valor = parseInt(api.page()) + 1;
           

        },
        "drawCallback": function (settings) {
            var api = this.api();
            var valor = parseInt(api.page()) + 1;
            // Output the data for the visible rows to the browser's console
        
        },
        //order: [0, 'desc'],
        //ajax: {
        //    url: "List?IdEmpresa=" + IdEmpresa + "&FechaVigenciaIni=" + FechaVigenciaIni + "&FechaVigenciaFin=" + FechaVigenciaFin + "&IdEstado=" + IdEstado,
        //    dataSrc: "",
        //    contentType: 'application/json; charset=utf-8',
        //    dataType: 'json',
        //    error: function (data) {
        //        $("#divModal").modal("show");
        //        $("#divModal #modalHeader h5").text("Lista de tipos de valores declarados");
        //        $("#divModal #modalBody").empty().html("¡Advertencia, por favor intente nuevamente!");
        //        $('#dviLstProg').empty();
        //    }

        columns: [
            { "data": "IdValorDeclarado" },
            { "data": "DescEmpresa" },
            { "data": "FechaVigenciaIni" },
            { "data": "FechaVigenciaIniText" },
            { "data": "FechaVigenciaFin" },
            { "data": "FechaVigenciaFinText" },
            { "data": "IdMoneda" },
            { "data": "DescMoneda" },
            { "data": "TipoCambio" },
            { "data": "DescEstado" }
        ],
        columnDefs: [
            {
                targets: [0, 2, 4, 6],
                visible: false
            },
            {
                "width": "20%",
                "targets": 1,
                className: "text-left",
            },
            {
                "width": "8%",
                className: "dt-body-center",
                "targets": [3, 5, 7, 8, 9]
            },
            {
                targets: 10,
                "width": "8%px",
                data: "Anular",
                className: "text-left",
                render: function (data, type, row, meta) {

                    var retorno = "";
                    if (row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase() || row.DescEstado.toUpperCase() === ("Registrado").toUpperCase() || row.DescEstado.toUpperCase() === ("Disgregado").toUpperCase()) {
                        retorno = "<button title='Anular Valor Declarado' type='button' class='btn btn-danger AnularBtn pe-7s-close-circle' onclick='anular(" + row.IdValorDeclarado + ")' id='btnEditProg'>" +
                            " </button>";
                    }
                    if (row.DescEstado.toUpperCase() === ("Registrado").toUpperCase()) {
                        retorno = retorno + " " + "<a title='Editar Valor Declarado' class='btn btn-primary botonOp ti-pencil-alt InModal'" +
                            "href='Edit?IdValorDeclarado=" + row.IdValorDeclarado + "' onclick='openModal(this,event)'> </a>";
                    }
                    if (row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase() ||
                        row.DescEstado.toUpperCase() === ("Disgregado").toUpperCase() ||
                        row.DescEstado.trim().toUpperCase() === ("Autorizado").toUpperCase() ||
                        row.DescEstado.toUpperCase() === ("Autorización en Proceso").toUpperCase()) {
                        retorno = retorno + " " + "<a title='Ajustar Valor Declarado' class='btn btn-primary AnularBtn pe-7s-tools' onclick='showModalAjuste(" + row.IdValorDeclarado + ",\"" + row.DescEstado.toUpperCase() + "\")'> </a>"
                    }
                    if (row.DescEstado.toUpperCase() === ("Disgregado").toUpperCase() ||
                        row.DescEstado.toUpperCase() === ("Registrado").toUpperCase() ||
                        row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase() ||
                        row.DescEstado.trim().toUpperCase() === ("Autorizado").toUpperCase() ||
                        row.DescEstado.toUpperCase() === ("Autorización en Proceso").toUpperCase()) {
                        retorno = retorno + " " + "<a title='Disgregar Valor Declarado' class='btn btn-warning DisgregarBtn pe-7s-less' onclick='showModalDisgrega(" + row.IdValorDeclarado + ", " + row.IdMoneda + ", \"" + row.DescMoneda + "\", \"" + row.NombreCortoEmpresa + "\", \"" + row.DescEstado + "\")'> </a>";
                    }
                    if (row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase()) {
                        retorno = retorno + " " + "<button title='Autorizar Valores AJUSTADOS' type='button' class='btn btn-success VerBtn ti-check-box' onclick='autorizar(" + row.IdValorDeclarado + ")' id='btnAut'>" +
                            " </button>";
                    } else if (row.DescEstado.trim().toUpperCase() === ("Autorización en Proceso").toUpperCase()) {
                        retorno = retorno + " " + "<button title='Solicitar Autorización' type='button' class='btn btn-warning DisgregarBtn ti-email' onclick='solicitarAutorizacion(" + row.IdValorDeclarado + ")' id='btnSolAut'>" +
                            " </button>";
                    }

                    retorno = retorno + " " + "<a title='Ver Valor Declarado' class='btn btn-success VerBtn ti-eye' href='Ver?IdValorDeclarado=" + row.IdValorDeclarado + "' onclick='openModal(this,event)'> </a>";

                    return retorno;

                }
            }


        ]
    });

    //$(table).DataTable({
    //    "bDestroy": true,
    //    searching: true,
    //    lengthChange: false,
    //    responsive: true,
    //    sort: false,
    //    language: {
    //        "url": "../../Scripts/DataTables/Spanish.json"
    //    },
    //    processing: true,
    //    order: [0, 'desc'],
    //    ajax: {
    //        url: "List?IdEmpresa=" + IdEmpresa + "&FechaVigenciaIni=" + FechaVigenciaIni + "&FechaVigenciaFin=" + FechaVigenciaFin + "&IdEstado=" + IdEstado,
    //        dataSrc: "",
    //        contentType: 'application/json; charset=utf-8',
    //        dataType: 'json',
    //        error: function (data) {
    //            $("#divModal").modal("show");
    //            $("#divModal #modalHeader h5").text("Lista de tipos de valores declarados");
    //            $("#divModal #modalBody").empty().html("¡Advertencia, por favor intente nuevamente!");
    //            $('#dviLstProg').empty();
    //        }
    //    },
    //    columns: [
    //        { "data": "IdValorDeclarado" }, { "data": "DescEmpresa" }, { "data": "FechaVigenciaIni" },
    //        { "data": "FechaVigenciaIniText" }, { "data": "FechaVigenciaFin" }, { "data": "FechaVigenciaFinText" },
    //        { "data": "IdMoneda" }, { "data": "DescMoneda" }, { "data": "TipoCambio" }, { "data": "DescEstado" }
    //    ],
    //    columnDefs: [
    //        {
    //            targets: [0, 2, 4, 6],
    //            visible: false
    //        },
    //        {
    //            "width": "20%",
    //            "targets": 1
    //        },
    //        {
    //            "width": "8%",
    //            className: "dt-body-center",
    //            "targets": [3, 5, 7, 8, 9]
    //        },
    //        {
    //            targets: 10,
    //            "width": "8%px",
    //            data: "Anular",

    //            render: function (data, type, row, meta) {

    //                var retorno = "";
    //                if (row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase() || row.DescEstado.toUpperCase() === ("Registrado").toUpperCase() || row.DescEstado.toUpperCase() === ("Disgregado").toUpperCase()) {
    //                    retorno = "<button title='Anular Valor Declarado' type='button' class='btn btn-danger AnularBtn pe-7s-close-circle' onclick='anular(" + row.IdValorDeclarado + ")' id='btnEditProg'>" +
    //                        " </button>";
    //                }
    //                if (row.DescEstado.toUpperCase() === ("Registrado").toUpperCase()) {
    //                    retorno = retorno + " " + "<a title='Editar Valor Declarado' class='btn btn-primary botonOp ti-pencil-alt InModal'" +
    //                        "href='Edit?IdValorDeclarado=" + row.IdValorDeclarado + "' onclick='openModal(this,event)'> </a>";
    //                }
    //                if (row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase() ||
    //                    row.DescEstado.toUpperCase() === ("Disgregado").toUpperCase() ||
    //                    row.DescEstado.toUpperCase() === ("Autorización en Proceso").toUpperCase()) {
    //                    retorno = retorno + " " + "<a title='Ajustar Valor Declarado' class='btn btn-primary AnularBtn pe-7s-tools' onclick='showModalAjuste(" + row.IdValorDeclarado + ",\"" + row.DescEstado.toUpperCase() +"\")'> </a>"
    //                }
    //                if (row.DescEstado.toUpperCase() === ("Disgregado").toUpperCase() ||
    //                    row.DescEstado.toUpperCase() === ("Registrado").toUpperCase() ||
    //                    row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase() ||
    //                    row.DescEstado.toUpperCase() === ("Autorización en Proceso").toUpperCase()) {
    //                    retorno = retorno + " " + "<a title='Disgregar Valor Declarado' class='btn btn-warning DisgregarBtn pe-7s-less' onclick='showModalDisgrega(" + row.IdValorDeclarado + ", " + row.IdMoneda + ", \"" + row.DescMoneda + "\", \"" + row.NombreCortoEmpresa + "\", \"" + row.DescEstado + "\")'> </a>";
    //                }
    //                if (row.DescEstado.trim().toUpperCase() === ("Ajustado").toUpperCase()) {
    //                    retorno = retorno + " " + "<button title='Autorizar Valores AJUSTADOS' type='button' class='btn btn-success VerBtn ti-check-box' onclick='autorizar(" + row.IdValorDeclarado + ")' id='btnAut'>" +
    //                        " </button>";
    //                } else if (row.DescEstado.trim().toUpperCase() === ("Autorización en Proceso").toUpperCase()) {
    //                    retorno = retorno + " " + "<button title='Solicitar Autorización' type='button' class='btn btn-warning DisgregarBtn ti-email' onclick='solicitarAutorizacion(" + row.IdValorDeclarado + ")' id='btnSolAut'>" +
    //                        " </button>";
    //                }

    //                retorno = retorno + " " + "<a title='Ver Valor Declarado' class='btn btn-success VerBtn ti-eye' href='Ver?IdValorDeclarado=" + row.IdValorDeclarado + "' onclick='openModal(this,event)'> </a>";

    //                return retorno;

    //            }
    //        }


    //    ]
    //});

}

//function formattedDate(d) {
//    if (d !== 'undefined') {
//        let month = String(d.getMonth() + 1);
//        let day = String(d.getDate());
//        const year = String(d.getFullYear());

//        if (month.length < 2) month = '0' + month;
//        if (day.length < 2) day = '0' + day;

//        return ${month}/${day}/${year};
//    } else {
//        return "";
//    }
//}


function openModal(a, e) {
    e.preventDefault();
    $("#tbValorDeclaradoDetalle").DataTable().destroy();

    $("#divModal").modal("show");
    $("#divModal #modalBody").empty().load(a.href);
    $("#divModal #modalHeader h5").text(a.title);
    $("#divModal #modalFooter").hide();


}

function showModalAjuste(idValorDeclarado, estado) {

    var parametros = {
        IdValorDeclarado: idValorDeclarado,
        edit: (estado.toUpperCase() == 'AUTORIZACIÓN EN PROCESO' || estado.toUpperCase() == 'AUTORIZADO') ?1 : 0
    };
    $.ajax({
        type: 'GET',
        url: 'ValorDeclarado/Ajuste',
        data: parametros,
        success: function (data) {
            $("#divModal").modal("show");
            $("#divModal #modalHeader h5").text("Ajustar Valor Declarado");
            $("#divModal #modalBody").empty().html(data);
            $("#divModal #modalFooter").hide();
        },
        error: function (data) {

        }
    });

}


function showModalDisgrega(idValorDeclarado, idMoneda, moneda, empresa, estado) {
     
    var parametros = {
        IdValorDeclarado: idValorDeclarado,
        IdMoneda: idMoneda,
        DescMoneda: moneda,
        DescEmpresa: empresa,
        DescEstado: estado,
        edit: estado.toUpperCase() == 'AUTORIZACIÓN EN PROCESO' ? 1 : 0
    };
    if (estado.toUpperCase() == 'REGISTRADO' || estado.toUpperCase() == 'DISGREGADO'
        || estado.toUpperCase() == 'AUTORIZACIÓN EN PROCESO') {

        $.ajax({
            type: 'GET',
            url: 'ValorDeclarado/Disgrega',
            data: parametros,
            success: function (data) {

                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Disgregar Valor Declarado");
                $("#divModal #modalBody").empty().html(data);
                $("#divModal #modalFooter").hide();
            },
            error: function (data) {

            }
        });
    } else if (estado.trim().toUpperCase() == 'AJUSTADO'
        || estado.trim().toUpperCase() == 'AUTORIZADO') {

        $.ajax({
            type: 'GET',
            url: 'ValorDeclarado/VerDisgregar',
            data: parametros,
            success: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Ver Disgregación Valor Declarado");
                $("#divModal #modalBody").empty().html(data);
                $("#divModal #modalFooter").hide();
            },
            error: function (data) {

            }
        });
    }


}

function anular(idVD) {

    var parametros = {
        IdValorDeclarado: idVD
    };

    siniestros.mensajeAlert(1, '¿Está Seguro de Anular el Valor Declarado?', function () {

        $.ajax({
            type: 'POST',
            url: 'ValorDeclarado/Anular',
            data: parametros,
            success: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Anular Valor Declarado");
                $("#divModal #modalBody").empty().html(data);
                $("#divModal #modalFooter").hide();
                actualizaDataTableNew("#tbValorDeclarado");
            },
            error: function (data) {
                var errores = [];
                errores.push("Ocurrió un error en la anulación");
                mostrarErrorIndex(errores);

            }
        });
    }, null)

}

function autorizar(idVD) {

    var parametros = {
        IdValorDeclarado: idVD
    };

    $.ajax({
        type: 'POST',
        url: 'ValorDeclarado/Autorizar',
        data: parametros,
        success: function (data) {
            $("#divModal").modal("show");
            $("#divModal #modalHeader h5").text("Autorizar Valores AJUSTADOS");
            $("#divModal #modalBody").empty().html(data);
            $("#divModal #modalFooter").hide();
            actualizaDataTableNew("#tbValorDeclarado");
        },
        error: function (data) {

        }
    });
}

function solicitarAutorizacion(IdValorDeclarado, estado) {

    var parametros = {
        IdValorDeclarado: IdValorDeclarado
    };

    $.ajax({
        type: 'POST',
        url: 'ValorDeclarado/SolicitarAutorizacion',
        data: parametros,
        success: function (data) {            
            $("#divModal").modal("show");
            $("#divModal #modalHeader h5").text("Autorizar Valores AJUSTADOS");
            $("#divModal #modalBody").empty().html(data);
            $("#divModal #modalFooter").hide();
            $("#divModal").find('.close').click(function () {
                $("#divModal").removeAttr('style')
            })
            actualizaDataTableNew("#tbValorDeclarado");
        },
        error: function (data) {

        }
    });
}

function mostrarErrorIndex(errores) {
    var html;
    if (errores.length === 1) {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    } else {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    }

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }

    $("#divErrorIndex").empty().html(html);
    $("#divErrorIndex").show();
}
