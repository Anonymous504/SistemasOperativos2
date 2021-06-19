<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="info.aspx.cs" Inherits="Proyecto_SO.info" %>
<%@ Import Namespace="Proyecto_SO" %>


<html xmlns="http://www.w3.org/1999/xhtml">

<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Sevidor vasquez.com</title> 
    <link href='https://fonts.googleapis.com/css?family=Pinyon+Script' rel='stylesheet' type='text/css'>
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet""/>	
    <style type="text/css">
		*{
		   margin:0px;
		   padding:0px;
		}
		body{
		   /*background:url(fondo.jpg) #2b2b2a;*/
		}
		form{
		   /*background:#CB0C49;*/
		   width:800px;
		   /*border:1px solid #4e4d4d;*/
		   /*border-radius:3px;*/
		   -moz-border-radius:3px;
		   -webkit-border-radius:3px;
		   /*box-shadow:inset 0 0 10px #000;*/
		   margin:100px auto;
		}
		form h4{
		   text-aling:center;
		   color:#FFFFFF;
		   font-weight:normal;
		   font-size:40pt;
		   margin:30px 0px;
	           font-family: Calibri, cursive;
		}
		form input{
		   width: 280px;
		   height:35px;
		   padding:0px 10px;
		   color:#6d6d6d;
		   text-aling:center;

		}
		form button{
		   width:135px;
		   margin:20px 0px 30px 30px;
		   height:50px;
		}
		caja_superior{
		   width: 280px;
		   height:35px;
		   padding:0px 10px;
		   color:#6d6d6d;
		   text-aling:center;

		}
		div.a {
   		text-aling:center;
		} 

		</style>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" bgcolor="#E6E6E6" >
<div id="caja_centro">	
    <form id="info" method="post" runat="server">	
        <h4 style="color:black">&nbsp&nbsp&nbsp&nbsp&nbsp Información de Usuario</h4>
        <hr>
        <br/>
        <div id="caja_info">
                  <div class="card" style="border: 6px solid #198754;">
  <div class="card-body">
    <table width="90%" id="user">
		        <tr>
			        <td width="10%" style="font-weight: bold; padding: 20px;">Nombre:</td>
			        <td width="20%"><asp:Label ID="lblName" Runat="server" /></td>
			        <td width="40%" rowspan="3">
			        </td>
		        </tr>
                
		        <tr>
			        <td width="10%" style="font-weight: bold; padding: 20px;">Apellido:</td>
			        <td width="20%"><asp:Label ID="lblApellido" Runat="server" /></td>
		        </tr>
		        <tr>
			        <td width="10%" style="font-weight: bold; padding: 20px;">Usuario:</td>
			        <td width="20%"><asp:Label ID="lblUsuario" Runat="server" /></td>
                <tr>
                    <td style="font-weight: bold; padding: 20px;">
                        Grupos:
                    </td>
                    <td>
                        <asp:ListBox ID="listaGrupos"  Width="95%" height="100%" runat="server" CssClass="form-control"></asp:ListBox>
                    </td>
                </tr>
	 </table>              
  </div>
</div> 
	        <br/>
	        
        </div>

    </form>
		
</div>
			
</body>
</html>

<script runat="server">

    void Page_Load(Object origen, EventArgs args)
    {
        login((string)Session["user"], (string)Session["pass"]);


        //errorLabel.Text = "";
        //lblActualPass.Visible = false;
        //txtActualPass.Visible = false;
        //lblNuevaPass.Visible = false;
        //txtNewPass.Visible = false;
        //lblConfirmPass.Visible = false;
        //txtConfirmPass.Visible = false;
        //btnConfirm.Visible = false;
    }

    void login(string nom, string pass)
    {
        string adPath = "LDAP://" + Session["dominio"];
        LDAPAutenticador aut = new LDAPAutenticador(adPath);
        ArrayList gruposDe = new ArrayList();
        ArrayList propUsuarios = new ArrayList();

        try
        {
            if (aut.autenticado((string)Session["dominio"], (string)Session["user"], (string)Session["pass"]) == true)
            {
                lblUsuario.Text = aut.getCN();

                propUsuarios = aut.getListaPropiedades();
                //ddlUsuarios.Items.Clear();
                //ddlUsuarios.Items.Add(new ListItem(propUsuarios[0] as string));

                if(propUsuarios.Count >1)
                {
                    lblName.Text = propUsuarios[1] as string;
                    lblApellido.Text = propUsuarios[2] as string;
                    lblUsuario.Text = propUsuarios[0] as string;
                    //lblTitulo.Text = propUsuarios[3] as string;
                    //lblcompañia.Text = propUsuarios[4] as string;
                }

                llenarGrupos(lblUsuario.Text);

                //gruposDe = aut.GetGroups();
                //listaGrupos.Items.Clear();
                //for (int i = 0; i < gruposDe.Count; i++)
                //{
                //    listaGrupos.Items.Add(new ListItem(gruposDe[i] as string));
                //    if (gruposDe[i] as string == "Administrators")
                //    {
                //        Response.Write("Bienvenido administrador");
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "error",    "alert('" + ex.ToString() + "');", true);
            Response.Redirect("inicio.aspx");
        }

    }

    void llenarGrupos(string cn)
    {
        string adPath = "LDAP://" + Session["dominio"];
        LDAPAutenticador aut = new LDAPAutenticador(adPath);
        ArrayList gruposDe = new ArrayList();
        ArrayList todosLosUsuarios = new ArrayList();
        gruposDe = aut.GetGroups(cn);
        listaGrupos.Items.Clear();
        for (int i = 0; i < gruposDe.Count; i++)
        {
            listaGrupos.Items.Add(new ListItem(gruposDe[i] as string));
            if(gruposDe[i] as string == "administrators")
            {
                Response.Write("Bienvenido administrador");
                //llamar todos los usuarios y agregarlos al ddl
                todosLosUsuarios = aut.getTodosUsuarios();
                //for(int e =0; e<todosLosUsuarios.Count; e++)
                //{
                //    ddlUsuarios.Items.Add(new ListItem(todosLosUsuarios[e] as string));
                //}
            }
        }
    }




</script>
