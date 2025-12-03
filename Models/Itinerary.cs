namespace QLTourDuLich.Models
{
    public class Itinerary
    {
        public int ItineraryId { get; set; }
        public int TourId { get; set; }
        public int? DayNum { get; set; }
        public string? Description { get; set; }
        public int? TransportId { get; set; }
    }
}
