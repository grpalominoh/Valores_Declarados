
$(document).ready(inicialize);

function inicialize() {
    console.log("VDDC");
    $("#divErrorComplemento").hide();
    var parametros = {
        IdValorDeclaradoDetalle: ($('#informe_IdValorDeclaradoDetalle').val() == ''
            || $('#informe_IdValorDeclaradoDetalle').val() == 0) ? 0
            : $('#informe_IdValorDeclaradoDetalle').val(),
        IdTipoValorDeclarado: $('#IdTipoValorDeclarado').val()

    };

    $.ajax({
        type: "POST",
        url: "VerValorDeclaradoDetalleComplementoVeHiculo",
        data: parametros,
        success: function (data) {
            var erroresDetalle = [];
            if (data === undefined || data === '' || data.length === 0) {
                erroresDetalle.push("Aún no ha cargado información para este Tipo de Valor Declarado.");
                mostrarErrorComplemento(erroresDetalle);
                actualizaDataTableDatalleComplemento(data);
            } else {
                actualizaDataTableDatalleComplemento(data);
            }

        },
        error: function (data) {
            $("#divFrontModal #modalBody").empty().html(data).fadeIn(500);
        }
    });


}

function actualizaDataTableDatalleComplemento(datosTablaDetalleTmp) {
    console.log("llega");
    var datosTablaDetalle = {};

    datosTablaDetalle = datosTablaDetalleTmp;

    var informe_IdValorDeclaradoDetalle = $('#informe_IdValorDeclaradoDetalle').val();

    $("#tbValorDeclaradoDetalleComplemento").DataTable({
        data: datosTablaDetalle,
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        processing: true,
        columns: [
            { "data": "IdUUNN" }, { "data": "UnidadNegocio" }, { "data": "IdCentroCosto" }, { "data": "CentroCosto" }
            , { "data": "NroPlaca" }, { "data": "SerieMotor" }, { "data": "SerieCarroceria" }, { "data": "idMarca" }
            , { "data": "Marca" }, { "data": "idModelo" }, { "data": "Modelo" }, { "data": "AnoFabricacion" }
            , { "data": "Clase" }, { "data": "Ocupantes" }, { "data": "TimonCambiado" }, { "data": "FechaInicio" }
            , { "data": "FechaTermino" }, { "data": "idMoneda" }, { "data": "Moneda" }, { "data": "ValorDeclarado" }
        ],
        columnDefs: [
            {

                "targets": [0, 2, 7, 9, 17],
                visible: informe_IdValorDeclaradoDetalle > 0 ? false : true
            },
            {
                "targets": [1, 3, 8, 10, 18],
                visible: informe_IdValorDeclaradoDetalle == "0" ? false : true
            }, {
                "targets": [19],         
                className: "numeric-right",
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.ValorDeclarado);
                }
            },
        ]
    });

}

function mostrarErrorComplemento(errores) {

    var html;

    //html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    html = "";

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }

    $("#divErrorComplemento").empty().html(html);
    $("#divErrorComplemento").show();
} 