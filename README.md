# Hệ Thống Quản Lý Tour Du Lịch

## Công Nghệ
- **Backend**: ASP.NET Core 8.0 (MVC/Razor Pages)
- **Database**: Oracle Database
- **ORM**: Oracle.ManagedDataAccess.Core

## Hướng Dẫn Tạo Cơ Sở Dữ Liệu

### Bước 1: Tạo Tablespace và User

Chạy file: `database/create_tablespace_and_users.sql`

**Nội dung chính:**
- Tạo tablespace `tour_management` (5MB, tự động mở rộng đến 50MB)
- Tạo user `tour_admin` (password: `pwd`) với đầy đủ quyền
- Tạo user nhân viên: `user_employee001`, `user_employee002`

### Bước 2: Tạo Bảng

Chạy file: `database/create_tables.sql`

**Tạo 15 bảng:**
- `Accounts`, `Customers`, `Employees`, `Tours`, `TourSchedules`
- `Bookings`, `Bills`, `Locations`, `Services`, `Transports`
- `Accommodations`, `Itineraries`
- `Itinerary_Locations`, `Itinerary_Services`, `Itinerary_Accommodations`

### Bước 3: Tạo Stored Procedures và Functions
Chạy file: `database/stored_procedures_functions.sql`

**Procedures:**
- `SP_CreateTour` - Tạo tour mới với validation
- `SP_UpdateTour` - Cập nhật tour
- `SP_DeleteTour` - Xóa tour (kiểm tra ràng buộc)
- `SP_CreateBooking` - Tạo booking (tính giá tự động, giảm giá theo số lượng)
- `SP_UpdateBookingStatus` - Cập nhật trạng thái booking
- `SP_CreateCustomer` - Tạo khách hàng với validation

**Functions:**
- `FN_GetTourRevenue` - Tính tổng doanh thu theo tour
- `FN_CountBookingsByStatus` - Đếm booking theo trạng thái
- `FN_GetAvailableSeats` - Kiểm tra chỗ trống
- `FN_GetCustomerTotalSpent` - Tổng chi tiêu khách hàng
- `FN_GetCustomerRank` - Xếp hạng khách hàng (VIP/Gold/Silver/Bronze)
- `FN_GetScheduleOccupancyRate` - % công suất đặt chỗ
- `FN_GetDaysUntilDeparture` - Số ngày đến ngày khởi hành

### Bước 4: Cấu Hình Connection String
THAY `orcl` THÀNH TÊN INSTANCE ĐANG DÙNG
Sửa file `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "OracleConnection": "User Id=tour_admin;Password=pwd;Data Source=localhost:1521/orcl"
  }
}
```

### Bước 6: Chạy Ứng Dụng

## Chức Năng Chính

### 1. Quản Lý Tour
- Tạo/Sửa/Xóa tour
- Xem doanh thu theo tour
- Quản lý người quản lý tour

### 2. Quản Lý Khách Hàng
- Thêm/Sửa/Xóa khách hàng
- Xem tổng chi tiêu và xếp hạng
- Validation email, số điện thoại, tuổi (≥18)

### 3. Quản Lý Đặt Tour
- **Thống kê theo trạng thái:**
  - Mới Đặt (Mới đặt + Chờ thanh toán)
  - Đã Xác Nhận (Đã xác nhận + Đã đặt cọc)
  - Hoàn Thành
- Tạo booking tự động tính giá (trẻ em -50%)
- Giảm giá theo số lượng: 3 người (5%), 5 người (10%), 10 người (15%)
- Kiểm tra chỗ trống
- Cập nhật trạng thái với validation

### 4. Quản Lý Nhân Viên
- Thêm/Sửa/Xóa nhân viên
- Phân theo phòng ban và chức vụ

## Lưu Ý Quan Trọng

### Encoding UTF-8
⚠️ **Tất cả các file .cs phải được lưu với encoding UTF-8** để xử lý đúng tiếng Việt.

Trong Visual Studio: `File` → `Advanced Save Options` → Chọn `Unicode (UTF-8 with signature) - Codepage 65001`

### Trạng Thái Booking
Các giá trị chuẩn:
- `Mới đặt`
- `Chờ thanh toán`
- `Đã đặt cọc`
- `Đã xác nhận`
- `Hoàn thành`
- `Đã hủy`

### Kiểm Tra Dữ Liệu
```sql
-- Kiểm tra số lượng bảng
SELECT COUNT(*) FROM user_tables;

-- Xem tất cả trạng thái booking
SELECT DISTINCT Status FROM Bookings ORDER BY Status;

-- Kiểm tra function
SELECT FN_CountBookingsByStatus('Hoàn thành') FROM DUAL;
```

## Cấu Trúc Thư Mục
```
QLTourDuLich/
├── Controllers/          # MVC Controllers
├── Models/              # Entity Models
├── Services/            # Business Logic Layer
├── Views/               # Razor Views
├── database/            # SQL Scripts
│   ├── create_tablespace_and_users.sql
│   ├── create_tables.sql
│   ├── fix_sequences.sql
│   └── stored_procedures_functions.sql
├── appsettings.json
├── Program.cs
└── README.md
```

## Liên Hệ & Hỗ Trợ
Nếu gặp vấn đề, kiểm tra:
1. Oracle service đã chạy chưa
2. Connection string đúng chưa
3. User có đủ quyền chưa
4. File encoding UTF-8 chưa




