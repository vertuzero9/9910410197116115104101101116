using System;
using Oracle.ManagedDataAccess.Client;

namespace RemoteOracleQuery
{
    class Program
    {
        static void Main(string[] args)
        {
            // Connection string to the Oracle database
            string connectionString = "User Id=your_username;Password=your_password;Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=your_host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=your_service_name)));";

            // Query to execute
            string query = "SELECT * FROM your_table_name WHERE ROWNUM <= 10";

            try
            {
                // Create a new Oracle connection
                using (OracleConnection connection = new OracleConnection(connectionString))
                {
                    // Open the connection
                    connection.Open();
                    Console.WriteLine("Connection to Oracle database established successfully.");

                    // Execute the query
                    using (OracleCommand command = new OracleCommand(query, connection))
                    {
                        using (OracleDataReader reader = command.ExecuteReader())
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
                    using (OracleCommand command = new OracleCommand(nonQuery, connection))
                    {
                        int rowsAffected = command.ExecuteNonQuery();
                        Console.WriteLine($"Rows affected: {rowsAffected}");
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("Oracle Error: " + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
