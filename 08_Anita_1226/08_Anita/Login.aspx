<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" ErrorPage="~/ErroInfo.html" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {

        SqlConnection cn = new SqlConnection(
                    System.Web.Configuration.WebConfigurationManager.
                    ConnectionStrings["ConnectionString"].ConnectionString);

        SqlCommand cmd = new SqlCommand(
           "select ID,PW,Name from [User] where ID ='" + TextBox1.Text + "' and PW='" + TextBox2.Text + "'", cn);

        cn.Open();
        SqlDataReader reader = cmd.ExecuteReader();

        if (reader.HasRows)
        {
            while (reader.Read())
            {
                FormsAuthentication.RedirectFromLoginPage(TextBox1.Text, false);
                Label3.Text = Resources.MessageText.loginSuccess;
                //Session["id"] = TextBox1.Text;
                Session["userName"] = reader.GetString(2);
                Response.Redirect("~/Home.aspx");
            }
        }
        else
        {
            Label3.Text = Resources.MessageText.loginFailed;
        }
        reader.Close();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Label ID="Label1" runat="server" AssociatedControlID="TextBox1" Text="ID" meta:resourcekey="Label1Resource1"></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server" meta:resourcekey="TextBox1Resource1"></asp:TextBox>
    <br />
    <asp:Label ID="Label2" runat="server" AssociatedControlID="TextBox2" Text="PW" meta:resourcekey="Label2Resource1"></asp:Label>
    <asp:TextBox ID="TextBox2" runat="server" Type="Password" meta:resourcekey="TextBox2Resource1"></asp:TextBox>
    <br />
    <asp:Label ID="Label3" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
    <br />
    <asp:Button ID="Button1" runat="server" Text="登入" OnClick="Button1_Click" meta:resourcekey="Button1Resource1" />

</asp:Content>

