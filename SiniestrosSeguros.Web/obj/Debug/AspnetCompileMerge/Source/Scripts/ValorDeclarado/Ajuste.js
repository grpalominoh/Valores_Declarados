

$(document).ready(inicialize);

function inicialize() {

    $("#seccionDisgregacion").hide();
    actualizaTablaTipoValorDeclarado();

}

function actualizaTablaTipoValorDeclarado() {

    var parametros = {
        IdValorDeclarado: $("#IdValorDeclarado").val()
    };

    var table = $("#tbTipoValorDeclaradoDetalle").DataTable({
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        processing: true,
        ajax: {
            url: 'AjusteValorDeclaradoDetalleList',
            data: parametros,
            dataSrc: "",
            dataType: 'json',
            async: false,
            error: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Ajuste de Valor Declarado");
                $("#divModal #modalBody").empty().html("¡Ha ocurrido un error, por favor intente nuevamente!");
                $('#dviLstProg').empty();
            }
        },
        columns: [
            { "data": "IdTipoValorDeclaradoDetalle" },
            { "data": "TipoValorDeclarado" },
            { "data": "Moneda" },
            { "data": "ImporteReal" },
            { "data": "ImporteAjustado" },
            { "data": "UnidadMedida" },
            { "data": "CantidadReal" },
            { "data": "CantidadAjustada" },
            { "data": "TipoRegistro" },
            { "data": "Estado" }
        ],
        columnDefs: [
            {
                className: "text-left",
                targets: 0,
            }, {
                className: "numeric-right2",
                targets: [3]
            },
            {
                className: "numeric-right2",
                targets: [4],
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.ImporteAjustado);
                }
            },
             {
                className: "numeric-right2",
                targets: 7,
                render: function (data, type, row) {
                    return row.CantidadAjustada;
                }
            },
            {
                targets: 0,
                data: "Seleccione",
                render: function (data, type, row) {
                    row.ImporteReal = siniestros.ReplaceNumberWithCommas(row.ImporteReal);
                    row.ImporteAjustado = siniestros.ReplaceNumberWithCommas(row.ImporteAjustado);
                    return "<label class='radio- inline InModal'><input type='radio' title='Seleccione para mostrar los tipos de poliza' name='optradio' onclick='mostrarTipoPolizas(" + JSON.stringify(row) + ");' id='" + data + "''></label>";
                }
            }
        ]
    });

    table.rows().every(function (rowId, tableLoop, rowLoop) {
        var data = this.data();
        table.row(rowId).data(data).draw();
    })

}

function mostrarTipoPolizas(data) {
    $("#Afecta").val(data.Afecta);
    $("#IdTipoValorDeclaradoDetalle").val(data.IdTipoValorDeclaradoDetalle);
    actualizaTablaTipoPoliza();

    $("#seccionDisgregacion").show();
}

function actualizaTablaTipoPoliza() {

    var parametros = {
        IdValorDeclaradoDetalle: $("#IdTipoValorDeclaradoDetalle").val()
    };

    var table = $("#tbTipoValorDeclaradoDisgregadoPoliza").DataTable({
        "initComplete": function (settings, json) {
            $("#tbTipoValorDeclaradoDisgregadoPoliza").find('tbody tr').each(function () {
                var valordeclarado = $(this).find('td:nth-child(0n+5)');
                var valorajustado = $(this).find('td:nth-child(0n+6)');
                valordeclarado.html(siniestros.ReplaceNumberWithCommas(valordeclarado.html()));
                valorajustado.html(siniestros.ReplaceNumberWithCommas(valorajustado.html()));
            })

        },
        "bDestroy": true,
        searching: true,
        lengthChange: false,
        responsive: true,
        sort: false,
        language: {
            "url": "../../Scripts/DataTables/Spanish.json"
        },
        processing: true,
        ajax: {
            url: 'AjusteTipoPolizaList',
            data: parametros,
            dataSrc: "",
            dataType: 'json',
            async: false,
            error: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Ajuste de Valor Declarado Disgregado");
                $("#divModal #modalBody").empty().html("¡Ha ocurrido un error, por favor intente nuevamente!");
                $('#dviLstProg').empty();
            }
        },
        columns: [
            { "data": "IdValorDeclaradoDetalleDisgregado" }, { "data": "RamoPoliza" }, { "data": "TipoPoliza" },
            { "data": "Moneda" }, { "data": "ImporteValorDeclarado" }, { "data": "ImporteAjustado" },
            { "data": "UnidadMedida" }, { "data": "Cantidad" }, { "data": "CantidadAjustada" }, { "data": "Estado" }
        ],
        columnDefs:
            [{
                className: "numeric-right2",
                targets: [7, 8],
            },
          
            {
                className: "numeric-right2",
                targets: 4,
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.ImporteValorDeclarado);
                }
            },
            {
                className: "numeric-right2",
                targets: 5,
                render: function (data, type, row) {
                    return siniestros.ReplaceNumberWithCommas(row.ImporteAjustado);
                }
            },
            {
                targets: 10,
                data: "",
                render: function (data, type, row) {

                    if ($('#edit').val() == '0') {
                        return "<a class='btn btn-primary botonOp ti-pencil-alt' onclick='mostrarModalEdicion(" + JSON.stringify(row) + ")'> </a>";
                    } else {
                        return "";
                    }

                }
            }]
    });








}

function mostrarModalEdicion(data) {

    var parametros = {
        IdValorDeclaradoDetalleDisgregado: data.IdValorDeclaradoDetalleDisgregado,
        RamoPoliza: data.RamoPoliza,
        TipoPoliza: data.TipoPoliza,
        ImporteAjustado: data.ImporteAjustado,
        CantidadAjustada: data.CantidadAjustada,
        IdValorDeclarado: $("#IdValorDeclarado").val(),
        IdValorDeclaradoDetalle: $("#IdTipoValorDeclaradoDetalle").val(),
        Afecta: $("#Afecta").val()
    };

    $.ajax({
        type: 'GET',
        url: 'AjusteValor',
        data: parametros,
        success: function (data) {

            $("#divFrontModalSmall").modal("show");
            $("#divFrontModalSmall #modalHeader h5").text("Ajustar Valor Declarado");
            $("#divFrontModalSmall #modalBody").empty().html(data);
            $("#divFrontModalSmall #modalFooter").hide();
            $("#divFrontModalSmall").css('z-index', 1051)
            $('.show:last-child').css('z-index', 1050)
        },
        error: function (data) {

        }
    });

}

