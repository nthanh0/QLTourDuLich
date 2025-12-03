using Oracle.ManagedDataAccess.Client;
using QLTourDuLich.Models;

namespace QLTourDuLich.Services
{
    public class TourScheduleService
    {
        private readonly OracleDbService _dbService;

        public TourScheduleService(OracleDbService dbService)
        {
            _dbService = dbService;
        }

        public async Task<List<TourSchedule>> GetAllSchedulesAsync()
        {
            var query = "SELECT ScheduleId, TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status FROM TourSchedules ORDER BY StartDate DESC";
            return await _dbService.ExecuteQueryAsync(query, reader => new TourSchedule
            {
                ScheduleId = reader.GetInt32(0),
                TourId = reader.GetInt32(1),
                StartDate = reader.GetDateTime(2),
                EndDate = reader.GetDateTime(3),
                MaxCapacity = reader.IsDBNull(4) ? null : reader.GetInt32(4),
                CurrentBook = reader.IsDBNull(5) ? null : reader.GetInt32(5),
                Status = reader.IsDBNull(6) ? null : reader.GetString(6)
            });
        }

        public async Task<TourSchedule?> GetScheduleByIdAsync(int id)
        {
            var query = "SELECT ScheduleId, TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status FROM TourSchedules WHERE ScheduleId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            var result = await _dbService.ExecuteQueryAsync(query, reader => new TourSchedule
            {
                ScheduleId = reader.GetInt32(0),
                TourId = reader.GetInt32(1),
                StartDate = reader.GetDateTime(2),
                EndDate = reader.GetDateTime(3),
                MaxCapacity = reader.IsDBNull(4) ? null : reader.GetInt32(4),
                CurrentBook = reader.IsDBNull(5) ? null : reader.GetInt32(5),
                Status = reader.IsDBNull(6) ? null : reader.GetString(6)
            }, parameters);
            return result.FirstOrDefault();
        }

        public async Task<List<TourSchedule>> GetSchedulesByTourIdAsync(int tourId)
        {
            var query = "SELECT ScheduleId, TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status FROM TourSchedules WHERE TourId = :tourId ORDER BY StartDate";
            var parameters = new[] { new OracleParameter("tourId", tourId) };
            return await _dbService.ExecuteQueryAsync(query, reader => new TourSchedule
            {
                ScheduleId = reader.GetInt32(0),
                TourId = reader.GetInt32(1),
                StartDate = reader.GetDateTime(2),
                EndDate = reader.GetDateTime(3),
                MaxCapacity = reader.IsDBNull(4) ? null : reader.GetInt32(4),
                CurrentBook = reader.IsDBNull(5) ? null : reader.GetInt32(5),
                Status = reader.IsDBNull(6) ? null : reader.GetString(6)
            }, parameters);
        }

        public async Task<int> CreateScheduleAsync(TourSchedule schedule)
        {
            var query = @"INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) 
                         VALUES (:tourId, :startDate, :endDate, :maxCap, :currBook, :status)";
            var parameters = new[]
            {
                new OracleParameter("tourId", schedule.TourId),
                new OracleParameter("startDate", schedule.StartDate),
                new OracleParameter("endDate", schedule.EndDate),
                new OracleParameter("maxCap", (object?)schedule.MaxCapacity ?? DBNull.Value),
                new OracleParameter("currBook", (object?)schedule.CurrentBook ?? DBNull.Value),
                new OracleParameter("status", (object?)schedule.Status ?? DBNull.Value)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> UpdateScheduleAsync(TourSchedule schedule)
        {
            var query = @"UPDATE TourSchedules SET TourId = :tourId, StartDate = :startDate, EndDate = :endDate, 
                         MaxCapacity = :maxCap, CurrentBook = :currBook, Status = :status 
                         WHERE ScheduleId = :id";
            var parameters = new[]
            {
                new OracleParameter("tourId", schedule.TourId),
                new OracleParameter("startDate", schedule.StartDate),
                new OracleParameter("endDate", schedule.EndDate),
                new OracleParameter("maxCap", (object?)schedule.MaxCapacity ?? DBNull.Value),
                new OracleParameter("currBook", (object?)schedule.CurrentBook ?? DBNull.Value),
                new OracleParameter("status", (object?)schedule.Status ?? DBNull.Value),
                new OracleParameter("id", schedule.ScheduleId)
            };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }

        public async Task<int> DeleteScheduleAsync(int id)
        {
            var query = "DELETE FROM TourSchedules WHERE ScheduleId = :id";
            var parameters = new[] { new OracleParameter("id", id) };
            return await _dbService.ExecuteNonQueryAsync(query, parameters);
        }
    }
}
