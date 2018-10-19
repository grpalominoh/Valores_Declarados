/// <reference path="_namespace.js" />


(function () {

    //Configurar Idioma Español Global

    $(document).ready(function () {

    

        setInterval(function () {
            if (!$('#divModal').hasClass('show')) {
                console.log('StyleRemove');
                $('html').removeAttr('style');
            }
        }, 1000);
        //datable Configuracion         
        $.extend(true, $.fn.dataTable.defaults, {
            "searching": false,
            "ordering": false,
            "language":
                {
                    "sProcessing": "Procesando...",
                    "sLengthMenu": "Mostrar _MENU_ registros",
                    "sZeroRecords": "No se encontraron resultados",
                    "sEmptyTable": "Ningún dato disponible en esta tabla",
                    "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                    "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                    "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                    "sInfoPostFix": "",
                    "sSearch": "Buscar:",
                    "sUrl": "",
                    "sInfoThousands": ",",
                    "sLoadingRecords": "Cargando...",
                    "oPaginate": {
                        "sFirst": "Primero",
                        "sLast": "Último",
                        "sNext": "Siguiente",
                        "sPrevious": "Anterior"
                    },
                    "oAria": {
                        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                    }
                }
        });

        $.datepicker.regional['es'] = {
            closeText: 'Cerrar',
            prevText: '<Ant',
            nextText: 'Sig>',
            currentText: 'Hoy',
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
            dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
            weekHeader: 'Sm',
            dateFormat: 'dd/mm/yy',
            firstDay: 1,
            isRTL: false,
            showMonthAfterYear: false,
            yearSuffix: ''
        };
        $.datepicker.setDefaults($.datepicker.regional['es']);



   
        //function doesConnectionExist() {

        //    var xhr = new XMLHttpRequest();
        //    var file = "/Scripts/references.js";
        //    var randomNum = Math.round(Math.random() * 10000);
        //    xhr.open('HEAD', file + "?rand=" + randomNum, true);
        //    xhr.send();
        //    xhr.addEventListener("readystatechange", processRequest, false);
        //    function processRequest(e) {
        //        if (xhr.readyState == 4) {
        //            if (xhr.status >= 200 && xhr.status < 304) {

        //            } else {
        //                alert('no hay conexion de internet');
        //            }
        //        }
        //    }
        //}
        //setInterval(function () {
        //    doesConnectionExist();
        //}, 2000)

    })
    $(document).on("keypress", '.formatoTexto', function (a) {
     
        var evt = a, thisT = this, parteEntera = 9, parteDecimal = 2;
        var charCode = (evt.which) ? evt.which : evt.keyCode;

        if ((charCode >= 65 && charCode <= 90) ||
            (charCode >= 97 && charCode <= 122))
            return true;

        return false;
    });
    //Mensaje de predload
    siniestros.preload = function (parent, callback) {
        var modalId = parent == 1 ? 'divModal' : 'divFrontModal';

        var HTML = ''
        HTML += '' + '<div style="margin-left:30px;display: block;margin-right: auto;background-size: 50px;height:60px;width: 120px;background-image: url(../../Scripts/Images/loading.gif);background-repeat: no-repeat;"></div>' + ''

        var object = $('<section></section>');
        object.html(HTML)


        $('#' + modalId + ' #modalFooter button');

        var close = function () {
            $("#" + modalId + " #modalBody").empty().html();
            if (parent == 0)
                $('div[class*="modal-backdrop"]:last-child').remove();
            else
                $('div[class*="modal-backdrop"]:last-child').removeAttr('style');

            $("#" + modalId).hide(1, function () {
                $("#" + modalId).removeAttr('style');
                $("#" + modalId).css('display', 'block');
                $("#" + modalId + " .modal-content").removeAttr('style');
                $("#" + modalId + " .modal-dialog").removeAttr('style');
            });
        }

        $('#' + modalId + ' #modalFooter').hide();
        $("#" + modalId).css({ 'display': 'block', 'z-index': 1051, 'height': '80px', 'top': '50%', overflow: 'hidden' });
        $("#" + modalId).modal("show");
        $("#" + modalId + " #modalBody").empty().append(object);
        $("#" + modalId + " .modal-content").css({ 'background': '#78797b00', 'border': '0' })
        $("#" + modalId + " .modal-dialog").css({ 'width': '160px', 'height': '160px', 'top': '50%', 'margin-top': '-30px' });
        $('div[class="modal-backdrop fade show"]:last-child').css('z-index', 1050);
        callback(close);

    }

    //Mensaje alerta
    siniestros.mensajeAlert = function (parent, mensaje, successSi, successNO) {
        var modalId = parent == 1 ? 'divModal' : 'divFrontModal';

        var HTML = '<div class="panel panel-primary" style="height:80px;padding-right:10px;border:none">'
        HTML += '<div class="panel-heading clearfix" style="background:white">'
        HTML += '<span class="panel-title pull-left" style="font-size:16px;color:black">' + mensaje + '</span>'
        HTML += '</div>'
        HTML += '<div class="panel-body" id="mensajeAlert_content"  style="text-align:right">'
        HTML += '<h1 class="text-danger" style="font-size:18px;"></h1>'
        HTML += '</div>'
        HTML += '</div >'

        var object = $('<section></section>');
        object.html(HTML);

        var close = function () {

            $('html').css('overflow', 'hidden');
            $('#' + modalId + ' .close').show();
            $("#" + modalId + " #modalBody").empty().html();
            if (parent == 0)
                $('div[class*="modal-backdrop"]:last-child').remove();
            else
                $('div[class*="modal-backdrop"]:last-child').removeAttr('style');
            $("#" + modalId).removeAttr('style');
            $("#" + modalId).hide(1, function () {
                $("#" + modalId).css('display', 'block');
                $("#" + modalId + " .modal-content").removeAttr('style');
                $("#" + modalId + " .modal-dialog").removeAttr('style');
            });
        }

        $('#' + modalId + ' #modalFooter button');
        $('#' + modalId + ' #modalFooter button').click(function () {
            close();
        });
        var linkSI = $('<a class="btn btn-primary InModal pull-right" href="#"  title="SI" style="margin-right:5px;float:none" ></a>');
        linkSI.html('SI');
        linkSI.click(function () {
            successSi();
            close();
            $('#' + modalId + ' .close').trigger('click');
        })
        var linkNo = $('<a class="btn btn-primary InModal pull-right" href="#"  title="NO" style="float:none"></a>');
        linkNo.html('NO');
        linkNo.click(function () {
            if (successNO != null)
                successNO();
            close();
            $('#' + modalId + ' .close').trigger('click');
        })

        var mensajeAlert_content = object.find('#mensajeAlert_content');
        mensajeAlert_content.append(linkSI);
        mensajeAlert_content.append('<span> </span>');
        mensajeAlert_content.append(linkNo);


        $('#' + modalId + ' .close').hide();
        $('#' + modalId + ' #modalFooter').hide();
        $("#" + modalId).css({
            'display': 'block',
            'z-index': 1051
        });
        $("#" + modalId).modal("show");
        $("#" + modalId + " #modalBody").empty().append(object);
        $("#" + modalId + " .modal-dialog").css('width', '500px');
        $("#" + modalId + " h5.modal-title").html('Advertencia');
        $('div[class="modal-backdrop fade show"]:last-child').css('z-index', 1050);
    }


    function getCaretPosition(ctrl) {
        // IE < 9 Support
        if (document.selection) {
            ctrl.focus();
            var range = document.selection.createRange();
            var rangelen = range.text.length;
            range.moveStart('character', -ctrl.value.length);
            var start = range.text.length - rangelen;
            return { 'start': start, 'end': start + rangelen };
        }
        // IE >=9 and other browsers
        else if (ctrl.selectionStart || ctrl.selectionStart == '0') {
            return { 'start': ctrl.selectionStart, 'end': ctrl.selectionEnd };
        } else {
            return { 'start': 0, 'end': 0 };
        }
    }


    var a;
    (a = $(document)).on("change", '.formatoMonto', function (a) {

        if ($(this).val().trim() == '')
            return;

        var i = $(this),
            n = i.val(),
            s = n.indexOf(".");
        s > 0 && (void 0 === n.substring(s + 1) || "" === n.substring(s + 1)) ? i.val(n + "00") : (i.val().indexOf('.') < 0 && i.val().indexOf(".00")) && i.val(n + ".00"), i.val(siniestros.ReplaceNumberWithCommas(i.val()))
    }),
        a.on("focus", '.formatoMonto', function (a) {

            if ($(this).val().trim() == '')
                return;

            var i = $(this).val();
            i = (i = i.replace(/,/g, "")).indexOf(".00") > 0 ? i.replace(".00", "") : i, $(this).val(i)
        }),
        a.on("blur", '.formatoMonto', function (a) {

            if ($(this).val().trim() == '')
                return;

            var i = $(this),
                n = i.val(),
                s = n.indexOf(".");
            s > 0 && (void 0 === n.substring(s + 1) || "" === n.substring(s + 1)) ? i.val(n + "00") : (i.val().indexOf('.') < 0 && i.val().indexOf(".00") < 0) && i.val(n + ".00"), i.val(siniestros.ReplaceNumberWithCommas(i.val()))



        }),
        a.on("keypress", '.formatoMonto,.formatoEntero', function (a) {

            var evt = a, thisT = this, parteEntera = 9, parteDecimal = 2;
            var position = getCaretPosition(thisT);
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var value = thisT.value;
            var n = value.indexOf(".");
            if (n > 0) {
                if (n == position.end) {
                    value = value.substr(0, position.end) + String.fromCharCode(charCode) + "." + value.substr(n + 1, value.length);
                } else if (n > position.end) {
                    value = value.substr(0, position.end) + String.fromCharCode(charCode) + value.substr(position.end, n - position.end) + "." + value.substr(n + 1, value.length + 1);
                } else {
                    value = value.substr(0, position.end) + String.fromCharCode(charCode) + value.substr(position.end, value.length + 1);
                }
                if (value.split(".")[0].length > parteEntera || value.split(".")[1].length > parteDecimal) {
                    return false;
                }
            }

            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }),
        a.on("click", '.close,.ico-cancelar', function (a) {
            if (!$('#divModal').hasClass('show')) {
                $('html').removeAttr('style')
            }

        }),
        a.on("click", '.panel-body a[title="NO"],.panel-body a[title="SI"]', function (a) {

            $('html').css('overflow', 'hidden');
        }),
        a.on("click", '.DisgregarBtn, .botonOp, .VerBtn, .ico-create', function (a) {
            $('#divModal').find('.modal-dialog').removeAttr('style');
        }),
        a.on("click", '.DisgregarBtn, .botonOp, .VerBtn, .ico-create', function (a) {
            $('#divModal').find('.modal-dialog').removeAttr('style');
        }),
        a.on("click", 'li.treeview a', function (a) {

            //var elements = document.querySelectorAll('#menuPrueba li');
            //for (var i = 0; i < elements.length; i++) {                 
            //    elements[i].removeAttribute('class');                
            //    elements[i].setAttribute('class', 'treeview');
            //    elements[i].setAttribute('style','');
            //    if (elements[i].querySelector('a') != null) {
            //        var current = elements[i].querySelector('a').getAttribute('data-href');
            //        var arrays = elements[i].querySelector('a').getAttribute('data-href-array');

            //        var array = arrays == null ? '' : arrays.split(',');

            //        if (document.location.href.indexOf(current) > 0 && array.length == 0) {
            //            if (array.length == 0) {
            //                elements[i].setAttribute('class', 'treeview active');
            //                elements[i].setAttribute('style', 'background:red');
            //                break;
            //            }
            //        }

            //    }
            //}
        })





    //$(document).on('click', 'form .ico-cancelar', function () {
    //    siniestros.mensajeAlert(0, 'Esta seguro en Cancelar la operación', function () {

    //    }, function () {
    //        return;
    //    });
    //})

})();
