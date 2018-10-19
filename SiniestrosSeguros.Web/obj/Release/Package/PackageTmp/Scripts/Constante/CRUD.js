$(document).ready(inicialize);

function inicialize() {

    $("#divError").hide();

    $("#frmCRUDConst").submit(function (e) {
        e.preventDefault();
        submitFormTVD(this);
    });
}

function submitFormTVD(frm) {

    var constante = $("#Constante").val();
    var errores = [];
    if (constante == '') {
        errores.push('- El campo nombre es obligatorio');
    }

    if (errores.length > 0) {
        mostrarError(errores);
        return;
    }
 
    $.ajax({
        type: frm.method,
        url: frm.action,
        data: $(frm).serialize(),
        success: function (data) {
  
        
            $("#divModal #modalBody").empty().html(data).fadeIn(500);
            var IdConst = 0;
            $("#tbConstantePadre" + " input:radio:checked").each(function () {
                IdConst = this.id;
            });
            MostrarHijo(IdConst);
        },
        error: function (data) {
            $("#divModal #modalBody").empty().html(data).fadeIn(500);
        }
    });
}

function mostrarError(errores) {
    var html;
    if (errores.length == 1) {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    } else {
        html = '<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"> Advertencia:</span><br>';
    }

    for (i = 0; i < errores.length; i++) {
        html += errores[i] + "<br>";
    }
    $("#divError").empty().html(html);
    $("#divError").show();
}