
$(document).ready(inicialize);

function inicialize() {
 
    $("#divErrorComplemento").hide();

    var parametros = {
        IdValorDeclaradoDetalle: ($('#informe_IdValorDeclaradoDetalle').val() == ''
            || $('#informe_IdValorDeclaradoDetalle').val() == 0) ? 0
            : $('#informe_IdValorDeclaradoDetalle').val(),
        IdTipoValorDeclarado: $('#IdTipoValorDeclarado').val()

    };

    $.ajax({
        type: "POST",
        url: "ValorDeclarado/VerValorDeclaradoDetalleComplementoTrab",
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
   
    var datosTablaDetalle = {};

    datosTablaDetalle = datosTablaDetalleTmp;

    var informe_IdValorDeclaradoDetalle = $('#informe_IdValorDeclaradoDetalle').val();
    var IdTipoValorDeclarado = $('input[id="IdTipoValorDeclarado"]').val();

    $("#tbValorDeclaradoDetalleComplemento").DataTable({
        data: datosTablaDetalle,
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        processing: true,
        columns: [
            { "data": "Nombre" }, { "data": "ApellidoPaterno" }, { "data": "ApellidoMaterno" }, { "data": "DNI" },
            { "data": "FechaNacimiento" }, { "data": "FechaIngreso" }, { "data": "idCargo" }, { "data": "cargo" }
            , { "data": "idArea" }, { "data": "area" }, { "data": "idNivelRiesgo" }, { "data": "riesgo" }, { "data": "idTipoPlanilla" }
            , { "data": "planilla" }, { "data": "RemuneracionMensual" }, { "data": "Graticiacion" }, { "data": "SubvencionMensual" }
        ],
        columnDefs: [
            {
                "targets": [16],
                className: "numeric-right",
                visible: IdTipoValorDeclarado == '1' ? true : false,
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.SubvencionMensual);
                }
            },
            {
                "targets": [14],
                className: "numeric-right",
                visible: IdTipoValorDeclarado == '1' ? false : true,
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.RemuneracionMensual);
                }
            },
            {
                "targets": [15],
                className: "numeric-right",
                visible: IdTipoValorDeclarado == '1' ? false : true,
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.Graticiacion);
                }
            },
            {
                "width": "20px",
                className: "text-center",
                "targets": [0, 1, 2, 3]
            }
            , {
                "width": "20px",
                className: "text-center",
                "targets": [14, 13, 12, 10]
            },
            {
                "targets": [7, 9, 11],
                visible: (informe_IdValorDeclaradoDetalle > '0' && IdTipoValorDeclarado == '2') ? true : false
            },
            {
                "targets": [6, 8, 10],
                visible: (informe_IdValorDeclaradoDetalle == '0' && IdTipoValorDeclarado == '2') ? true : false
            },


            {
                "targets": [12],
                visible: informe_IdValorDeclaradoDetalle == '0' ? true : false
            },

            {
                "targets": [13],
                visible: informe_IdValorDeclaradoDetalle == '0' ? false : true
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