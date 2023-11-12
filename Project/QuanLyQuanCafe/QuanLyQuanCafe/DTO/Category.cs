using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class Category
    {
        public Category(int id, string name) 
        {
            this.iD = id;
            this.Name = name;
        }

        public Category(DataRow row) 
        {
            this.ID = (int)row["id"];  
            this.Name = row["name"].ToString();
        }

        private string name;
        public string Name { get => name; set => name = value; }

        private int iD;
        public int ID { get => iD; set => iD = value; }
        
    }
}
