using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.AccessControl;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance 
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set { BillDAO.instance = value; }
        }

        private BillDAO() {}

        /// Thành công: bill ID
        /// Thất Bại: -1
        
        public int GetUncheckBillIDByTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExcuteQuery("SELECT * FROM dbo.Bill WHERE idTable = " + id + "AND status = 0");
            if(data.Rows.Count > 0) // Nếu số trường trả về lớn hơn 0
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;

            }
            return -1; // Ngược lại nếu không có thì trả về -1
        }

        public void CheckOut(int id, int discount)
        {
            string query = " UPDATE dbo.Bill SET status = 1, " + "discount = " + discount + " WHERE id = " + id;
            DataProvider.Instance.ExcuteNonQuery(query);
        }


        public void InsertBill(int id)
        {
            DataProvider.Instance.ExcuteNonQuery("exec USP_InsertBill @idTable", new object[] {id});
        }

        public int GetMaxIDBill()
        {
            try
            {
                return (int)DataProvider.Instance.ExcuteScalar("SELECT MAX(id) FROM dbo.Bill");
            }
            catch
            {
                return 1;
            }
        }
    }
}
