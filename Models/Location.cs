namespace QLTourDuLich.Models
{
    public class Location
    {
        public int LocationId { get; set; }
        public string LocationName { get; set; } = string.Empty;
        public string? Address { get; set; }
        public string? Description { get; set; }
        public string? LocationType { get; set; }
    }
}
