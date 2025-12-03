namespace QLTourDuLich.Models
{
    public class Booking
    {
        public int BookingId { get; set; }
        public int CustomerId { get; set; }
        public int ScheduleId { get; set; }
        public DateTime BookingDate { get; set; }
        public int? NumAdults { get; set; }
        public int? NumChildren { get; set; }
        public decimal? TotalAmount { get; set; }
        public string? Status { get; set; }
    }
}
