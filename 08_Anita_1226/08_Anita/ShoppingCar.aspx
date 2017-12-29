<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" ErrorPage="~/ErroInfo.html" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        List<BuyHistory> shoppingCarList = Session["shoppingCarList"] as List<BuyHistory>;
        //當buyList為空值或count為0時 則顯示尚未選擇商品
        if (shoppingCarList == null || shoppingCarList.Count == 0)
        {
            showShoppingCarLabel.Text = "您尚未選擇商品";
            return;
        }
        //當buyList不為0或NULL時 則將LIST中包含的ID進行查詢
        //以顯示使用者所購買的商品
        QueryUtility qu = new QueryUtility();
        SqlDataSource1.SelectCommand = qu.SQLString(shoppingCarList);
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        //確認購買
        //宣告一個BuyHistory的LIST=>buyHistoryList        
        List<BuyHistory> ShoppingCarList = Session["shoppingCarList"] as List<BuyHistory>;

        //如果購物車內沒有商品
        if (Session["shoppingCarList"] == null || ShoppingCarList.Count == 0 )
        {
            showShoppingCarLabel.Text = "您尚未選擇商品，請先選擇商品";
            return;
        }

        //將所有使用者所購買的資訊(ID AMOUNT)放入LIST，如果amount為0則不放入list中
        //以SESSION方式儲存
        List<BuyHistory> finalBuyProductList = new List<BuyHistory>();
        for (int i = 0; i < ProductGridView.Rows.Count; i++)
        {
            DropDownList ddl = ProductGridView.Rows[i].Cells[3].Controls[1] as DropDownList;
            finalBuyProductList.Add(new BuyHistory(int.Parse(ProductGridView.DataKeys[i].Value.ToString()), int.Parse(ddl.SelectedValue)));
        }

        //是否登入 (這邊要打開)
        if (Session["id"] == null)
        {
            isLogInLable.Text = "您尚未登入，請先登入";
            return;
        }

        //將最後所購買的清單存在Session["BuyList"]
        Session["BuyList"] = finalBuyProductList;
        Server.Transfer("~/Payment.aspx");
    }
    //繼續購物
    protected void GoShopping_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BuyProducts.aspx");
    }
    //刪除購物車內的商品
    protected void DeleteButton_Click(object sender, EventArgs e)
    {

        int id = int.Parse(((Button)sender).CommandName);
        List<BuyHistory> buyHistoryList = Session["shoppingCarList"] as List<BuyHistory>;
        List<BuyHistory> tmpList = buyHistoryList.Where(b => b.ID != id).ToList();
        Session["shoppingCarList"] = tmpList;
        if(tmpList.Count == 0)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Product] WHERE [ID] = 0";
            return;
        }
        QueryUtility qu = new QueryUtility();

        SqlDataSource1.SelectCommand = qu.SQLString(tmpList);
        #region 很長的程式碼
        ////ProductGridView.Rows.Count 不包含HeaderRow
        ////i為所有row中的第i row (headerRow 為0)
        //for (int i = 0; i < ProductGridView.Rows.Count; i++)
        //{
        //    //在封包中HeaderRow是由1開始 所以第一個DATAROW是2 以此類推 (headerRow 為1)
        //    if (Request.Form["ctl00$ContentPlaceHolder1$ProductGridView$ctl0" + (i + 2) + "$DeleteButton"] == "刪除")
        //    {
        //        List<BuyHistory> tmpBuyList = Session["shoppingCarList"] as List<BuyHistory>;
        //        //DataKeys的INDEX自Datarow開始算 即第一個dataRow的DataKeys為0 (沒有headerRow DataRow從0開始)
        //        //將不是選定ID的其他ID放入buyList
        //        List<BuyHistory> buyList = tmpBuyList.Where(t => t.ID != int.Parse(ProductGridView.DataKeys[i].Value.ToString())).ToList();
        //        Session["shoppingCarList"] = buyList;

        //        //用buyList中的ID進行查詢並產生TABLE
        //        QueryUtility qu = new QueryUtility();
        //        SqlDataSource1.SelectCommand = qu.SQLString(buyList);

        //        if( buyList.Count == 0)
        //        {
        //            SqlDataSource1.SelectCommand = "SELECT * FROM [Product] WHERE [ID] = 0";
        //            showShoppingCarLabel.Text = "您尚未選擇商品，請先選擇商品";
        //        }
        //        break;
        //    }
        //} 
        #endregion
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="isLogInLable" Text="" runat="server" />
    <br />
    <asp:Label ID="showShoppingCarLabel" runat="server" Text="您選購的商品:"></asp:Label>

    <asp:GridView ID="ProductGridView" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="ID" Width="390px">
        <Columns>
            <%--品名欄位--%>
            <asp:BoundField DataField="Name" HeaderText="品名" SortExpression="Name"></asp:BoundField>
            <%--圖片欄位--%>
            <asp:ImageField DataImageUrlField="Image" DataImageUrlFormatString="image\{0}" HeaderText="商品圖片">
                <ControlStyle Height="100px" />
            </asp:ImageField>
            <%--價格欄位--%>
            <asp:BoundField DataField="Price" HeaderText="價格" SortExpression="Price" DataFormatString="{0}元"></asp:BoundField>
            <%--選取數量--%>
            <asp:TemplateField HeaderText="數量">
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="5">5</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="DeleteButton" runat="server" Text="刪除" CommandName='<%# Eval("ID") %>' OnClick="DeleteButton_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <EmptyDataTemplate>
            <asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1"
        ConnectionString='<%$ ConnectionStrings:ConnectionString %>'></asp:SqlDataSource>
    <asp:Button Text="結帳" runat="server" OnClick="Submit_Click" />
    <asp:Button Text="繼續購物" runat="server" OnClick="GoShopping_Click" />
</asp:Content>

