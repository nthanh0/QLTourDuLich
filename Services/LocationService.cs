using Oracle.ManagedDataAccess.Client;
using QLTourDuLich.Models;

namespace QLTourDuLich.Services
{
    public class LocationService
    {
        private readonly OracleDbService _dbService;

        public LocationService(OracleDbService dbService)
        {
            _dbService = dbService;
        }

        public async Task<List<Location>> GetAllLocationsAsync()
        {
            var query = "SELECT LocationId, LocationName, Address, Description, LocationType FROM Locations ORDER BY LocationName";
            return await _dbService.ExecuteQueryAsync(query, reader => new Location
            {
                LocationId = reader.GetInt32(0),
                LocationName = reader.GetString(1),
                Address = reader.IsDBNull(2) ? null : reader.GetString(2),
                Description = reader.IsDBNull(3) ? null : reader.GetString(3),
                LocationType = reader.IsDBNull(4) ? null : reader.GetString(4)
            });
        }

        public async Task<Location?> GetLocationByIdAsync(int id)
        {
            var query = "SELECT LocationId, LocationName, Address, Description, LocationType FROM Locations WHERE LocationId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            var result = await _dbService.ExecuteQueryAsync(query, reader => new Location
            {
                LocationId = reader.GetInt32(0),
                LocationName = reader.GetString(1),
                Address = reader.IsDBNull(2) ? null : reader.GetString(2),
                Description = reader.IsDBNull(3) ? null : reader.GetString(3),
                LocationType = reader.IsDBNull(4) ? null : reader.GetString(4)
            }, parameters);
            return result.FirstOrDefault();
        }

        public async Task<int> CreateLocationAsync(Location location)
        {
            var query = @"INSERT INTO Locations (LocationName, Address, Description, LocationType) 
                         VALUES (:name, :address, :desc, :type)";
            var parameters = new[]
            {
                new OracleParameter("name", location.LocationName),
                new OracleParameter("address", (object?)location.Address ?? DBNull.Value),
                new OracleParameter("desc", (object?)location.Description ?? DBNull.Value),
                new OracleParameter("type", (object?)location.LocationType ?? DBNull.Value)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> UpdateLocationAsync(Location location)
        {
            var query = @"UPDATE Locations SET LocationName = :name, Address = :address, 
                         Description = :desc, LocationType = :type 
                         WHERE LocationId = :id";
            var parameters = new[]
            {
                new OracleParameter("name", location.LocationName),
                new OracleParameter("address", (object?)location.Address ?? DBNull.Value),
                new OracleParameter("desc", (object?)location.Description ?? DBNull.Value),
                new OracleParameter("type", (object?)location.LocationType ?? DBNull.Value),
                new OracleParameter("id", location.LocationId)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> DeleteLocationAsync(int id)
        {
            var query = "DELETE FROM Locations WHERE LocationId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }
    }
}
