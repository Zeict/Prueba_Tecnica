<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Administrator.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Admin_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="page-header">Inicio</h1>
    <ol class="breadcrumb">
        <li><a href="/Admin/Index.aspx">Inicio</a></li>
        <li><a href="/Admin/Index.aspx">Admin</a></li>
    </ol>
    <div id="page-inner">

        <div class="row">
            <div class="col-xs-12">
                <div class="card">
                    <div class="card-action">
                        <b>Bienvenido! aqui podras realizar consultas y añadir nuevos alumnos.</b>
                    </div>
                </div>
            </div>

        </div>
        <div class="dashboard-cards">
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-3">

                    <div class="card horizontal cardIcon waves-effect waves-dark">
                        <div class="card-image red">
                            <i class="material-icons dp48">supervisor_account</i>
                        </div>
                        <a href="/Admin/Alumnos.aspx" class="card-stacked" style="text-decoration: none">
                            <div class="card-stacked red">

                                <div class="card-content">
                                    <h3>Ir a</h3>
                                </div>
                                <div class="card-action">
                                    <strong>AGREGAR ALUMNOS</strong>
                                </div>
                            </div>
                        </a>
                    </div>

                </div>
                <div class="col-xs-12 col-sm-6 col-md-3">

                    <div class="card horizontal cardIcon waves-effect waves-dark">
                        <div class="card-image orange">
                            <i class="material-icons dp48">view_list</i>
                        </div>
                        <a href="/Admin/Alumnos.aspx" class="card-stacked" style="text-decoration: none">
                            <div class="card-stacked orange">
                                <div class="card-content">
                                    <h3>Ir a</h3>
                                </div>
                                <div class="card-action">
                                    <strong>CONSULTAR ALUMNOS</strong>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>

            </div>

            <%--   <div class="row">
                <div class="col-md-12">
                </div>
            </div>--%>
            <!-- /. ROW  -->
        </div>
    </div>
</asp:Content>

