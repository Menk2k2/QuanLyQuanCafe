﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class DataProvider
    {
        private static DataProvider instance; // phím tắt đóng gói: CTRL + R + E

        public static DataProvider Instance
        {
            get { if ( instance == null ) instance = new DataProvider(); return DataProvider.instance; }
            private set { DataProvider.instance = value; }
        
        }

        private DataProvider(){}

        private  string conectionSTR = "Data Source=Admin\\SQLEXPRESS;Initial Catalog=QuanLyQuanCafe;Integrated Security=True";

        public DataTable ExcuteQuery(string query, object[] parameter = null) 
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(conectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);

                if (parameter != null ) 
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }

                SqlDataAdapter adapter = new SqlDataAdapter(command);

                adapter.Fill(data);

                connection.Close();
            }

            return data;
        }

        public int ExcuteNonQuery(string query, object[] parameter = null)
        {
            int data = 0;

            using (SqlConnection connection = new SqlConnection(conectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);


                if (parameter != null)
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }
                
                data= command.ExecuteNonQuery();

                connection.Close();
            }

            return data;
        }
        public object ExcuteScalar(string query, object[] parameter = null)
        {
            object data = 0;

            using (SqlConnection connection = new SqlConnection(conectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);


                if (parameter != null)
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }

                data = command.ExecuteScalar();

                connection.Close();
            }

            return data;
        }
    }
}
