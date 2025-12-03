namespace QLTourDuLich.Models
{
    public class Employee
    {
        public int EmployeeId { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string? Email { get; set; }
        public string? PhoneNum { get; set; }
        public string? Department { get; set; }
        public string? Position { get; set; }
        public int? AccountId { get; set; }
    }
}
