$(document).ready(inicialize);

function inicialize() {
    $("#IdOcultar").hide();
}

function openModal(a, e) {
    e.preventDefault();
    $("#divModal").modal("show");
    $("#divModal #modalBody").empty().load(a.href);
    $("#divModal #modalHeader h5").text(a.title);
    $("#divModal #modalFooter").hide();
}
