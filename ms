using System;
using System.Data.SqlClient;

namespace RemoteSqlQuery
{
    class Program
    {
        static void Main(string[] args)
        {
            // Connection string to the remote SQL server
            string connectionString = "Server=your_server_name;Database=your_database_name;User Id=your_username;Password=your_password;";

            // Query to execute
            string query = "SELECT TOP 10 * FROM your_table_name";

            try
            {
                // Create a new SQL connection
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Open the connection
                    connection.Open();
                    Console.WriteLine("Connection to database established successfully.");

                    // Execute the query
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            // Process the results
                            while (reader.Read())
                            {
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    Console.Write(reader[i] + "\t");
                                }
                                Console.WriteLine();
                            }
                        }
                    }

                    // Example of executing a non-query (e.g., insert, update, delete)
                    string nonQuery = "UPDATE your_table_name SET column_name = 'new_value' WHERE condition";
                    using (SqlCommand command = new SqlCommand(nonQuery, connection))
                    {
                        int rowsAffected = command.ExecuteNonQuery();
                        Console.WriteLine($"Rows affected: {rowsAffected}");
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error: " + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
