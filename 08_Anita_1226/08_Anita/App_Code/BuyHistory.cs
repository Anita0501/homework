using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class BuyHistory
{
    public int ID;
    public string Name;
    public int Price;
    public int Amount;
    public int UserId;
    public int OrderNumber;
    public BuyHistory( int id, int amount)
    {
        ID = id;
        Amount = amount;
    }
    public BuyHistory(int id)
    {
        ID = id;
    }
}