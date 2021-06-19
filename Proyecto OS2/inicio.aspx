<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inicio.aspx.cs" Inherits="Proyecto_SO.inicio" %>


<!DOCTYPE html >

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="no-js">
    <head runat="server">

    <link href='https://fonts.googleapis.com/css?family=Pinyon+Script' rel='stylesheet' type='text/css'/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet""/>

    <style type="text/css">
        body {
            background: #eee !important;
        }

        .wrapper {
            margin-top: 80px;
            margin-bottom: 80px;
        }

        .form-signin {
            max-width: 380px;
            padding: 15px 35px 45px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .form-signin-heading,
        .checkbox {
            margin-bottom: 30px;
        }

        .checkbox {
            font-weight: normal;
        }

        .form-control {
            position: relative;
            font-size: 16px;
            height: auto;
            padding: 10px;
        }

        input[type="text"] {
            margin-bottom: -1px;
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
        }

        input[type="password"] {
            margin-bottom: 20px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
    </style>
	</head>

    <body>

        <div id="contenedor" class="wrapper">

            <br/>
            <br/>
            <br/>
            <br/>
            <div id="caja_login">
                <br/>
                <center>
					
			    <form class="form-signin" id="Login" method="post" runat="server">
				    <h4 style="padding-bottom: 26px;">Iniciar Sesion</h4>
				    <%--<input class="form-control" id="txtDomain" name="txtDomain" Runat="server" placeholder="Escriba el dominio" />--%>
                     <input class="form-control" id="txtUsername" name="txtUsername" Runat="server" placeholder="Escriba el usuario" />
                    <input class="form-control" type="password" id="txtPassword" name="txtPassword" Runat="server" placeholder="Escriba la contraseña"/> 
                    <br/><br/>
                    <button id="btnLogin" Runat="server" onserverclick="Login_Click" type="submit" class="form-control" style="background-color: #198754; color:white">Acceder</button><br/>
<%--				    <asp:TextBox CssClass="form-control" ID="txtUsername" Runat="server" placeholder="Escriba el usuario" width="80%" style="margin-top: -28px;"></asp:TextBox><br/><br/>
				    <asp:TextBox CssClass="form-control" ID="txtPassword" Runat="server" TextMode="Password" placeholder="Escriba la contraseña" width="80%" style="margin-top: -49px;"></asp:TextBox><br/>
				    <button ID="btnLogin" Runat="server" Text="Acceder" OnClick="Login_Click" CssClass="form-control" style="background-color: #3276b1; color:white"></button><br/>
				    <asp:Label ID="errorLabel" Runat="server" ForeColor="#ff3300"></asp:Label><br/>--%>
			    </form>
			    </center>
            </div>

        </div>
    </body>
</html>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" ></script>

<script runat="server">

    void Login_Click(object sender, EventArgs e)
    {

        if (txtPassword.Value == "" || txtUsername.Value == "")
        {
            Response.Redirect("inicio.aspx");
        }
        else
        {
            Session["user"] = txtUsername.Value;
            Session["dominio"] = "umhdemo.com";
            Session["pass"] = txtPassword.Value;
            Response.Redirect("info.aspx");
            //Response.Redirect("info.aspx?contrasena=" + txtPassword.Value + "&usuario=" + txtUsername.Value + "&dom=" + txtDomain.Value);
        }
    }

</script>