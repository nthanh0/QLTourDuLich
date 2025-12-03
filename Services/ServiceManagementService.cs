using Oracle.ManagedDataAccess.Client;
using QLTourDuLich.Models;

namespace QLTourDuLich.Services
{
    public class ServiceManagementService
    {
        private readonly OracleDbService _dbService;

        public ServiceManagementService(OracleDbService dbService)
        {
            _dbService = dbService;
        }

        public async Task<List<Service>> GetAllServicesAsync()
        {
            var query = "SELECT ServiceId, ServiceType, ServiceName, Price FROM Services ORDER BY ServiceType, ServiceName";
            return await _dbService.ExecuteQueryAsync(query, reader => new Service
            {
                ServiceId = reader.GetInt32(0),
                ServiceType = reader.IsDBNull(1) ? null : reader.GetString(1),
                ServiceName = reader.IsDBNull(2) ? null : reader.GetString(2),
                Price = reader.IsDBNull(3) ? null : reader.GetDecimal(3)
            });
        }

        public async Task<Service?> GetServiceByIdAsync(int id)
        {
            var query = "SELECT ServiceId, ServiceType, ServiceName, Price FROM Services WHERE ServiceId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            var result = await _dbService.ExecuteQueryAsync(query, reader => new Service
            {
                ServiceId = reader.GetInt32(0),
                ServiceType = reader.IsDBNull(1) ? null : reader.GetString(1),
                ServiceName = reader.IsDBNull(2) ? null : reader.GetString(2),
                Price = reader.IsDBNull(3) ? null : reader.GetDecimal(3)
            }, parameters);
            return result.FirstOrDefault();
        }

        public async Task<int> CreateServiceAsync(Service service)
        {
            var query = @"INSERT INTO Services (ServiceType, ServiceName, Price) 
                         VALUES (:type, :name, :price)";
            var parameters = new[]
            {
                new OracleParameter("type", (object?)service.ServiceType ?? DBNull.Value),
                new OracleParameter("name", (object?)service.ServiceName ?? DBNull.Value),
                new OracleParameter("price", (object?)service.Price ?? DBNull.Value)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> UpdateServiceAsync(Service service)
        {
            var query = @"UPDATE Services SET ServiceType = :type, ServiceName = :name, Price = :price 
                         WHERE ServiceId = :id";
            var parameters = new[]
            {
                new OracleParameter("type", (object?)service.ServiceType ?? DBNull.Value),
                new OracleParameter("name", (object?)service.ServiceName ?? DBNull.Value),
                new OracleParameter("price", (object?)service.Price ?? DBNull.Value),
                new OracleParameter("id", service.ServiceId)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> DeleteServiceAsync(int id)
        {
            var query = "DELETE FROM Services WHERE ServiceId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }
    }
}
