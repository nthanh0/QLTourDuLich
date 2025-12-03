namespace QLTourDuLich.Models
{
    public class Tour
    {
        public int TourId { get; set; }
        public string TourName { get; set; } = string.Empty;
        public string? TourType { get; set; }
        public decimal? BasePrice { get; set; }
        public string? Duration { get; set; }
        public string? Description { get; set; }
        public int? ManagerId { get; set; }
    }
}
