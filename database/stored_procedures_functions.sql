-- =============================================
-- PHẦN 1: STORED PROCEDURES
-- =============================================

-- 1. Procedure: Tạo Tour mới với validation
CREATE OR REPLACE PROCEDURE SP_CreateTour(
    p_TourName IN NVARCHAR2,
    p_TourType IN NVARCHAR2,
    p_BasePrice IN NUMBER,
    p_Duration IN NVARCHAR2,
    p_Description IN CLOB,
    p_ManagerId IN NUMBER,
    p_TourId OUT NUMBER,
    p_Message OUT VARCHAR2
)
AS
    v_count NUMBER;
    v_manager_exists NUMBER;
BEGIN
    -- IF-THEN-ELSE: Kiểm tra tên tour đã tồn tại chưa
    SELECT COUNT(*) INTO v_count 
    FROM Tours 
    WHERE UPPER(TourName) = UPPER(p_TourName);
    
    IF v_count > 0 THEN
        p_Message := 'Tên tour đã tồn tại!';
        p_TourId := -1;
        RETURN;
    END IF;
    
    -- Kiểm tra ManagerId có tồn tại không
    IF p_ManagerId IS NOT NULL THEN
        SELECT COUNT(*) INTO v_manager_exists
        FROM Employees
        WHERE EmployeeId = p_ManagerId;
        
        IF v_manager_exists = 0 THEN
            p_Message := 'Mã quản lý không tồn tại!';
            p_TourId := -1;
            RETURN;
        END IF;
    END IF;
    
    -- CASE: Validate giá tour theo loại
    CASE 
        WHEN p_TourType = N'Miền Bắc' AND p_BasePrice < 1000000 THEN
            p_Message := 'Giá tour Miền Bắc phải >= 1.000.000 VNĐ';
            p_TourId := -1;
            RETURN;
        WHEN p_TourType = N'Miền Trung' AND p_BasePrice < 1500000 THEN
            p_Message := 'Giá tour Miền Trung phải >= 1.500.000 VNĐ';
            p_TourId := -1;
            RETURN;
        WHEN p_TourType = N'Nghỉ dưỡng' AND p_BasePrice < 3000000 THEN
            p_Message := 'Giá tour Nghỉ dưỡng phải >= 3.000.000 VNĐ';
            p_TourId := -1;
            RETURN;
        ELSE
            NULL; -- Valid price
    END CASE;
    
    -- Insert tour
    INSERT INTO Tours (TourName, TourType, BasePrice, Duration, Description, ManagerId)
    VALUES (p_TourName, p_TourType, p_BasePrice, p_Duration, p_Description, p_ManagerId)
    RETURNING TourId INTO p_TourId;
    
    COMMIT;
    p_Message := 'Tạo tour thành công!';
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_Message := 'Lỗi: ' || SQLERRM;
        p_TourId := -1;
END SP_CreateTour;
/

-- 2. Procedure: Cập nhật Tour
CREATE OR REPLACE PROCEDURE SP_UpdateTour(
    p_TourId IN NUMBER,
    p_TourName IN NVARCHAR2,
    p_TourType IN NVARCHAR2,
    p_BasePrice IN NUMBER,
    p_Duration IN NVARCHAR2,
    p_Description IN CLOB,
    p_ManagerId IN NUMBER,
    p_Success OUT NUMBER,
    p_Message OUT VARCHAR2
)
AS
    v_count NUMBER;
BEGIN
    -- Kiểm tra tour có tồn tại không
    SELECT COUNT(*) INTO v_count FROM Tours WHERE TourId = p_TourId;
    
    IF v_count = 0 THEN
        p_Success := 0;
        p_Message := 'Tour không tồn tại!';
        RETURN;
    END IF;
    
    UPDATE Tours
    SET TourName = p_TourName,
        TourType = p_TourType,
        BasePrice = p_BasePrice,
        Duration = p_Duration,
        Description = p_Description,
        ManagerId = p_ManagerId
    WHERE TourId = p_TourId;
    
    COMMIT;
    p_Success := 1;
    p_Message := 'Cập nhật thành công!';
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_Success := 0;
        p_Message := 'Lỗi: ' || SQLERRM;
END SP_UpdateTour;
/

-- 3. Procedure: Xóa Tour (kiểm tra ràng buộc)
CREATE OR REPLACE PROCEDURE SP_DeleteTour(
    p_TourId IN NUMBER,
    p_Success OUT NUMBER,
    p_Message OUT VARCHAR2
)
AS
    v_schedule_count NUMBER;
    v_booking_count NUMBER;
BEGIN
    -- Kiểm tra tour có lịch trình không
    SELECT COUNT(*) INTO v_schedule_count
    FROM TourSchedules
    WHERE TourId = p_TourId;
    
    IF v_schedule_count > 0 THEN
        -- Kiểm tra có booking không
        SELECT COUNT(*) INTO v_booking_count
        FROM Bookings b
        INNER JOIN TourSchedules ts ON b.ScheduleId = ts.ScheduleId
        WHERE ts.TourId = p_TourId;
        
        IF v_booking_count > 0 THEN
            p_Success := 0;
            p_Message := 'Không thể xóa! Tour đã có ' || v_booking_count || ' booking.';
            RETURN;
        END IF;
    END IF;
    
    -- Xóa tour
    DELETE FROM Tours WHERE TourId = p_TourId;
    COMMIT;
    
    p_Success := 1;
    p_Message := 'Xóa tour thành công!';
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_Success := 0;
        p_Message := 'Lỗi: ' || SQLERRM;
END SP_DeleteTour;
/

-- 4. Procedure: Tạo Booking với tính toán tự động
CREATE OR REPLACE PROCEDURE SP_CreateBooking(
    p_CustomerId IN NUMBER,
    p_ScheduleId IN NUMBER,
    p_NumAdults IN NUMBER,
    p_NumChildren IN NUMBER,
    p_BookingId OUT NUMBER,
    p_TotalAmount OUT NUMBER,
    p_Message OUT VARCHAR2
)
AS
    v_base_price NUMBER;
    v_max_capacity NUMBER;
    v_current_book NUMBER;
    v_tour_id NUMBER;
    v_discount_percent NUMBER := 0;
BEGIN
    -- Lấy thông tin tour và schedule
    SELECT t.BasePrice, ts.MaxCapacity, ts.CurrentBook, ts.TourId
    INTO v_base_price, v_max_capacity, v_current_book, v_tour_id
    FROM TourSchedules ts
    INNER JOIN Tours t ON ts.TourId = t.TourId
    WHERE ts.ScheduleId = p_ScheduleId;
    
    -- LOOP: Kiểm tra còn chỗ không
    IF (v_current_book + p_NumAdults + p_NumChildren) > v_max_capacity THEN
        p_Message := 'Không đủ chỗ! Còn ' || (v_max_capacity - v_current_book) || ' chỗ.';
        p_BookingId := -1;
        p_TotalAmount := 0;
        RETURN;
    END IF;
    
    -- Tính tổng tiền (trẻ em giảm 50%)
    p_TotalAmount := (p_NumAdults * v_base_price) + (p_NumChildren * v_base_price * 0.5);
    
    -- CASE: Áp dụng giảm giá theo số lượng
    CASE
        WHEN (p_NumAdults + p_NumChildren) >= 10 THEN
            v_discount_percent := 15; -- Giảm 15% cho đoàn từ 10 người
        WHEN (p_NumAdults + p_NumChildren) >= 5 THEN
            v_discount_percent := 10; -- Giảm 10% cho đoàn từ 5 người
        WHEN (p_NumAdults + p_NumChildren) >= 3 THEN
            v_discount_percent := 5; -- Giảm 5% cho đoàn từ 3 người
        ELSE
            v_discount_percent := 0;
    END CASE;
    
    -- Áp dụng giảm giá
    IF v_discount_percent > 0 THEN
        p_TotalAmount := p_TotalAmount * (100 - v_discount_percent) / 100;
    END IF;
    
    -- Tạo booking
    INSERT INTO Bookings (CustomerId, ScheduleId, BookingDate, NumAdults, NumChildren, TotalAmount, Status)
    VALUES (p_CustomerId, p_ScheduleId, SYSDATE, p_NumAdults, p_NumChildren, p_TotalAmount, N'Mới đặt')
    RETURNING BookingId INTO p_BookingId;
    
    -- Cập nhật số chỗ đã đặt
    UPDATE TourSchedules
    SET CurrentBook = CurrentBook + p_NumAdults + p_NumChildren
    WHERE ScheduleId = p_ScheduleId;
    
    COMMIT;
    p_Message := 'Đặt tour thành công! Giảm giá: ' || v_discount_percent || '%';
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_Message := 'Không tìm thấy lịch trình tour!';
        p_BookingId := -1;
        p_TotalAmount := 0;
    WHEN OTHERS THEN
        ROLLBACK;
        p_Message := 'Lỗi: ' || SQLERRM;
        p_BookingId := -1;
        p_TotalAmount := 0;
END SP_CreateBooking;
/

-- 5. Procedure: Cập nhật trạng thái Booking
CREATE OR REPLACE PROCEDURE SP_UpdateBookingStatus(
    p_BookingId IN NUMBER,
    p_NewStatus IN NVARCHAR2,
    p_Success OUT NUMBER,
    p_Message OUT VARCHAR2
)
AS
    v_old_status NVARCHAR2(50);
    v_valid_status BOOLEAN := FALSE;
BEGIN
    -- Lấy trạng thái hiện tại
    SELECT Status INTO v_old_status
    FROM Bookings
    WHERE BookingId = p_BookingId;
    
    -- CASE: Validate chuyển trạng thái hợp lệ
    CASE v_old_status
        WHEN N'Mới đặt' THEN
            IF p_NewStatus IN (N'Chờ thanh toán', N'Đã hủy') THEN
                v_valid_status := TRUE;
            END IF;
        WHEN N'Chờ thanh toán' THEN
            IF p_NewStatus IN (N'Đã đặt cọc', N'Đã xác nhận', N'Đã hủy') THEN
                v_valid_status := TRUE;
            END IF;
        WHEN N'Đã đặt cọc' THEN
            IF p_NewStatus IN (N'Đã xác nhận', N'Đã hủy') THEN
                v_valid_status := TRUE;
            END IF;
        WHEN N'Đã xác nhận' THEN
            IF p_NewStatus IN (N'Hoàn thành', N'Đã hủy') THEN
                v_valid_status := TRUE;
            END IF;
        ELSE
            v_valid_status := FALSE;
    END CASE;
    
    IF NOT v_valid_status THEN
        p_Success := 0;
        p_Message := 'Không thể chuyển từ "' || v_old_status || '" sang "' || p_NewStatus || '"';
        RETURN;
    END IF;
    
    -- Cập nhật trạng thái
    UPDATE Bookings
    SET Status = p_NewStatus
    WHERE BookingId = p_BookingId;
    
    COMMIT;
    p_Success := 1;
    p_Message := 'Cập nhật trạng thái thành công!';
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_Success := 0;
        p_Message := 'Không tìm thấy booking!';
    WHEN OTHERS THEN
        ROLLBACK;
        p_Success := 0;
        p_Message := 'Lỗi: ' || SQLERRM;
END SP_UpdateBookingStatus;
/

-- 6. Procedure: Tạo Customer với validation
CREATE OR REPLACE PROCEDURE SP_CreateCustomer(
    p_FullName IN NVARCHAR2,
    p_Email IN VARCHAR2,
    p_Telephone IN VARCHAR2,
    p_Address IN NVARCHAR2,
    p_DateOfBirth IN DATE,
    p_IdentityNum IN VARCHAR2,
    p_AccountId IN NUMBER,
    p_CustomerId OUT NUMBER,
    p_Message OUT VARCHAR2
)
AS
    v_email_count NUMBER;
    v_phone_count NUMBER;
    v_age NUMBER;
BEGIN
    -- Kiểm tra email đã tồn tại chưa
    IF p_Email IS NOT NULL THEN
        SELECT COUNT(*) INTO v_email_count
        FROM Customers
        WHERE UPPER(Email) = UPPER(p_Email);
        
        IF v_email_count > 0 THEN
            p_Message := 'Email đã tồn tại!';
            p_CustomerId := -1;
            RETURN;
        END IF;
    END IF;
    
    -- Kiểm tra số điện thoại
    IF p_Telephone IS NOT NULL THEN
        SELECT COUNT(*) INTO v_phone_count
        FROM Customers
        WHERE Telephone = p_Telephone;
        
        IF v_phone_count > 0 THEN
            p_Message := 'Số điện thoại đã tồn tại!';
            p_CustomerId := -1;
            RETURN;
        END IF;
    END IF;
    
    -- Kiểm tra tuổi (phải >= 18)
    IF p_DateOfBirth IS NOT NULL THEN
        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_DateOfBirth) / 12);
        
        IF v_age < 18 THEN
            p_Message := 'Khách hàng phải từ 18 tuổi trở lên!';
            p_CustomerId := -1;
            RETURN;
        END IF;
    END IF;
    
    -- Tạo customer
    INSERT INTO Customers (FullName, Email, Telephone, Address, DateOfBirth, IdentityNum, AccountId)
    VALUES (p_FullName, p_Email, p_Telephone, p_Address, p_DateOfBirth, p_IdentityNum, p_AccountId)
    RETURNING CustomerId INTO p_CustomerId;
    
    COMMIT;
    p_Message := 'Tạo khách hàng thành công!';
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_Message := 'Lỗi: ' || SQLERRM;
        p_CustomerId := -1;
END SP_CreateCustomer;
/

-- =============================================
-- PHẦN 2: FUNCTIONS
-- =============================================

-- 1. Function: Tính tổng doanh thu theo Tour
CREATE OR REPLACE FUNCTION FN_GetTourRevenue(
    p_TourId IN NUMBER
) RETURN NUMBER
AS
    v_total_revenue NUMBER := 0;
BEGIN
    SELECT NVL(SUM(b.TotalAmount), 0)
    INTO v_total_revenue
    FROM Bookings b
    INNER JOIN TourSchedules ts ON b.ScheduleId = ts.ScheduleId
    WHERE ts.TourId = p_TourId
      AND b.Status NOT IN (N'Đã hủy');
    
    RETURN v_total_revenue;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END FN_GetTourRevenue;
/

-- 2. Function: Tính số booking theo trạng thái
CREATE OR REPLACE FUNCTION FN_CountBookingsByStatus(
    p_Status IN NVARCHAR2
) RETURN NUMBER
AS
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Bookings
    WHERE UPPER(TRIM(Status)) = UPPER(TRIM(p_Status));
    
    RETURN v_count;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END FN_CountBookingsByStatus;
/

-- 3. Function: Kiểm tra còn chỗ trống cho schedule
CREATE OR REPLACE FUNCTION FN_GetAvailableSeats(
    p_ScheduleId IN NUMBER
) RETURN NUMBER
AS
    v_max_capacity NUMBER;
    v_current_book NUMBER;
    v_available NUMBER;
BEGIN
    SELECT MaxCapacity, CurrentBook
    INTO v_max_capacity, v_current_book
    FROM TourSchedules
    WHERE ScheduleId = p_ScheduleId;
    
    v_available := v_max_capacity - v_current_book;
    
    -- IF-THEN: Đảm bảo không trả về số âm
    IF v_available < 0 THEN
        v_available := 0;
    END IF;
    
    RETURN v_available;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END FN_GetAvailableSeats;
/

-- 4. Function: Tính tổng chi tiêu của khách hàng
CREATE OR REPLACE FUNCTION FN_GetCustomerTotalSpent(
    p_CustomerId IN NUMBER
) RETURN NUMBER
AS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(TotalAmount), 0)
    INTO v_total
    FROM Bookings
    WHERE CustomerId = p_CustomerId
      AND Status NOT IN (N'Đã hủy');
    
    RETURN v_total;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END FN_GetCustomerTotalSpent;
/

-- 5. Function: Xếp hạng khách hàng (VIP, Gold, Silver, Bronze)
CREATE OR REPLACE FUNCTION FN_GetCustomerRank(
    p_CustomerId IN NUMBER
) RETURN NVARCHAR2
AS
    v_total_spent NUMBER;
    v_rank NVARCHAR2(20);
BEGIN
    v_total_spent := FN_GetCustomerTotalSpent(p_CustomerId);
    
    -- CASE: Phân loại theo tổng chi tiêu
    CASE
        WHEN v_total_spent >= 50000000 THEN
            v_rank := 'VIP';
        WHEN v_total_spent >= 20000000 THEN
            v_rank := 'Gold';
        WHEN v_total_spent >= 10000000 THEN
            v_rank := 'Silver';
        WHEN v_total_spent > 0 THEN
            v_rank := 'Bronze';
        ELSE
            v_rank := 'New';
    END CASE;
    
    RETURN v_rank;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Unknown';
END FN_GetCustomerRank;
/

-- 6. Function: Tính % công suất đặt chỗ của tour schedule
CREATE OR REPLACE FUNCTION FN_GetScheduleOccupancyRate(
    p_ScheduleId IN NUMBER
) RETURN NUMBER
AS
    v_max_capacity NUMBER;
    v_current_book NUMBER;
    v_rate NUMBER;
BEGIN
    SELECT MaxCapacity, CurrentBook
    INTO v_max_capacity, v_current_book
    FROM TourSchedules
    WHERE ScheduleId = p_ScheduleId;
    
    IF v_max_capacity > 0 THEN
        v_rate := ROUND((v_current_book / v_max_capacity) * 100, 2);
    ELSE
        v_rate := 0;
    END IF;
    
    RETURN v_rate;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END FN_GetScheduleOccupancyRate;
/

-- 7. Function: Tính số ngày còn lại đến ngày khởi hành
CREATE OR REPLACE FUNCTION FN_GetDaysUntilDeparture(
    p_ScheduleId IN NUMBER
) RETURN NUMBER
AS
    v_start_date DATE;
    v_days NUMBER;
BEGIN
    SELECT StartDate
    INTO v_start_date
    FROM TourSchedules
    WHERE ScheduleId = p_ScheduleId;
    
    v_days := TRUNC(v_start_date) - TRUNC(SYSDATE);
    
    RETURN v_days;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN -999;
END FN_GetDaysUntilDeparture;
/

COMMIT;
