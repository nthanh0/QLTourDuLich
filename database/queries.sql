--=====================================================
-- TRUY VẤN CƠ BẢN
--=====================================================
-- 1. Liệt kê danh sách các Tour có giá cơ bản (BasePrice) trên 4.000.000 VNĐ
SELECT TourId, TourName, BasePrice, TourType
FROM Tours
WHERE BasePrice > 4000000
ORDER BY BasePrice DESC;

-- 2. Tìm kiếm khách hàng có địa chỉ tại "Hà Nội" hoặc "TP.HCM"
SELECT CustomerId, FullName, Address, Email, Telephone
FROM Customers
WHERE Address LIKE '%Hà Nội%' OR Address LIKE '%TP.HCM%';

-- 4. Liệt kê các hóa đơn (Bills) chưa thanh toán
SELECT BillId, BookingId, TotalCost, Status
FROM Bills
WHERE Status = N'Chờ thanh toán';

--=====================================================
-- TRUY VẤN CÓ JOIN BẢNG
--=====================================================
-- 5. Hiển thị chi tiết đơn đặt tour (Tên khách, Tên tour, Ngày đi, Tổng tiền)
SELECT 
    b.BookingId,
    c.FullName AS CustomerName,
    t.TourName,
    ts.StartDate,
    b.TotalAmount,
    b.Status
FROM Bookings b
JOIN Customers c ON b.CustomerId = c.CustomerId
JOIN TourSchedules ts ON b.ScheduleId = ts.ScheduleId
JOIN Tours t ON ts.TourId = t.TourId;

-- 6. Liệt kê danh sách địa điểm (Locations) của Tour có ID là 1
SELECT 
    t.TourName,
    i.DayNum,
    l.LocationName,
    l.LocationType
FROM Tours t
JOIN Itineraries i ON t.TourId = i.TourId
JOIN Itinerary_Locations il ON i.ItineraryId = il.ItineraryId
JOIN Locations l ON il.LocationId = l.LocationId
WHERE t.TourId = 1
ORDER BY i.DayNum;

-- 7. Xem thông tin nhân viên quản lý (Manager) của từng Tour
SELECT 
    t.TourName,
    e.FullName AS ManagerName,
    e.Email,
    e.PhoneNum
FROM Tours t
JOIN Employees e ON t.ManagerId = e.EmployeeId;

--=====================================================
-- HÀM THỐNG KÊ VÀ NHÓM TRUY VẤN
--=====================================================
-- 8. Thống kê tổng doanh thu dự kiến theo từng Tour
SELECT 
    t.TourName,
    SUM(b.TotalAmount) AS TotalRevenue,
    COUNT(b.BookingId) AS TotalBookings
FROM Bookings b
JOIN TourSchedules ts ON b.ScheduleId = ts.ScheduleId
JOIN Tours t ON ts.TourId = t.TourId
WHERE b.Status != N'Đã hủy' -- Không tính đơn đã hủy
GROUP BY t.TourName
ORDER BY TotalRevenue DESC;

-- 9. Đếm số lượng khách hàng theo từng tỉnh/thành phố (dựa trên địa chỉ)
SELECT 
    SUBSTR(Address, INSTR(Address, ',') + 2) AS City, -- Lấy phần sau dấu phẩy (giả định format đơn giản)
    COUNT(CustomerId) AS NumberOfCustomers
FROM Customers
GROUP BY SUBSTR(Address, INSTR(Address, ',') + 2);

-- 10. Tính độ tuổi trung bình của khách hàng
SELECT 
    AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DateOfBirth)) AS AverageAge,
    MIN(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DateOfBirth)) AS MinAge,
    MAX(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DateOfBirth)) AS MaxAge
FROM Customers;

-- 11. Thống kê số lượng Tour theo loại hình (TourType)
SELECT TourType, COUNT(TourId) AS Quantity, AVG(BasePrice) AS AvgPrice
FROM Tours
GROUP BY TourType;

--=====================================================
-- TRUY VẤN LỒNG
--=====================================================
-- 12. Tìm các Tour chưa từng có ai đặt
SELECT TourId, TourName, BasePrice
FROM Tours
WHERE TourId NOT IN (
    SELECT DISTINCT ts.TourId
    FROM TourSchedules ts
    JOIN Bookings b ON ts.ScheduleId = b.ScheduleId
);

-- 13. Tìm khách hàng đã chi tiêu nhiều nhất
SELECT c.CustomerId, c.FullName, SUM(b.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Bookings b ON c.CustomerId = b.CustomerId
GROUP BY c.CustomerId, c.FullName
HAVING SUM(b.TotalAmount) = (
    SELECT MAX(SumTotal)
    FROM (
        SELECT SUM(TotalAmount) as SumTotal
        FROM Bookings
        WHERE Status != N'Đã hủy'
        GROUP BY CustomerId
    )
);

-- 14. Liệt kê các Tour có giá cao hơn mức giá trung bình của tất cả các Tour
SELECT TourName, BasePrice
FROM Tours
WHERE BasePrice > (SELECT AVG(BasePrice) FROM Tours);

-- 15. Danh sách các khách sạn được sử dụng nhiều nhất trong các lịch trình
SELECT 
    a.Name AS HotelName,
    COUNT(ia.ItineraryId) AS UsageCount
FROM Accommodations a
JOIN Itinerary_Accommodations ia ON a.AccommodationId = ia.AccommodationId
GROUP BY a.Name
ORDER BY UsageCount DESC
FETCH FIRST 3 ROWS ONLY;