# H? Th?ng Qu?n Lý Tour Du L?ch

## Công Ngh?
- **Backend**: ASP.NET Core 8.0 (MVC/Razor Pages)
- **Database**: Oracle Database
- **ORM**: Oracle.ManagedDataAccess.Core

## H??ng D?n T?o C? S? D? Li?u

### B??c 1: T?o Tablespace và User
```sql
-- K?t n?i b?ng user SYSTEM ho?c SYS
sqlplus system/password@localhost:1521/xe
```

Ch?y file: `database/create_tablespace_and_users.sql`

**N?i dung chính:**
- T?o tablespace `tour_management` (5MB, t? ??ng m? r?ng ??n 50MB)
- T?o user `tour_admin` (password: `pwd`) v?i ??y ?? quy?n
- T?o user nhân viên: `user_employee001`, `user_employee002`

### B??c 2: T?o B?ng
```sql
-- K?t n?i b?ng tour_admin
sqlplus tour_admin/pwd@localhost:1521/xe
```

Ch?y file: `database/create_tables.sql`

**T?o 15 b?ng:**
- `Accounts`, `Customers`, `Employees`, `Tours`, `TourSchedules`
- `Bookings`, `Bills`, `Locations`, `Services`, `Transports`
- `Accommodations`, `Itineraries`
- `Itinerary_Locations`, `Itinerary_Services`, `Itinerary_Accommodations`

### B??c 3: S?a Sequences (n?u c?n)
Ch?y file: `database/fix_sequences.sql`

??ng b? giá tr? sequence v?i MAX(ID) trong các b?ng.

### B??c 4: T?o Stored Procedures và Functions
Ch?y file: `database/stored_procedures_functions.sql`

**Procedures:**
- `SP_CreateTour` - T?o tour m?i v?i validation
- `SP_UpdateTour` - C?p nh?t tour
- `SP_DeleteTour` - Xóa tour (ki?m tra ràng bu?c)
- `SP_CreateBooking` - T?o booking (tính giá t? ??ng, gi?m giá theo s? l??ng)
- `SP_UpdateBookingStatus` - C?p nh?t tr?ng thái booking
- `SP_CreateCustomer` - T?o khách hàng v?i validation

**Functions:**
- `FN_GetTourRevenue` - Tính t?ng doanh thu theo tour
- `FN_CountBookingsByStatus` - ??m booking theo tr?ng thái
- `FN_GetAvailableSeats` - Ki?m tra ch? tr?ng
- `FN_GetCustomerTotalSpent` - T?ng chi tiêu khách hàng
- `FN_GetCustomerRank` - X?p h?ng khách hàng (VIP/Gold/Silver/Bronze)
- `FN_GetScheduleOccupancyRate` - % công su?t ??t ch?
- `FN_GetDaysUntilDeparture` - S? ngày ??n ngày kh?i hành

### B??c 5: C?u Hình Connection String
S?a file `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "OracleConnection": "User Id=tour_admin;Password=pwd;Data Source=localhost:1521/xe"
  }
}
```

### B??c 6: Ch?y ?ng D?ng
```bash
dotnet restore
dotnet build
dotnet run
```

Truy c?p: `https://localhost:7205` ho?c `http://localhost:5000`

## Ch?c N?ng Chính

### 1. Qu?n Lý Tour
- T?o/S?a/Xóa tour
- Xem doanh thu theo tour
- Qu?n lý ng??i qu?n lý tour

### 2. Qu?n Lý Khách Hàng
- Thêm/S?a/Xóa khách hàng
- Xem t?ng chi tiêu và x?p h?ng
- Validation email, s? ?i?n tho?i, tu?i (?18)

### 3. Qu?n Lý ??t Tour
- **Th?ng kê theo tr?ng thái:**
  - M?i ??t (M?i ??t + Ch? thanh toán)
  - ?ã Xác Nh?n (?ã xác nh?n + ?ã ??t c?c)
  - Hoàn Thành
- T?o booking t? ??ng tính giá (tr? em -50%)
- Gi?m giá theo s? l??ng: 3 ng??i (5%), 5 ng??i (10%), 10 ng??i (15%)
- Ki?m tra ch? tr?ng
- C?p nh?t tr?ng thái v?i validation

### 4. Qu?n Lý Nhân Viên
- Thêm/S?a/Xóa nhân viên
- Phân theo phòng ban và ch?c v?

## L?u Ý Quan Tr?ng

### Encoding UTF-8
?? **T?t c? các file .cs ph?i ???c l?u v?i encoding UTF-8** ?? x? lý ?úng ti?ng Vi?t.

Trong Visual Studio: `File` ? `Advanced Save Options` ? Ch?n `Unicode (UTF-8 with signature) - Codepage 65001`

### Tr?ng Thái Booking
Các giá tr? chu?n:
- `M?i ??t`
- `Ch? thanh toán`
- `?ã ??t c?c`
- `?ã xác nh?n`
- `Hoàn thành`
- `?ã h?y`

### Ki?m Tra D? Li?u
```sql
-- Ki?m tra s? l??ng b?ng
SELECT COUNT(*) FROM user_tables;

-- Xem t?t c? tr?ng thái booking
SELECT DISTINCT Status FROM Bookings ORDER BY Status;

-- Ki?m tra function
SELECT FN_CountBookingsByStatus('Hoàn thành') FROM DUAL;
```

## C?u Trúc Th? M?c
```
QLTourDuLich/
??? Controllers/          # MVC Controllers
??? Models/              # Entity Models
??? Services/            # Business Logic Layer
??? Views/               # Razor Views
??? database/            # SQL Scripts
?   ??? create_tablespace_and_users.sql
?   ??? create_tables.sql
?   ??? fix_sequences.sql
?   ??? stored_procedures_functions.sql
??? appsettings.json
??? Program.cs
??? README.md
```

## Liên H? & H? Tr?
N?u g?p v?n ??, ki?m tra:
1. Oracle service ?ã ch?y ch?a
2. Connection string ?úng ch?a
3. User có ?? quy?n ch?a
4. File encoding UTF-8 ch?a
