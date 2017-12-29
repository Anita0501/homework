<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Net.Http" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        HttpClient client = new HttpClient();
        client.BaseAddress = new Uri("http://localhost:54581/");
        HttpResponseMessage resp = client.GetAsync("api/motto").Result;
        if (resp.IsSuccessStatusCode)
        {
            //Label1.Text = resp.Content.ReadAsStringAsync().Result;
            Label1.Text = resp.Content.ReadAsAsync<string>().Result;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show Motto" />
    <asp:Label ID="Label1" runat="server"></asp:Label>
</asp:Content>

