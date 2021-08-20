<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Login</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../b_Login/css/style.css" />
    <link rel="stylesheet" type="text/css" href="../b_Login/css/util.css" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<body>
    <div class="contenedor">
        <div class="contenedor-login" style="background-image: url('../b_Login/images/bg_login.jfif');">
            <div class="wrap-login p-l-110 p-r-110 p-t-62 p-b-33">
                <form class="form-login validate-form flex-sb flex-w">
                    <span class="form-login__titulo p-b-53">Login
                    </span>
                    <div class="p-t-31 p-b-9">
                        <span class="txt1">Usuario:
                        </span>
                    </div>
                    <div class="wrap-input validate-input" data-validate="Usuario requerido.">
                        <input class="wrap-input__contenido" type="text" name="Usuario" id="txtUser" required/>
                        <span class="focus-input"></span>
                    </div>

                    <div class="p-t-13 p-b-9">
                        <span class="txt1">Contraseña:
                        </span> 
                    </div>
                    <div class="wrap-input validate-input" data-validate="Contraseña requerida">
                        <input class="wrap-input__contenido" type="password" name="Password" id="txtPasswordlogin" required/>
                        <span class="focus-input"></span>
                    </div>

                    <div class="contenedor-login__btn m-t-17 p-t-17">
                        <button type="button" class="form-login__btn " id="btnLogin">
                            Entrar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--===============================================================================================-->
    <script src="../b_Login/js/jquery-3.2.1.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnLogin').click(function ()
            {
                var User = $('#txtUser').val();
                var Password = $('#txtPasswordlogin').val();

                if (User != "" && Password != "")
                {
                    $.ajax({
                        type: "POST",
                        url: "Login.aspx/CheckUser",
                        data: '{User:' + '"' + User + '",' +
                            'Password:' + '"' + Password + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                            var Valores = data.d;
                            var Resultado = Valores.split(",");
                            if (Resultado[0] == "1") {
                                window.location.href = '/Admin/Index.aspx';
                            }
                            else if (Resultado[0] == "504") {
                                swal("Datos Incorrectos", "Contraseña o Usuario Incorrectos.", "error");
                            }
                        },
                        failure: onFailure
                    });
                }
                else {
                    swal("Campos", "Favor de ingresar sus datos.", "warning");
                }
                

            });
            function onFailure(e) {
                swal("Error", e.get_message(), "error");
            }

        });

    </script>
</body>
</html>
