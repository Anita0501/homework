using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for QueryUtility
/// </summary>
public class QueryUtility
{
   public string SQLString(List<BuyHistory> tmpList)
    {
        string str = "SELECT * FROM [Product] WHERE";

        for (int i = 0; i < tmpList.Count; i++)
        {
            str += "([ID] =" + tmpList[i].ID + ") OR";
        }
        return str = (str.TrimEnd('R')).TrimEnd('O');
    }
}