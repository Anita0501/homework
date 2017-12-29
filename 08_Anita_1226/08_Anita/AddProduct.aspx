<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" ErrorPage="~/ErroInfo.html" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">


    protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        FileUpload fd = DetailsView1.Rows[3].Cells[1].Controls[1] as FileUpload;

        //e.Command.Parameters["@Image"].Value = fd.FileBytes;
        if (fd.HasFile)
        {
            e.Command.Parameters["@Image"].Value = fd.FileName;
        }
    }



    protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        FileUpload fd = DetailsView1.Rows[3].Cells[1].Controls[1] as FileUpload;
        if (fd.HasFile)
        {
            fd.SaveAs(Server.MapPath(@"image\") + fd.FileName);
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" DefaultMode="Insert" Height="50px" Width="125px">
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
            <asp:TemplateField HeaderText="Image">
                <InsertItemTemplate>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowInsertButton="True" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Product] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Product] ([Name], [Price], [Image]) VALUES (@Name, @Price, @Image)" SelectCommand="SELECT * FROM [Product]" UpdateCommand="UPDATE [Product] SET [Name] = @Name, [Price] = @Price, [Image] = @Image WHERE [ID] = @ID" OnInserting="SqlDataSource1_Inserting" OnInserted="SqlDataSource1_Inserted">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Price" Type="Int32" />
            <asp:Parameter Name="Image" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Price" Type="Int32" />
            <asp:Parameter Name="Image" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

