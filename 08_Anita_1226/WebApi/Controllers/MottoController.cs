using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApi.Controllers
{
    public class MottoController : ApiController
    {
        // GET: api/Motto
        public string Get()
        {
            return Data();
        }

        // GET: api/Motto/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Motto
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Motto/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Motto/5
        public void Delete(int id)
        {
        }

        public string Data()
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string motto = "";
            Random rand = new Random();
            int a = rand.Next(1, 11);
            using (var conn = new SqlConnection(connString))
            {
                SqlCommand com = new SqlCommand($"Select Motto From [Motto] where Id ={a}", conn);
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

    }
}
