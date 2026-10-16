
USE classicmodels;

-- Xóa các procedure nếu đã tồn tại
DROP PROCEDURE IF EXISTS getCusById;
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;
DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //

-- 1. Tham số IN: tìm khách hàng theo mã
CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //

-- 2. Tham số OUT: đếm khách hàng theo thành phố
CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

-- 3. Tham số INOUT: tăng giá trị bộ đếm
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Kiểm tra IN
CALL getCusById(175);

-- Kiểm tra OUT
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS TotalCustomers;

-- Kiểm tra INOUT
SET @counter = 1;
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);
SELECT @counter AS CounterValue;
