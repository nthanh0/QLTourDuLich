-- 1. BẢNG ACCOUNTS (10 NV + 10 Khách = 20 Accounts)

-- Tài khoản Nhân viên (Auto-generated IDs 1-10)
INSERT INTO Accounts (Username, Password, Role) VALUES ('admin', '123456', 'Admin');
INSERT INTO Accounts (Username, Password, Role) VALUES ('manager_hanoi', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('sale_lan', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('sale_hung', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('sale_mai', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('acc_tuan', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('support_linh', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('guide_nam', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('guide_minh', '123456', 'Employee');
INSERT INTO Accounts (Username, Password, Role) VALUES ('guide_hoa', '123456', 'Employee');

-- Tài khoản Khách hàng (Auto-generated IDs 11-20)
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_tuananh', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_huong', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_dung', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_thao', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_long', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_trang', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_huy', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_ngoc', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_phuc', '123456', 'Customer');
INSERT INTO Accounts (Username, Password, Role) VALUES ('khach_yen', '123456', 'Customer');

-- 2. BẢNG EMPLOYEES (10 Nhân viên khớp với Account 1-10)
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Nguyễn Văn An', 'admin@tour.com', '0901111111', N'Ban Giám Đốc', N'Giám đốc', 1);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Trần Thị Bích', 'bich.manager@tour.com', '0902222222', N'Điều hành', N'Trưởng phòng', 2);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Lê Thị Ngọc Lan', 'lan.sale@tour.com', '0903333333', N'Kinh doanh', N'Nhân viên Sale', 3);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Phạm Quốc Hưng', 'hung.sale@tour.com', '0904444444', N'Kinh doanh', N'Nhân viên Sale', 4);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Hoàng Thanh Mai', 'mai.sale@tour.com', '0905555555', N'Marketing', N'Chuyên viên Content', 5);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Vũ Văn Tuấn', 'tuan.acc@tour.com', '0906666666', N'Kế toán', N'Kế toán trưởng', 6);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Đặng Thùy Linh', 'linh.sup@tour.com', '0907777777', N'CSKH', N'Tổng đài viên', 7);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Ngô Hải Nam', 'nam.guide@tour.com', '0908888888', N'Hướng dẫn', N'HDV Nội địa', 8);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Trịnh Văn Minh', 'minh.guide@tour.com', '0909999999', N'Hướng dẫn', N'HDV Quốc tế', 9);
INSERT INTO Employees (FullName, Email, PhoneNum, Department, Position, AccountId) 
VALUES (N'Lý Thị Hoa', 'hoa.guide@tour.com', '0910101010', N'Hướng dẫn', N'HDV Tiếng Trung', 10);

-- 3. BẢNG CUSTOMERS (10 Khách hàng khớp với Account 11-20)
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Phạm Tuấn Anh', 'tuananh90@gmail.com', N'Số 12, Ngõ 5, Nguyễn Trãi, Hà Nội', '0981123456', TO_DATE('1990-01-01', 'YYYY-MM-DD'), '001090001234', 11);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Nguyễn Thu Hương', 'huong.nguyen@gmail.com', N'45 Lê Lợi, Quận 1, TP.HCM', '0982123456', TO_DATE('1995-05-15', 'YYYY-MM-DD'), '001095005678', 12);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Trần Văn Dũng', 'dung.tran@hotmail.com', N'88 Trần Phú, Đà Nẵng', '0983123456', TO_DATE('1985-08-20', 'YYYY-MM-DD'), '001085009101', 13);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Lê Phương Thảo', 'thao.le@yahoo.com', N'102 Ngô Quyền, Hải Phòng', '0984123456', TO_DATE('1998-12-10', 'YYYY-MM-DD'), '079098001122', 14);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Hoàng Văn Long', 'long.hoang@gmail.com', N'Khu đô thị Ecopark, Hưng Yên', '0985123456', TO_DATE('1992-03-25', 'YYYY-MM-DD'), '001092003344', 15);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Vũ Thu Trang', 'trang.vu@gmail.com', N'Số 5 Hùng Vương, Cần Thơ', '0986123456', TO_DATE('2000-07-07', 'YYYY-MM-DD'), '001200005566', 16);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Đỗ Quang Huy', 'huy.do@gmail.com', N'Xóm 3, Nghi Lộc, Nghệ An', '0987123456', TO_DATE('1988-09-09', 'YYYY-MM-DD'), '001088007788', 17);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Bùi Bích Ngọc', 'ngoc.bui@gmail.com', N'Chung cư Vinhome, Bình Thạnh, TP.HCM', '0988123456', TO_DATE('1993-11-11', 'YYYY-MM-DD'), '001093009900', 18);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Dương Tấn Phúc', 'phuc.duong@gmail.com', N'TP. Buôn Ma Thuột, Đắk Lắk', '0989123456', TO_DATE('1996-02-28', 'YYYY-MM-DD'), '001096001133', 19);
INSERT INTO Customers (FullName, Email, Address, Telephone, DateOfBirth, IdentityNum, AccountId) 
VALUES (N'Phan Hải Yến', 'yen.phan@gmail.com', N'Phường 2, TP. Vũng Tàu', '0990123456', TO_DATE('1999-06-01', 'YYYY-MM-DD'), '001099002244', 20);

-- 4. BẢNG LOCATIONS (10 Địa điểm)
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Vịnh Hạ Long', N'Quảng Ninh', N'Di sản thiên nhiên thế giới', N'Biển đảo');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Quần thể Tràng An', N'Ninh Bình', N'Khu du lịch sinh thái', N'Di sản hỗn hợp');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Phố cổ Hội An', N'Quảng Nam', N'Thương cảng cổ sầm uất', N'Di tích lịch sử');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Bà Nà Hills', N'Đà Nẵng', N'Đường lên tiên cảnh', N'Khu vui chơi');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Đại Nội Huế', N'Thừa Thiên Huế', N'Hoàng thành nhà Nguyễn', N'Di tích lịch sử');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Thung lũng Tình Yêu', N'Đà Lạt', N'Địa điểm lãng mạn', N'Núi rừng');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Bãi Sao', N'Phú Quốc', N'Bãi biển cát trắng đẹp nhất', N'Biển đảo');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Chợ nổi Cái Răng', N'Cần Thơ', N'Văn hóa sông nước miền Tây', N'Văn hóa');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Động Phong Nha', N'Quảng Bình', N'Vương quốc hang động', N'Hang động');
INSERT INTO Locations (LocationName, Address, Description, LocationType) VALUES (N'Đỉnh Fansipan', N'Lào Cai', N'Nóc nhà Đông Dương', N'Núi');

-- 5. BẢNG SERVICES (10 Dịch vụ)
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Visa', N'Làm Visa nhập cảnh', 500000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Bảo hiểm', N'Bảo hiểm du lịch Cơ bản', 150000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Bảo hiểm', N'Bảo hiểm du lịch Cao cấp', 500000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Ăn uống', N'Buffet Hải sản tối', 450000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Ăn uống', N'Tiệc Gala Dinner', 800000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Vận chuyển', N'Thuê xe máy 1 ngày', 150000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Vận chuyển', N'Đưa đón sân bay 2 chiều', 600000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Giải trí', N'Vé cáp treo khứ hồi', 850000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Giải trí', N'Vé tham quan Safari', 650000);
INSERT INTO Services (ServiceType, ServiceName, Price) VALUES (N'Hướng dẫn', N'Thuê HDV riêng 1 ngày', 1000000);

-- 6. BẢNG TRANSPORTS (10 Phương tiện)
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('29B-111.11', N'Xe 45 chỗ', N'Hà Sơn Hải Vân', N'Nguyễn Văn Tài', '0911111111');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('VN-333', N'Máy bay', N'Vietnam Airlines', N'Phi công A', 'N/A');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('VJ-555', N'Máy bay', N'Vietjet Air', N'Phi công B', 'N/A');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('QN-1234', N'Tàu thủy', N'Tuần Châu Express', N'Thuyền trưởng Hùng', '0922222222');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('51F-999.99', N'Xe Limousine', N'Hoa Mai', N'Trần Văn Bảy', '0933333333');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('43A-567.89', N'Xe 16 chỗ', N'Du lịch Đà Nẵng', N'Lê Văn Tám', '0944444444');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('SE-01', N'Tàu hỏa', N'Đường sắt Việt Nam', N'Lái tàu Nam', 'N/A');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('QH-111', N'Máy bay', N'Bamboo Airways', N'Phi công C', 'N/A');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('65C-123.45', N'Thuyền máy', N'Du lịch Cần Thơ', N'Chú Ba', '0955555555');
INSERT INTO Transports (LicensePlate, VehicleType, ProviderName, DriverName, DriverPhoneNum) VALUES ('29A-678.90', N'Xe 7 chỗ', N'Grab Car', N'Tài xế Dũng', '0966666666');

-- 7. BẢNG ACCOMMODATIONS (10 Khách sạn)
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Khách sạn 5 sao', N'Melia Hanoi', N'Hà Nội', '0241111111');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Du thuyền', N'Ambassador Cruise', N'Hạ Long', '0203222222');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Resort', N'Vinpearl Nam Hội An', N'Quảng Nam', '0235333333');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Khách sạn 4 sao', N'Novotel Danang', N'Đà Nẵng', '0236444444');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Homestay', N'Sapa Jade Hill', N'Sapa', '0214555555');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Khách sạn 3 sao', N'Hương Giang Hotel', N'Huế', '0234666666');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Resort', N'JW Marriott', N'Phú Quốc', '0297777777');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Villa', N'Dalat Edensee', N'Đà Lạt', '0263888888');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Khách sạn 2 sao', N'Nhà nghỉ Công Đoàn', N'Cửa Lò', '0238999999');
INSERT INTO Accommodations (Type, Name, Address, ContactPhone) VALUES (N'Homestay', N'Mekong Rustic', N'Cần Thơ', '0292000000');

-- 8. BẢNG TOURS (10 Tour)
-- ManagerId = 2 (Trần Thị Bích - Trưởng phòng Điều hành)
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Hà Nội - Hạ Long - Ninh Bình', N'Miền Bắc', 5500000, N'4 ngày 3 đêm', N'Khám phá di sản miền Bắc', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Sapa - Chinh phục Fansipan', N'Miền Bắc', 4200000, N'3 ngày 2 đêm', N'Săn mây trên đỉnh núi', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Đà Nẵng - Hội An - Bà Nà', N'Miền Trung', 4800000, N'4 ngày 3 đêm', N'Con đường di sản miền Trung', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Huế - Động Phong Nha', N'Miền Trung', 3500000, N'3 ngày 2 đêm', N'Thăm cố đô và hang động', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Nha Trang Biển Gọi', N'Biển đảo', 5000000, N'4 ngày 3 đêm', N'Vui chơi Vinwonders', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Đà Lạt Mộng Mơ', N'Nghỉ dưỡng', 3800000, N'3 ngày 2 đêm', N'Thành phố ngàn hoa', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Quy Nhơn - Kỳ Co - Eo Gió', N'Biển đảo', 4500000, N'3 ngày 2 đêm', N'Maldives Việt Nam', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Phú Quốc Đảo Ngọc', N'Nghỉ dưỡng', 6500000, N'4 ngày 3 đêm', N'Nghỉ dưỡng 5 sao', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Cần Thơ - Sóc Trăng - Bạc Liêu', N'Miền Nam', 3200000, N'2 ngày 1 đêm', N'Miền Tây sông nước', 2);
INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId) 
VALUES (N'Xuyên Việt Đặc Biệt', N'Toàn quốc', 15000000, N'10 ngày 9 đêm', N'Hành trình Bắc Nam', 2);

-- 9. BẢNG TOUR_SCHEDULES (10+ Lịch trình)
-- TourId references will be auto-generated (1-10)
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (1, SYSDATE+5, SYSDATE+9, 20, 0, N'Đang mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (1, SYSDATE+20, SYSDATE+24, 20, 0, N'Sắp mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (2, SYSDATE+10, SYSDATE+13, 15, 0, N'Đang mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (3, SYSDATE-5, SYSDATE-2, 25, 25, N'Hoàn thành');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (3, SYSDATE+15, SYSDATE+18, 25, 5, N'Đang mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (4, SYSDATE+7, SYSDATE+10, 30, 0, N'Đang mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (5, SYSDATE+30, SYSDATE+34, 40, 0, N'Sắp mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (6, SYSDATE+2, SYSDATE+5, 20, 18, N'Sắp đóng');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (8, SYSDATE+40, SYSDATE+44, 20, 0, N'Sắp mở');
INSERT INTO TourSchedules (TourId, StartDate, EndDate, MaxCapacity, CurrentBook, Status) VALUES (10, SYSDATE+60, SYSDATE+70, 15, 0, N'Sắp mở');

-- 10. BẢNG BOOKINGS (10+ Booking)
-- CustomerId (1-10) and ScheduleId (1-10) reference auto-generated IDs
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (1, 1, SYSDATE-2, 2, 0, 11000000, N'Đã xác nhận');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (2, 1, SYSDATE-1, 1, 0, 5500000, N'Chờ thanh toán');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (3, 3, SYSDATE-5, 2, 1, 10500000, N'Đã xác nhận');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (4, 4, SYSDATE-10, 4, 0, 19200000, N'Hoàn thành');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (5, 5, SYSDATE-3, 2, 2, 12000000, N'Đã đặt cọc');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (6, 8, SYSDATE-1, 2, 0, 7600000, N'Đã xác nhận');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (7, 2, SYSDATE, 1, 0, 5500000, N'Mới đặt');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (8, 4, SYSDATE-15, 2, 0, 9600000, N'Đã hủy');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (9, 6, SYSDATE-2, 3, 0, 10500000, N'Đã xác nhận');
INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status) VALUES (10, 1, SYSDATE-1, 2, 0, 11000000, N'Chờ thanh toán');

-- 11. BẢNG BILLS (10+ Hóa đơn tương ứng Booking)
-- BookingId (1-10) references auto-generated IDs
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (1, 11000000, N'Chuyển khoản', SYSDATE-2, N'Đã thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (2, 5500000, N'Tiền mặt', NULL, N'Chờ thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (3, 10500000, N'Thẻ tín dụng', SYSDATE-5, N'Đã thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (4, 19200000, N'Chuyển khoản', SYSDATE-10, N'Đã thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (5, 6000000, N'Ví điện tử', SYSDATE-3, N'Thanh toán đợt 1');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (6, 7600000, N'Chuyển khoản', SYSDATE-1, N'Đã thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (7, 5500000, N'Tiền mặt', NULL, N'Chờ thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (8, 9600000, N'Thẻ tín dụng', SYSDATE-14, N'Đã hoàn tiền');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (9, 10500000, N'Chuyển khoản', SYSDATE-2, N'Đã thanh toán');
INSERT INTO Bills (BookingId, TotalCost, PaymentMethod, PaymentDate, Status) VALUES (10, 11000000, N'Tiền mặt', NULL, N'Chờ thanh toán');

-- 12. BẢNG ITINERARIES & JUNCTION TABLES (Chi tiết lịch trình)
-- Tour 1: Ngày 1 (Đón - HN), Ngày 2 (Hạ Long), Ngày 3 (Ninh Bình)
-- TourId and TransportId reference auto-generated IDs
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (1, 1, N'Đón sân bay Nội Bài, City Tour Hà Nội', 10);
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (1, 2, N'Di chuyển đi Hạ Long, Ngủ đêm trên du thuyền', 1);
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (1, 3, N'Tham quan Tràng An Ninh Bình', 1);

-- Tour 3: Ngày 1 (Đà Nẵng), Ngày 2 (Bà Nà), Ngày 3 (Hội An)
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (3, 1, N'Đón sân bay ĐN, tắm biển Mỹ Khê', 6);
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (3, 2, N'Đi cáp treo Bà Nà Hills', 6);
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (3, 3, N'Tham quan Phố cổ Hội An', 6);

-- Tour 8: Ngày 1 (Phú Quốc)
INSERT INTO Itineraries (TourId, DayNum, Description, TransportId) VALUES (8, 1, N'Đón sân bay Phú Quốc, Checkin Sunset Sanato', 5);

-- Gắn Địa điểm (Itinerary_Locations)
-- ItineraryId references will be auto-generated (1-7)
-- LocationId references will be auto-generated (1-10)
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (1, 1);
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (2, 1);
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (3, 2);
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (4, 4);
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (5, 4);
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (6, 3);
INSERT INTO Itinerary_Locations (ItineraryId, LocationId) VALUES (7, 7);

-- Gắn Khách sạn (Itinerary_Accommodations)
-- ItineraryId and AccommodationId reference auto-generated IDs
INSERT INTO Itinerary_Accommodations (ItineraryId, AccommodationId) VALUES (1, 1);
INSERT INTO Itinerary_Accommodations (ItineraryId, AccommodationId) VALUES (2, 2);
INSERT INTO Itinerary_Accommodations (ItineraryId, AccommodationId) VALUES (4, 4);
INSERT INTO Itinerary_Accommodations (ItineraryId, AccommodationId) VALUES (6, 3);

-- Gắn Dịch vụ (Itinerary_Services)
-- ItineraryId and ServiceId reference auto-generated IDs
INSERT INTO Itinerary_Services (ItineraryId, ServiceId) VALUES (1, 7);
INSERT INTO Itinerary_Services (ItineraryId, ServiceId) VALUES (5, 8);
INSERT INTO Itinerary_Services (ItineraryId, ServiceId) VALUES (6, 4);

COMMIT;