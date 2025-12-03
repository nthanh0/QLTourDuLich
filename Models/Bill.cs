namespace QLTourDuLich.Models
{
    public class Bill
    {
        public int BillId { get; set; }
        public int BookingId { get; set; }
        public decimal? TotalCost { get; set; }
        public string? PaymentMethod { get; set; }
        public DateTime? PaymentDate { get; set; }
        public string? Status { get; set; }
    }
}
