using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DTO
{
    public class Food
    {   
        public Food(int id,string name, int categoryID, float price ) 
        {
            this.ID = id;
            this.Name = name;
            this.CategoryID = categoryID;
            this.Price = price;
        }

        public Food(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.CategoryID = (int)row["idcategory"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
        }

        private float price;
        public float Price { get => price; set => price = value; }
        private int categoryID;
        public int CategoryID { get => categoryID; set => categoryID = value; }

        private string name;
        public string Name { get => name; set => name = value; }

        private int iD;
        public int ID
        {
            get => iD;
            set => iD = value;
        }
     
    }
}
