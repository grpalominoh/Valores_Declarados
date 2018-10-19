$(document).ready(inicialize);

function inicialize() {

    $("a.InModal").click(function (e) {
        openModal(this, e);
    });

    BuscarHijo();
}

function openModal(a, e) {
    e.preventDefault();
    $("#divModal").modal("show");
    $("#divModal #modalBody").empty().load(a.href);
    $("#divModal #modalHeader h5").text(a.title);
    $("#divModal #modalFooter").hide();
}

function BuscarHijo() {
    var IdConst = $("#IdConstante").val();
    var Constante = $("#NombreConstante").val();
    actualizaDataTableHijo("#tbConstanteHijo", IdConst, Constante);
}

function actualizaDataTableHijo(table, IdConstante, Constante) {
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
            url: "ListHijo?IdConstante=" + IdConstante + "&Constante=" + Constante,
            dataSrc: "",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Detalle de la Agrupación");
                $("#divModal #modalBody").empty().html("¡Ha ocurrido un error, por favor intente nuevamente!");
                $('#dviLstProg').empty();
            }
        },
        columns: [
            { "data": "IdConstante" }, { "data": "Constante" }, { "data": "Descripcion" },
            { "data": "Orden" }, { "data": "Estado" }, { "data": "IdConstante" },
        ],
        columnDefs: [{
            className: "text-left",
            targets: [1, 2],
        },
            {
                className: "text-center",
                targets: [0, 3, 4],
            }, {
            targets: 5,
            data: "Listar",
            render: function (data, type, row, meta) {
                return "<a title='Detalle de la Agrupación' class='btn btn-primary InModal botonOp ti-pencil-alt'" +
                    "href='GuardarConstantes?IdConstante=" + data + "&TipoOperacion=Editar' onclick='openModal(this,event)'> </a>";
            }
        }
        ]
    });
}
