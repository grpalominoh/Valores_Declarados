$(document).ready(function () {
 
    inicialize();
});

function inicialize() {
    let table;
    let tableArchivos;
    let listaArchivos = {};
    if ($("#ListaArchivo").val() !== "") {
        listaArchivos = JSON.parse($("#ListaArchivo").val());
    } 
    inicializaTablaDetalleDisgrega();
    
    actualizaTablaArchivos(listaArchivos);

    $("#divError").hide();
    $("#divErrorDisgregacion").hide();

    $('#idAgregar').click(function () {
        $("#divErrorDisgregacion").hide();
        agregarRegistroDisgregacion();
    });

    $("#txtImporte").keypress(function (e) {
        return validaDecimales(e, this, 9, 2);
    });

    $('#txtCantidad').keypress(function (e) {
        return validaDecimales(e, this, 9, 2);
    });

    $("#frmDisgregarVD").submit(function (e) {

        e.preventDefault();
        submitFormVD(this);

    });

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
            { "data": "TipoValorDeclarado" }, { "data": "IdRamoPoliza" }, { "data": "RamoPoliza" },
            { "data": "IdTipoPoliza" }, { "data": "TipoPoliza" }, { "data": "IdMoneda" },
            { "data": "Moneda" }, { "data": "Importe" }, { "data": "IdUnidadMedida" },
            { "data": "UnidadMedida" }, { "data": "Cantidad" }
        ],
        columnDefs: [  
            {
                targets: [0, 1, 2, 4, 6, 8, 11],
                visible: false
            }, {
                className: "numeric-right",
                targets: 13,
            },            
            {
                className: "numeric-right",
                targets: 10,
                render: function (data, type, row) {
                    row.Importe = siniestros.ReplaceNumberWithCommas(row.Importe); 
                    return row.Importe;
                }
            }
        ]
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
                          
                        return "<button type='button' style='border-right-width: 1px;margin-left: 150px;' class='btn btn-success AnularBtn ico-descargar' onclick='javascript:verArchivo(\"" + row.NombreArchivo + "\", \"" + row.NombreAsignado + "\", \"" + row.Formato + "\" )' id='btnDescarga'>"                              
                    
                }
            }
        ]
    });
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
        url: "ValorDeclarado/ValorDeclarado/ValidarDescarga",
        data: parametros,
        type: 'GET',
        success: function (data) {
            if (!data.esError) {
                window.location = "DescargarArchivo?NombreArchivo=" + NombreArchivo + "&NombreAsignado=" + NombreAsignado + "&Formato=" + Formato;
            } else {
                var errores = [];
                errores.push(data.mensaje);
                mostrarError(errores);
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

function actualizaControlesTipoValorDeclarado() {
    $.ajax({
        type: 'GET',
        url: 'ValorDeclarado/ObtenerInfoTipoValorDeclarado',
        data: {
            IdTipoValorDeclarado: parseInt($("#selTipoValorDeclarado option:selected").val()),
            IdValorDeclarado: parseInt($("#IdValorDeclarado").val())
        },
        success: function (data) {
  
            $("#txtCntReal").empty().append(data.Cantidad);
            $("#txtImpReal").empty().append(siniestros.ReplaceNumberWithCommas(data.ImporteValorDeclarado));
        },
        error: function (data) {

        }
    });
}



