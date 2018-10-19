/// <reference path="../references.js" />

$(document).ready(inicialize);

function inicialize() {

    actualizaDataTable();
}

function openModal(a, e) {
    e.preventDefault();
    $("#divModal").modal("show");
    $("#divModal #modalBody").empty().load(a.href);
    $("#divModal #modalHeader h5").text(a.title);
    $("#divModal #modalFooter").hide();

}

function showModalCreate() {

    var parametros = {
        IdTipoPoliza: parseInt($("#selRamoPoliza option:selected").val()),
        DescripcionRamoPoliza: $("#selRamoPoliza option:selected").text()
    };

    $.ajax({
        type: 'GET',
        url: '/TipoPoliza/Create',
        data: parametros,
        success: function (data) {
            $("#divModal").modal("show");
            $("#divModal #modalHeader h5").text("Registro Tipo de Poliza");
            $("#divModal #modalBody").empty().html(data);
            $("#divModal #modalFooter").hide();
        },
        error: function (data) {

        }
    });
}

function showModalEdit(data) {

    var parametros = {
        IdTipoPoliza: parseInt($("#selRamoPoliza option:selected").val()),
        DescripcionRamoPoliza: $("#selRamoPoliza option:selected").text(),
        IdDivisionPoliza: data
    };

    $.ajax({
        type: 'GET',
        url: '/TipoPoliza/Edit',
        data: parametros,
        success: function (data) {
            $("#divModal").modal("show");
            $("#divModal #modalHeader h5").text("Modifica Tipo de Poliza");
            $("#divModal #modalBody").empty().html(data);
            $("#divModal #modalFooter").hide();
        },
        error: function (data) {

        }
    });
}

function actualizaDataTable() {

    $("#tbTipoPoliza").DataTable({
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
            url: "TipoPoliza/List",
            type: 'GET',
            data: { IdTipoPoliza: parseInt($("#selRamoPoliza option:selected").val()) },
            dataSrc: "",
            //contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Lista de tipos de valores declarados");
                $("#divModal #modalBody").empty().html("¡Advertencia, por favor intente nuevamente!");
                $('#dviLstProg').empty();
            }
        },
        columns: [
            { "data": "IdDivisionPoliza" }, { "data": "Descripcion" }, { "data": "Abreviatura" },
            { "data": "AplicaProveedor" }, { "data": "Estado" },
            { "data": "IdDivisionPoliza" }
        ],
        columnDefs: [
            {
                className: "text-center",
                targets: [0, 3],
            }, {
                className: "text-left",
                targets: [1, 2, 3],
            },
            {
                targets: 5,
                data: "Editar",
                render: function (data, type, row, meta) {
                    return "<a class='btn btn-primary botonOp ti-pencil-alt' onclick='showModalEdit(" + data + ")'> </a>";
                }
            }
        ]
    });

}