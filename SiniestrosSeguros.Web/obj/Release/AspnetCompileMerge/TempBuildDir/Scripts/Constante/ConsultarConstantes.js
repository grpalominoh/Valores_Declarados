$(document).ready(inicialize);

function inicialize() {

    $("a.InModal").click(function (e) {
        openModal(this, e);
    });

    actualizaDataTablePadre("#tbConstantePadre");
}

function openModal(a, e) {
    e.preventDefault();
    $("#divModal").modal("show");
    $("#divModal #modalBody").empty().load(a.href);
    $("#divModal #modalHeader h5").text(a.title);
    $("#divModal #modalFooter").hide();
}

function MostrarHijo(data) {
    $("#ConsultarHijoConstante").empty().load("DetalleConsultarConstantes?IdConstante=" + data);
}

function actualizaDataTablePadre(table) {
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
            url: "ListPadre",
            dataSrc: "",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (data) {
                $("#divModal").modal("show");
                $("#divModal #modalHeader h5").text("Agrupaciones");
                $("#divModal #modalBody").empty().html("¡Ha ocurrido un error, por favor intente nuevamente!");
                $('#dviLstProg').empty();
            }
        },
        columns: [
            { "data": "IdConstante" }, { "data": "Constante" }, { "data": "Descripcion" }, { "data": "CodigoAgrupador" }
        ],
        columnDefs: [ {
            className: "text-left",
            targets: [0,1,2],
        },{
            targets: 0,
            data: "Seleccione",
            render: function (data, type, row, meta) {
                return "<label class='radio- inline InModal'><input type='radio' title='Seleccione para mostrar el detalle de la agrupación' name='optradio' onclick='MostrarHijo(" + data + ");' id='" + data + "''></label>";
            }
        }
        ]
    });
}