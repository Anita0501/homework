<%@ Page Title="" Language="C#" MasterPageFile="~/DuckMasterPage.master" ErrorPage="~/ErroInfo.html" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        List<BuyHistory> buyHistoryList = Session["BuyList"] as List<BuyHistory>;
        int totalPrice = 0;
        int price = 0;
        int amount = 0;
        //產生T-SQL
        QueryUtility qu = new QueryUtility();
        SqlDataSource1.SelectCommand = qu.SQLString(buyHistoryList);

        TableCell amountHeaderRowCell = new TableCell();
        amountHeaderRowCell.Text = "數量";
        BuyListGridView.HeaderRow.Cells.Add(amountHeaderRowCell);

        TableCell totalPriceHeaderRowCell = new TableCell();
        totalPriceHeaderRowCell.Text = "合計";
        BuyListGridView.HeaderRow.Cells.Add(totalPriceHeaderRowCell);

        for (int i = 0; i < BuyListGridView.Rows.Count; i++)
        {
            //新增商品數量欄位
            TableCell amountCell = new TableCell();
            amountCell.Text = buyHistoryList[i].Amount.ToString();
            BuyListGridView.Rows[i].Cells.Add(amountCell);

            //新增商品總價欄位
            TableCell priceCell = new TableCell();
            price = int.Parse(BuyListGridView.Rows[i].Cells[2].Text.TrimEnd('元'));
            amount = buyHistoryList[i].Amount;
            priceCell.Text = (price * amount).ToString("#,###元");
            BuyListGridView.Rows[i].Cells.Add(priceCell);
            totalPrice += price * amount;
        }
        TableRow totalPriceRow = new TableRow();
        TableCell textCell = new TableCell();
        TableCell totalPriceCell = new TableCell();
        textCell.Text = "本次消費總金額";
        totalPriceCell.Text = totalPrice.ToString("##,###元");
        totalPriceRow.Cells.Add(textCell);
        totalPriceRow.Cells.Add(totalPriceCell);
        thisTimeOrderTable.Rows.Add(totalPriceRow);
        Session["BuyList"] = null;
        Session["shoppingCarList"] = null;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:GridView ID="BuyListGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1">
        <Columns>
            <%--品名--%>
            <asp:BoundField DataField="Name" HeaderText="品名" SortExpression="Name"></asp:BoundField>     
            <%--圖片--%>
            <asp:ImageField DataImageUrlField="Image" HeaderText="圖片" DataImageUrlFormatString="image/{0}">
                <ControlStyle Height="100px" />
            </asp:ImageField>
            <%--價格--%>
            <asp:BoundField DataField="Price" HeaderText="價格" SortExpression="Price" DataFormatString="{0}元"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1"
        ConnectionString='<%$ ConnectionStrings:ConnectionString %>'></asp:SqlDataSource>
    <asp:Table ID="thisTimeOrderTable" runat="server"></asp:Table>
</asp:Content>

