<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write(Get());
    }

    public string Get()
    {
        return GetData();
    }

    public string GetData()
    {
        string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        string motto = "";
        Random rand = new Random();
        int a = rand.Next(1, 11);
        using (var conn = new SqlConnection(connString))
        {
            SqlCommand com = new SqlCommand("Select Id,Motto From [Motto] where Id ='" + a + "'", conn);
            conn.Open();
            using (SqlDataReader reader = com.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        motto = reader.GetString(1);
                    }
                }
            }
        }
        //com.CommandType = CommandType.StoredProcedure;
        return motto;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
