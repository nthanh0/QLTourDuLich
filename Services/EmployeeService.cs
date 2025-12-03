using Oracle.ManagedDataAccess.Client;
using QLTourDuLich.Models;

namespace QLTourDuLich.Services
{
    public class EmployeeService
    {
        private readonly OracleDbService _dbService;

        public EmployeeService(OracleDbService dbService)
        {
            _dbService = dbService;
        }

        public async Task<List<Employee>> GetAllEmployeesAsync()
        {
            var query = "SELECT EmployeeId, FullName, Email, PhoneNum, Department, Position, AccountId FROM Employees ORDER BY EmployeeId";
            return await _dbService.ExecuteQueryAsync(query, reader => new Employee
            {
                EmployeeId = reader.GetInt32(0),
                FullName = reader.GetString(1),
                Email = reader.IsDBNull(2) ? null : reader.GetString(2),
                PhoneNum = reader.IsDBNull(3) ? null : reader.GetString(3),
                Department = reader.IsDBNull(4) ? null : reader.GetString(4),
                Position = reader.IsDBNull(5) ? null : reader.GetString(5),
                AccountId = reader.IsDBNull(6) ? null : reader.GetInt32(6)
            });
        }

        public async Task<Employee?> GetEmployeeByIdAsync(int id)
        {
            var query = "SELECT EmployeeId, FullName, Email, PhoneNum, Department, Position, AccountId FROM Employees WHERE EmployeeId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            var result = await _dbService.ExecuteQueryAsync(query, reader => new Employee
            {
                EmployeeId = reader.GetInt32(0),
                FullName = reader.GetString(1),
                Email = reader.IsDBNull(2) ? null : reader.GetString(2),
                PhoneNum = reader.IsDBNull(3) ? null : reader.GetString(3),
                Department = reader.IsDBNull(4) ? null : reader.GetString(4),
                Position = reader.IsDBNull(5) ? null : reader.GetString(5),
                AccountId = reader.IsDBNull(6) ? null : reader.GetInt32(6)
            }, parameters);
            return result.FirstOrDefault();
        }

        public async Task<int> CreateEmployeeAsync(Employee employee)
        {
            var query = @"INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
                         VALUES (:name, :email, :phone, :dept, :pos, :accId)";
            var parameters = new[]
            {
                new OracleParameter("name", employee.FullName),
                new OracleParameter("email", (object?)employee.Email ?? DBNull.Value),
                new OracleParameter("phone", (object?)employee.PhoneNum ?? DBNull.Value),
                new OracleParameter("dept", (object?)employee.Department ?? DBNull.Value),
                new OracleParameter("pos", (object?)employee.Position ?? DBNull.Value),
                new OracleParameter("accId", (object?)employee.AccountId ?? DBNull.Value)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> UpdateEmployeeAsync(Employee employee)
        {
            var query = @"UPDATE Employees SET FullName = :name, Email = :email, PhoneNum = :phone, 
                         Department = :dept, Position = :pos, AccountId = :accId 
                         WHERE EmployeeId = :id";
            var parameters = new[]
            {
                new OracleParameter("name", employee.FullName),
                new OracleParameter("email", (object?)employee.Email ?? DBNull.Value),
                new OracleParameter("phone", (object?)employee.PhoneNum ?? DBNull.Value),
                new OracleParameter("dept", (object?)employee.Department ?? DBNull.Value),
                new OracleParameter("pos", (object?)employee.Position ?? DBNull.Value),
                new OracleParameter("accId", (object?)employee.AccountId ?? DBNull.Value),
                new OracleParameter("id", employee.EmployeeId)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> DeleteEmployeeAsync(int id)
        {
            var query = "DELETE FROM Employees WHERE EmployeeId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }
    }
}
