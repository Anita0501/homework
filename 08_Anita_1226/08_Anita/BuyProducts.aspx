<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" ErrorPage="~/ErroInfo.html" %>
<%@ Import Namespace ="System.IO" %>

<script runat="server">

    protected void submitButton_Click(object sender, EventArgs e)
    {
        //所有購買物品的LIST
        List<BuyHistory> buyList = new List<BuyHistory>();

        //若Session["shoppingCarList"]已有值存在 則先將session加到buyList
        if(Session["shoppingCarList"] != null)
        {
            buyList = Session["shoppingCarList"] as List<BuyHistory>;
        }

        //將所點選的商品ID新增到buyList內
        for (int i = 0; i < ProductGridView.Rows.Count; i++)
        {
            if (ProductGridView.Rows[i].RowType == DataControlRowType.DataRow)
            {
                CheckBox ck = ProductGridView.Rows[i].Cells[3].Controls[1] as CheckBox;
                if (ck.Checked)
                {
                    buyList.Add(new BuyHistory( int.Parse(ProductGridView.DataKeys[i].Value.ToString())));
                }
            }
        }
        //是否登入  (這邊要不要打開都可以 購物車還有再做一次確認)
        //if (Session["id"] == null)
        //{
        //    alertNotLogin.Text = "請先登入會員";
        //    Session["shoppingCarList"] = buyList;
        //    return;
        //}

        //購物車內沒有任何商品不得結帳
        if( buyList.Count == 0)
        {
            alertNotLogin.Text = "請先選擇商品";
            return;
        }
        //將購物車的清單存入session 並轉到購物車頁面
        Session["shoppingCarList"] = buyList;
        Response.Redirect("~/ShoppingCar.aspx");
    }
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="alertNotLogin" runat="server" ></asp:Label>
    <!--productList-->
    <asp:GridView ID="ProductGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1">
        <Columns>
            <%--品名欄位--%>
            <asp:BoundField DataField="Name" HeaderText="品名" SortExpression="Name"></asp:BoundField>
            <%--圖片欄位--%>
            <asp:ImageField DataImageUrlField="Image" DataImageUrlFormatString="image/{0}" HeaderText="商品圖片">
                <ControlStyle Height="100px" />
            </asp:ImageField>
            <%--價格欄位--%>
            <asp:BoundField DataField="Price" HeaderText="價格" SortExpression="Price" DataFormatString="{0}元"></asp:BoundField>
            <%--勾選欄位--%>
            <asp:TemplateField HeaderText="Buy!!">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1"
        ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
        SelectCommand="SELECT * FROM [Product]"></asp:SqlDataSource>
    <!--按鈕-->
    <asp:Button ID="submitButton" runat="server" Text="Buy it!" OnClick="submitButton_Click" />
</asp:Content>

