using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace QLTourDuLich.Services
{
    public class OracleDbService
    {
        private readonly string _connectionString;

        public OracleDbService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("OracleConnection") 
                ?? throw new InvalidOperationException("Connection string not found");
        }

        public OracleConnection GetConnection()
        {
            return new OracleConnection(_connectionString);
        }

        public async Task<List<T>> ExecuteQueryAsync<T>(string query, Func<OracleDataReader, T> map, OracleParameter[]? parameters = null)
        {
            var results = new List<T>();
            using var connection = GetConnection();
            using var command = new OracleCommand(query, connection);
            
            if (parameters != null)
                command.Parameters.AddRange(parameters);

            await connection.OpenAsync();
            using var reader = await command.ExecuteReaderAsync();
            
            while (await reader.ReadAsync())
            {
                results.Add(map(reader));
            }

            return results;
        }

        public async Task<int> ExecuteNonQueryAsync(string query, OracleParameter[]? parameters = null)
        {
            using var connection = GetConnection();
            using var command = new OracleCommand(query, connection);
            
            if (parameters != null)
                command.Parameters.AddRange(parameters);

            await connection.OpenAsync();
            return await command.ExecuteNonQueryAsync();
        }

        public async Task<object?> ExecuteScalarAsync(string query, OracleParameter[]? parameters = null)
        {
            using var connection = GetConnection();
            using var command = new OracleCommand(query, connection);
            
            if (parameters != null)
                command.Parameters.AddRange(parameters);

            await connection.OpenAsync();
            return await command.ExecuteScalarAsync();
        }
    }
}
