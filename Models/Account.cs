namespace QLTourDuLich.Models
{
    public class Account
    {
        public int AccountId { get; set; }
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty; // 'Admin', 'Employee', 'Customer'
    }
}
