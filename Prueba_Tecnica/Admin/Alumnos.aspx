<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Administrator.master" AutoEventWireup="true" CodeFile="Alumnos.aspx.cs" Inherits="Admin_Alumnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.0/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.0/js/buttons.flash.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.0/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.0/js/buttons.print.min.js"></script>

    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/buttons/1.6.0/css/buttons.dataTables.min.css" rel="stylesheet" />

    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://unpkg.com/moment"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnAgregar').click(function () { //GUARDAR EN BASE DE DATOS
                var AlumnoID = $('#txtAlumnoID').val();
                var NombreAlumno = $('#txtName').val();
                var APaterno = $('#txtAPaterno').val();
                var AMaterno = $('#txtAMaterno').val();
                var Birthdate = $('#txtBirthdate').val();
                var Gender = $('#cmbGender').val();
                var GradoActual = $('#txtGradoActual').val();
                var Email = $('#txtEmail').val();
                var Telefono = $('#txtTelefono').val();



                /*  Validaciones  */
                var emailExp = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([com\co\.\in])+$/;
                var telExp = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;

                if (NombreAlumno != "" && APaterno != "" && AMaterno != "" && Birthdate != "" && Gender != "" && GradoActual != "" && Email != "" && Telefono != "")
                {
                    if (!Email.match(emailExp))
                    {
                        swal("Email", "Formato de Email incorrecto.", "warning");
                    }
                    else if (!Telefono.match(telExp))
                    {
                        swal("Telefono", "Formato de Telefono incorrecto.", "warning");
                    }
                    else {

                        $.ajax({
                            type: "POST",
                            url: "Alumnos.aspx/Save",
                            data: '{AlumnoID: ' + '"' + AlumnoID + '", ' +
                                'NombreAlumno:' + '"' + NombreAlumno + '",' +
                                'APaterno:' + '"' + APaterno + '",' +
                                'AMaterno:' + '"' + AMaterno + '",' +
                                'Birthdate:' + '"' + Birthdate + '",' +
                                'Gender:' + '"' + Gender + '",' +
                                'GradoActual:' + '"' + GradoActual + '",' +
                                'Email:' + '"' + Email + '",' +
                                'Telefono:' + '"' + Telefono + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: 'json',
                            async: false,
                            success: function (data) {
                                if (data.d != 1) {
                                    alert("Error: " + data.d);
                                }
                                else {
                                    swal("Registrado!", "Sus datos han sido guardados correctamente!", "success");
                                    Datos();

                                }
                            },
                            failure: onFailure
                        });
                    }
                    
                }
                else
                {
                    swal("Campos", "Favor de llenar los campos correctamente.", "warning");
                }

                
                function onFailure(e) {
                    swal("Error", e.get_message(), "error");
                    
                }
            });

            $('#btnBorrar').click(function () {//ELIMINAR ALUMNO
                var AlumnoID = $('#txtAlumnoID').val();
                if (AlumnoID != "")
                {
                    $.ajax({
                        type: "POST",
                        url: "Alumnos.aspx/Delete",
                        data: '{AlumnoID:' + '"' + AlumnoID + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                            if (data.d != 1) {
                                swal("Error", data.d, "error");
                            }
                            else {
                                swal("Eliminar", "Sus datos han sido borrados correctamente!", "success");
                                Datos();
                            }
                        },
                        failure: onFailure
                    });
                }
                else {
                    swal("Eliminar", "Favor de seleccionar un alumno primero.", "warning");
                }
                
                function onFailure(e) {
                    swal("Error", e.get_message(), "error");
                }
            });

            var t = $('#tbRegistro').DataTable({
                dom: 'Bfrtip',
                responsive: true,
                buttons: [
                    {
                        extend: 'print',
                        orientation: 'landscape',
                        pageSize: 'LEGAL',
                        download: 'open',
                        messageTop: 'Registro de alumnos',
                        exportOptions: {
                            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        orientation: 'landscape',
                        pageSize: 'LEGAL',
                        download: 'open',
                        messageTop: 'Registro de alumnos',
                        exportOptions: {
                            columns: [0, 1,2,3,4,5,6,7,8]
                        }
                    }
                ]
            });

            function Datos() {
                $.ajax({
                    type: "POST",
                    url: "Alumnos.aspx/getData", //MUESTRA LOS DATOS EN LA TABLA
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    async: false,
                    success: function (data) {
                        t.clear().draw();
                        for (var x = 0; x < data.d.length; x++) {
                            var AlumnoID = data.d[x].AlumnoID;
                            var NombreAlumno = data.d[x].NombreAlumno;
                            var APaterno = data.d[x].APaterno;
                            var AMaterno = data.d[x].AMaterno;
                            var Birthdate = data.d[x].Birthdate;
                            var Gender = data.d[x].Gender;
                            var GradoActual = data.d[x].GradoActual;
                            var Email = data.d[x].Email;
                            var Telefono = data.d[x].Telefono;

                            var formattedDate = Birthdate.split(" ")[0].split("-").reverse().join("-");

                            t.row.add([AlumnoID, NombreAlumno, APaterno, AMaterno, formattedDate, Gender, GradoActual, Email, Telefono]).draw(false);
                        }
                    },
                    failure: onFailure
                });
            }
            function onFailure(e) {
                swal("Error", e.get_message(), "error");
            }

            Datos();


            $('#tbRegistro tbody').on('click', 'tr', function () {
                $(this).addClass('selected').siblings().removeClass('selected');
                if ($.trim($(this).children('td:nth-child(1)').html().length != 0)) {
                    $('#txtAlumnoID').val($.trim($(this).children('td:nth-child(1)').html()));
                    $('#txtName').val($.trim($(this).children('td:nth-child(2)').html()));
                    $('#txtAPaterno').val($.trim($(this).children('td:nth-child(3)').html()));
                    $('#txtAMaterno').val($.trim($(this).children('td:nth-child(4)').html()));
                    $('#txtBirthdate').val($.trim($(this).children('td:nth-child(5)').html()));
                    $('#cmbGender').val($.trim($(this).children('td:nth-child(6)').html()));
                    $('#txtGradoActual').val($.trim($(this).children('td:nth-child(7)').html()));
                    $('#txtEmail').val($.trim($(this).children('td:nth-child(8)').html()));
                    $('#txtTelefono').val($.trim($(this).children('td:nth-child(9)').html()));
                }
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="page-header">Alumnos</h1>
    <ol class="breadcrumb">
        <li><a href="/Admin/Index.aspx">Inicio</a></li>
        <li><a href="/Admin/Alumnos.aspx">Alumnos</a></li>
        <li class="active">Registro de Alumnos</li>
    </ol>
    <div id="page-inner">
        <div class="row">
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-action">
                        Agregar nuevo alumno
                    </div>
                    <div class="card-content">
                        <div class="col s12">
                            <div class="row">
                                <div class="input-field col s12" style="display:none">
                                    <input id="txtAlumnoID" type="text" class="validate"  />
                                    <label for="lblAlumnoID">ID</label>
                                </div>
                                <div class="col s12">
                                    <label for="lblName">Nombre(s)</label>
                                    <input id="txtName" type="text" class="validate" required/>
                                    
                                </div>
                                <div class="col s12">
                                    <label for="lblAPaterno">Apellido Paterno</label>
                                    <input id="txtAPaterno" type="text" class="validate" required/>
                                </div>
                                <div class="col s12">
                                    <label for="lblAMaterno">Apellido Materno</label>
                                    <input id="txtAMaterno" type="text" class="validate" required/>
                                    
                                </div>
                                <div class="col s12">
                                    <label for="lblBirthdate">Fecha De Nacimiento</label>
                                    <input id="txtBirthdate" type="date" class="validate" required/>
                                </div>
                                <div class="col s12">
                                    <label for="lblGender">Sexo</label>
                                    <select class="form-control" id="cmbGender">
                                        <option value="M">Masculino</option>
                                        <option value="F">Femenino</option>
                                    </select>
                                </div>
                                 <div class="col s12" style="padding-top:2rem">
                                     <label for="lblGradoActual">Grado de estudios actual</label>
                                    <input id="txtGradoActual" type="text" class="validate" required/>
                                    
                                </div>
                                <div class="col s12">
                                    <label for="lblEmail">Email</label>
                                    <input id="txtEmail" type="email" class="validate"  required/>
                                    
                                </div>
                                <div class="col s12">
                                    <label for="lblTelefono">Telefono - Formato (123-123-1234)</label>
                                    <input id="txtTelefono" type="tel" class="validate" required/>
                                    
                                </div>
                            </div>
                            <div class="col s6">
                                <button type="button" class="waves-effect waves-light btn btn-warning btn-block text-uppercase" id="btnAgregar">Agregar alumno</button>
                            </div>
                            <div class="col s6">
                                <button type="button" class="waves-effect waves-light btn btn-danger btn-block text-uppercase" id="btnBorrar">Eliminar alumno</button>
                            </div>
                        </div>
                        <div class="clearBoth"></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-action">
                        Tabla de alumnos
                    </div>
                    <div class="card-content">
                        <div class="table-responsive">
                            <table id="tbRegistro" class="table table-striped table-bordered" style="width: 95%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre(s)</th>
                                        <th>A. Paterno</th>
                                        <th>A. Materno</th>
                                        <th>Fecha De Nacimiento</th>
                                        <th>Sexo</th>
                                        <th>Grado De Estudios Actual</th>
                                        <th>Email</th>
                                        <th>Telefono</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.row (nested) -->
            </div>
            <!-- /.panel-body -->
        </div>
    </div>
</asp:Content>

