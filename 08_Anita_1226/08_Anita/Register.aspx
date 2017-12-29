<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" ErrorPage="~/ErroInfo.html" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        ////Response.Write(e.Command.Parameters["@ID"].Value);
        //SqlCommand cmd = new SqlCommand(
        //   "select Count(ID) from [User] where ID ='" + ID + "'");

        //if (Convert.ToInt32(cmd.ExecuteScalar()) != 0)
        //{
        //    Label1.Text = "此帳號已存在";
        //}

    }

    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        TextBox ID = FormView1.FindControl("IDTextBox") as TextBox;
        //e.Cancel = false;
        SqlConnection cn = new SqlConnection(
            System.Web.Configuration.WebConfigurationManager.
            ConnectionStrings["ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand(
   "select Count(ID) from [User] where ID ='" + ID.Text + "'", cn);

        cn.Open();
        //int a = Convert.ToInt32(cmd.ExecuteScalar());
        if (Convert.ToInt32(cmd.ExecuteScalar()) != 0)
        {
            Label1.Text = Resources.MessageText.RegisterFailed;
            e.Cancel = true;
        }
        cn.Close();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" Height="185px" OnItemInserting="FormView1_ItemInserting" meta:resourcekey="FormView1Resource1">
        <EditItemTemplate>
            ID:
            <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' meta:resourcekey="IDLabel1Resource1" />
            <br />
            PW:
            <asp:TextBox ID="PWTextBox" runat="server" Text='<%# Bind("PW") %>' meta:resourcekey="PWTextBoxResource1" />
            <br />
            Name:
            <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="NameTextBoxResource1" />
            <br />
            Email:
            <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' meta:resourcekey="EmailTextBoxResource1" />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" meta:resourcekey="UpdateButtonResource1" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消註冊" meta:resourcekey="UpdateCancelButtonResource1" />
        </EditItemTemplate>
        <InsertItemTemplate>
            <asp:Label ID="Label2" runat="server" Text="ID:" meta:resourcekey="Label2Resource1"></asp:Label>
            <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' meta:resourcekey="IDTextBoxResource1" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="IDTextBox" ErrorMessage="*" SetFocusOnError="True" meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="IDTextBox" ErrorMessage="帳號格式不符" ValidationExpression=".{5,10}" meta:resourcekey="RegularExpressionValidator2Resource1"></asp:RegularExpressionValidator>
            <br />
            <asp:Label ID="Label3" runat="server" Text="PW:" meta:resourcekey="Label3Resource1"></asp:Label>
            <asp:TextBox ID="PWTextBox" Type="Password" runat="server" Text='<%# Bind("PW") %>' meta:resourcekey="PWTextBoxResource2" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PWTextBox" ErrorMessage="*" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="PWTextBox" ErrorMessage="密碼格式不符" ValidationExpression=".{5,12}" meta:resourcekey="RegularExpressionValidator3Resource1"></asp:RegularExpressionValidator>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Name:" meta:resourcekey="Label4Resource1"></asp:Label>
            <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="NameTextBoxResource2" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="NameTextBox" ErrorMessage="*" meta:resourcekey="RequiredFieldValidator3Resource1"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="NameTextBox" ErrorMessage="姓名格式不符" ValidationExpression="[a-z A-Z]+" meta:resourcekey="RegularExpressionValidator4Resource1"></asp:RegularExpressionValidator>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Email:" meta:resourcekey="Label5Resource1"></asp:Label>
            <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' meta:resourcekey="EmailTextBoxResource2" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="EmailTextBox" ErrorMessage="格式錯誤" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" meta:resourcekey="RegularExpressionValidator1Resource1"></asp:RegularExpressionValidator>
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="註冊帳號" OnClick="InsertButton_Click" meta:resourcekey="InsertButtonResource1" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消註冊" PostBackUrl="~/Login.aspx" meta:resourcekey="InsertCancelButtonResource1" />
        </InsertItemTemplate>
        <ItemTemplate>
            ID:
            <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' meta:resourcekey="IDLabelResource1" />
            <br />
            PW:
            <asp:Label ID="PWLabel" runat="server" Text='<%# Bind("PW") %>' meta:resourcekey="PWLabelResource1" />
            <br />
            Name:
            <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' meta:resourcekey="NameLabelResource1" />
            <br />
            Email:
            <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' meta:resourcekey="EmailLabelResource1" />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" meta:resourcekey="EditButtonResource1" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" meta:resourcekey="DeleteButtonResource1" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" meta:resourcekey="NewButtonResource1" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [User] WHERE [ID] = @ID" InsertCommand="INSERT INTO [User] ([ID], [PW], [Name], [Email]) VALUES (@ID, @PW, @Name, @Email)" SelectCommand="SELECT * FROM [User]" UpdateCommand="UPDATE [User] SET [PW] = @PW, [Name] = @Name, [Email] = @Email WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID" Type="String" />
            <asp:Parameter Name="PW" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PW" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource3"></asp:Label>
</asp:Content>

