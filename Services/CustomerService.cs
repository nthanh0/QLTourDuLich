using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using QLTourDuLich.Models;
using System.Data;

namespace QLTourDuLich.Services
{
    public class CustomerService
    {
        private readonly OracleDbService _dbService;

        public CustomerService(OracleDbService dbService)
        {
            _dbService = dbService;
        }

        public async Task<List<Customer>> GetAllCustomersAsync()
        {
            var query = "SELECT CustomerId, FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId FROM Customers ORDER BY CustomerId";
            return await _dbService.ExecuteQueryAsync(query, reader => new Customer
            {
                CustomerId = reader.GetInt32(0),
                FullName = reader.GetString(1),
                Email = reader.IsDBNull(2) ? null : reader.GetString(2),
                Address = reader.IsDBNull(3) ? null : reader.GetString(3),
                Telephone = reader.IsDBNull(4) ? null : reader.GetString(4),
                DateOfBirth = reader.IsDBNull(5) ? null : reader.GetDateTime(5),
                IdentityNum = reader.IsDBNull(6) ? null : reader.GetString(6),
                AccountId = reader.IsDBNull(7) ? null : reader.GetInt32(7)
            });
        }

        public async Task<Customer?> GetCustomerByIdAsync(int id)
        {
            var query = "SELECT CustomerId, FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId FROM Customers WHERE CustomerId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            var result = await _dbService.ExecuteQueryAsync(query, reader => new Customer
            {
                CustomerId = reader.GetInt32(0),
                FullName = reader.GetString(1),
                Email = reader.IsDBNull(2) ? null : reader.GetString(2),
                Address = reader.IsDBNull(3) ? null : reader.GetString(3),
                Telephone = reader.IsDBNull(4) ? null : reader.GetString(4),
                DateOfBirth = reader.IsDBNull(5) ? null : reader.GetDateTime(5),
                IdentityNum = reader.IsDBNull(6) ? null : reader.GetString(6),
                AccountId = reader.IsDBNull(7) ? null : reader.GetInt32(7)
            }, parameters);
            return result.FirstOrDefault();
        }

        // S? D?NG STORED PROCEDURE: SP_CreateCustomer
        public async Task<(int CustomerId, string Message)> CreateCustomerAsync(Customer customer)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SP_CreateCustomer";
                command.CommandType = CommandType.StoredProcedure;
                
                // Input parameters
                command.Parameters.Add("p_FullName", OracleDbType.NVarchar2).Value = customer.FullName;
                command.Parameters.Add("p_Email", OracleDbType.Varchar2).Value = (object?)customer.Email ?? DBNull.Value;
                command.Parameters.Add("p_Telephone", OracleDbType.Varchar2).Value = (object?)customer.Telephone ?? DBNull.Value;
                command.Parameters.Add("p_Address", OracleDbType.NVarchar2).Value = (object?)customer.Address ?? DBNull.Value;
                command.Parameters.Add("p_DateOfBirth", OracleDbType.Date).Value = (object?)customer.DateOfBirth ?? DBNull.Value;
                command.Parameters.Add("p_IdentityNum", OracleDbType.Varchar2).Value = (object?)customer.IdentityNum ?? DBNull.Value;
                command.Parameters.Add("p_AccountId", OracleDbType.Int32).Value = (object?)customer.AccountId ?? DBNull.Value;
                
                // Output parameters
                var customerIdParam = command.Parameters.Add("p_CustomerId", OracleDbType.Int32);
                customerIdParam.Direction = ParameterDirection.Output;
                
                var messageParam = command.Parameters.Add("p_Message", OracleDbType.Varchar2, 500);
                messageParam.Direction = ParameterDirection.Output;
                
                command.ExecuteNonQuery();
                
                int customerId = customerIdParam.Value != DBNull.Value ? Convert.ToInt32(customerIdParam.Value.ToString()) : -1;
                string message = messageParam.Value?.ToString() ?? "L?i không xác ??nh";
                
                return (customerId, message);
            });
        }

        public async Task<int> UpdateCustomerAsync(Customer customer)
        {
            var query = @"UPDATE Customers SET FullName = :name, Email = :email, Address = :address, 
                         Telephone = :tel, DateOfBirth = :dob, IdentityNum = :idNum, AccountId = :accId 
                         WHERE CustomerId = :id";
            var parameters = new[]
            {
                new OracleParameter("name", customer.FullName),
                new OracleParameter("email", (object?)customer.Email ?? DBNull.Value),
                new OracleParameter("address", (object?)customer.Address ?? DBNull.Value),
                new OracleParameter("tel", (object?)customer.Telephone ?? DBNull.Value),
                new OracleParameter("dob", (object?)customer.DateOfBirth ?? DBNull.Value),
                new OracleParameter("idNum", (object?)customer.IdentityNum ?? DBNull.Value),
                new OracleParameter("accId", (object?)customer.AccountId ?? DBNull.Value),
                new OracleParameter("id", customer.CustomerId)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> DeleteCustomerAsync(int id)
        {
            var query = "DELETE FROM Customers WHERE CustomerId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        // S? D?NG FUNCTION: FN_GetCustomerTotalSpent
        public async Task<decimal> GetCustomerTotalSpentAsync(int customerId)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SELECT FN_GetCustomerTotalSpent(:customerId) FROM DUAL";
                command.Parameters.Add("customerId", OracleDbType.Int32).Value = customerId;
                
                var result = command.ExecuteScalar();
                return result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            });
        }

        // S? D?NG FUNCTION: FN_GetCustomerRank
        public async Task<string> GetCustomerRankAsync(int customerId)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SELECT FN_GetCustomerRank(:customerId) FROM DUAL";
                command.Parameters.Add("customerId", OracleDbType.Int32).Value = customerId;
                
                var result = command.ExecuteScalar();
                return result?.ToString() ?? "Unknown";
            });
        }
    }
}
