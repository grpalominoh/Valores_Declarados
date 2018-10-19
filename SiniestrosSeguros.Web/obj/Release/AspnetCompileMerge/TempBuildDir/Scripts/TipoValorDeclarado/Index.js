var jsonIdioma;

$(document).ready(inicialize);

function inicialize() {

    $("a.InModal").click(function (e) {
        
        openModal(this,e);
    });

    jsonIdioma = "../Spanish.json";

    actualizaDataTable("#tbTipoValorDeclarado");
}

function openModal(a,e) {
    e.preventDefault();
    $("#divModal").modal("show");
    $("#divModal #modalBody").empty().load(a.href);
    $("#divModal #modalHeader h5").text(a.title);
    $("#divModal #modalFooter").hide();

}

function actualizaDataTable(table) {

    $(table).DataTable({
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
            url: "TipoValorDeclarado/List",
            dataSrc: "",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Lista de tipos de valores declarados");
                $("#divModal #modalBody").empty().html("¡Advertencia, por favor intente nuevamente!");
                $('#dviLstProg').empty();
            }
        },
        columns: [
            { "data": "Nombre" }, { "data": "Descripcion" }, { "data": "AfectaImporte" },
            { "data": "AfectaCantidad" }, { "data": "PermiteCargaDetalle" }, { "data": "Estado" },
            { "data": "IdTipoValorDeclarado" }
        ],
        columnDefs: [
            {
                className: "text-center",
                targets: [2, 3,4],
            }, {
                className: "text-left",
                targets: [0,1],
            },  
            {
                targets: 6,
                data: "Editar",
                render: function (data, type, row, meta) {
                    return "<a title='Editar de Tipo de Valor Declarado' class='btn btn-primary botonOp InModal ti-pencil-alt'" +
                        "href='TipoValorDeclarado/Edit?IdTipoValorDeclarado=" + data + "' onclick='openModal(this,event)'> </a>";
                }
            },
            {
                targets: [2,3,4],
                render: function (data, type, row, meta) {
                    return data ? 'SI' : 'NO';
                }
            }
        ]
    });

}