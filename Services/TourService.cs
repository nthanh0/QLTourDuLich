using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using QLTourDuLich.Models;
using System.Data;

namespace QLTourDuLich.Services
{
    public class TourService
    {
        private readonly OracleDbService _dbService;

        public TourService(OracleDbService dbService)
        {
            _dbService = dbService;
        }

        public async Task<List<Tour>> GetAllToursAsync()
        {
            var query = "SELECT TourId, TourName, TourType, BasePrice, Duration, Description, ManagerId FROM Tours ORDER BY TourId";
            return await _dbService.ExecuteQueryAsync(query, reader => new Tour
            {
                TourId = reader.GetInt32(0),
                TourName = reader.GetString(1),
                TourType = reader.IsDBNull(2) ? null : reader.GetString(2),
                BasePrice = reader.IsDBNull(3) ? null : reader.GetDecimal(3),
                Duration = reader.IsDBNull(4) ? null : reader.GetString(4),
                Description = reader.IsDBNull(5) ? null : reader.GetString(5),
                ManagerId = reader.IsDBNull(6) ? null : reader.GetInt32(6)
            });
        }

        public async Task<Tour?> GetTourByIdAsync(int id)
        {
            var query = "SELECT TourId, TourName, TourType, BasePrice, Duration, Description, ManagerId FROM Tours WHERE TourId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            var result = await _dbService.ExecuteQueryAsync(query, reader => new Tour
            {
                TourId = reader.GetInt32(0),
                TourName = reader.GetString(1),
                TourType = reader.IsDBNull(2) ? null : reader.GetString(2),
                BasePrice = reader.IsDBNull(3) ? null : reader.GetDecimal(3),
                Duration = reader.IsDBNull(4) ? null : reader.GetString(4),
                Description = reader.IsDBNull(5) ? null : reader.GetString(5),
                ManagerId = reader.IsDBNull(6) ? null : reader.GetInt32(6)
            }, parameters);
            return result.FirstOrDefault();
        }

        // S? D?NG STORED PROCEDURE: SP_CreateTour
        public async Task<(int TourId, string Message)> CreateTourAsync(Tour tour)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SP_CreateTour";
                command.CommandType = CommandType.StoredProcedure;
                
                // Input parameters
                command.Parameters.Add("p_TourName", OracleDbType.NVarchar2).Value = tour.TourName;
                command.Parameters.Add("p_TourType", OracleDbType.NVarchar2).Value = (object?)tour.TourType ?? DBNull.Value;
                command.Parameters.Add("p_BasePrice", OracleDbType.Decimal).Value = (object?)tour.BasePrice ?? DBNull.Value;
                command.Parameters.Add("p_Duration", OracleDbType.NVarchar2).Value = (object?)tour.Duration ?? DBNull.Value;
                command.Parameters.Add("p_Description", OracleDbType.Clob).Value = (object?)tour.Description ?? DBNull.Value;
                command.Parameters.Add("p_ManagerId", OracleDbType.Int32).Value = (object?)tour.ManagerId ?? DBNull.Value;
                
                // Output parameters
                var tourIdParam = command.Parameters.Add("p_TourId", OracleDbType.Int32);
                tourIdParam.Direction = ParameterDirection.Output;
                
                var messageParam = command.Parameters.Add("p_Message", OracleDbType.Varchar2, 500);
                messageParam.Direction = ParameterDirection.Output;
                
                command.ExecuteNonQuery();
                
                int tourId = tourIdParam.Value != DBNull.Value ? Convert.ToInt32(tourIdParam.Value.ToString()) : -1;
                string message = messageParam.Value?.ToString() ?? "L?i không xác ??nh";
                
                return (tourId, message);
            });
        }

        // S? D?NG STORED PROCEDURE: SP_UpdateTour
        public async Task<(int Success, string Message)> UpdateTourAsync(Tour tour)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SP_UpdateTour";
                command.CommandType = CommandType.StoredProcedure;
                
                // Input parameters
                command.Parameters.Add("p_TourId", OracleDbType.Int32).Value = tour.TourId;
                command.Parameters.Add("p_TourName", OracleDbType.NVarchar2).Value = tour.TourName;
                command.Parameters.Add("p_TourType", OracleDbType.NVarchar2).Value = (object?)tour.TourType ?? DBNull.Value;
                command.Parameters.Add("p_BasePrice", OracleDbType.Decimal).Value = (object?)tour.BasePrice ?? DBNull.Value;
                command.Parameters.Add("p_Duration", OracleDbType.NVarchar2).Value = (object?)tour.Duration ?? DBNull.Value;
                command.Parameters.Add("p_Description", OracleDbType.Clob).Value = (object?)tour.Description ?? DBNull.Value;
                command.Parameters.Add("p_ManagerId", OracleDbType.Int32).Value = (object?)tour.ManagerId ?? DBNull.Value;
                
                // Output parameters
                var successParam = command.Parameters.Add("p_Success", OracleDbType.Int32);
                successParam.Direction = ParameterDirection.Output;
                
                var messageParam = command.Parameters.Add("p_Message", OracleDbType.Varchar2, 500);
                messageParam.Direction = ParameterDirection.Output;
                
                command.ExecuteNonQuery();
                
                int success = successParam.Value != DBNull.Value ? Convert.ToInt32(successParam.Value.ToString()) : 0;
                string message = messageParam.Value?.ToString() ?? "L?i không xác ??nh";
                
                return (success, message);
            });
        }

        // S? D?NG STORED PROCEDURE: SP_DeleteTour
        public async Task<(int Success, string Message)> DeleteTourAsync(int id)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SP_DeleteTour";
                command.CommandType = CommandType.StoredProcedure;
                
                // Input parameters
                command.Parameters.Add("p_TourId", OracleDbType.Int32).Value = id;
                
                // Output parameters
                var successParam = command.Parameters.Add("p_Success", OracleDbType.Int32);
                successParam.Direction = ParameterDirection.Output;
                
                var messageParam = command.Parameters.Add("p_Message", OracleDbType.Varchar2, 500);
                messageParam.Direction = ParameterDirection.Output;
                
                command.ExecuteNonQuery();
                
                int success = successParam.Value != DBNull.Value ? Convert.ToInt32(successParam.Value.ToString()) : 0;
                string message = messageParam.Value?.ToString() ?? "L?i không xác ??nh";
                
                return (success, message);
            });
        }

        // S? D?NG FUNCTION: FN_GetTourRevenue
        public async Task<decimal> GetTourRevenueAsync(int tourId)
        {
            return await Task.Run(() =>
            {
                using var connection = _dbService.GetConnection();
                connection.Open();
                
                using var command = connection.CreateCommand();
                command.CommandText = "SELECT FN_GetTourRevenue(:tourId) FROM DUAL";
                command.Parameters.Add("tourId", OracleDbType.Int32).Value = tourId;
                
                var result = command.ExecuteScalar();
                return result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            });
        }
    }
}
