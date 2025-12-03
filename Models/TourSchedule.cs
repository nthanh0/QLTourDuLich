namespace QLTourDuLich.Models
{
    public class TourSchedule
    {
        public int ScheduleId { get; set; }
        public int TourId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int? MaxCapacity { get; set; }
        public int? CurrentBook { get; set; }
        public string? Status { get; set; }
    }
}
