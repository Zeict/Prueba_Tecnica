<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Administrator.master" AutoEventWireup="true" CodeFile="Consultar.aspx.cs" Inherits="Admin_Consultar" %>

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
    <script src="../b_Login/js/moment.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var t = $('#tbAlumnosRegistrados').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    'excel', 'copy', 'pdf'
                ]
            });
            function AlumnosRegistrados() {
                $.ajax({
                    type: "POST",
                    url: "Consultar.aspx/getAlumnos",
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    async: false,
                    success: function (data) {
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

                            t.row.add([NombreAlumno + " " + APaterno + " " + AMaterno, formattedDate, Gender, GradoActual, Email, Telefono]).draw(false);
                        }
                    },
                    failure: onFailure
                });
            }
            function onFailure(e) {
                swal("Error", e.get_message(), "error");
            }

            AlumnosRegistrados();
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h1 class="page-header">Proyectos</h1>
    <ol class="breadcrumb">
        <li><a href="/Admin/Index.aspx">Inicio</a></li>
        <li><a href="/Admin/Consultar.aspx">Consulta</a></li>
        <li class="active">Consultar Alumnos</li>
    </ol>
    <div id="page-inner">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-action">
                        Alumnos Registrados
                    </div>
                    <div class="card-content">
                        <div class="table-responsive">
                            <table id="tbAlumnosRegistrados" class="table table-striped table-bordered display nowrap" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Nombre del Alumno</th>
                                        <th>Fecha de nacimiento</th>
                                        <th>Sexo</th>
                                        <th>Grado de estudios actual</th>
                                        <th>Email</th>
                                        <th>Telefono</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div class="clearBoth"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.col-lg-12 -->
    </div>


</asp:Content>

