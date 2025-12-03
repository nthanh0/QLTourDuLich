namespace QLTourDuLich.Models
{
    public class Customer
    {
        public int CustomerId { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string? Email { get; set; }
        public string? Address { get; set; }
        public string? Telephone { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string? IdentityNum { get; set; }
        public int? AccountId { get; set; }
    }
}
