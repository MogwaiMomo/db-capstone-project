#  Verify a booking, and decline any reservations for tables that are already booked under another name
DELIMITER //
CREATE PROCEDURE `AddValidBooking` (IN RequestedDate DATE, IN RequestedTable INT, IN RequestedCustomer VARCHAR(255))

BEGIN

	DECLARE TimeSlotBookingID INT DEFAULT NULL;   
	DECLARE RequestedCustomerID INT DEFAULT NULL;
    
    START TRANSACTION;
    
		# lookup id of RequestedCustomer
		SELECT IFNULL(CustomerID, 0) INTO RequestedCustomerID
		FROM Customers
		WHERE CustomerName = RequestedCustomer;
        
		# lookup if new booking exists
		SELECT IFNULL(BookingID, 0) INTO TimeSlotBookingID
		FROM Bookings
		WHERE BookingDate = RequestedDate
		AND TableNumber = RequestedTable;
    
		# if booking is available
        IF TimeSlotBookingID = 0 THEN
			# insert new customer to Customers
			IF RequestedCustomerID = 0 THEN
				INSERT INTO Customers (CustomerName) VALUES (RequestedCustomer);
				# then retrieve their id
				SELECT CustomerID INTO RequestedCustomerID
				WHERE CustomerName = RequestedCustomer;
			END IF;
            
            # insert new booking into Bookings
            INSERT INTO Bookings (BookingDate, TableNumber, CustomerID) VALUES
            (RequestedDate, RequestedTable, RequestedCustomerID);
            
            # print confirmation message of booking
            SELECT CONCAT(CustomerName, " has been booked on ", BookingDate, " at Table ", TableNumber, ".") AS ConfirmationMessage
            FROM Bookings
            JOIN Customers
            ON Bookings.CustomerID = Customers.CustomerID
			WHERE BookingDate = RequestedDate
			AND TableNumber = RequestedTable;
			COMMIT;
		ELSE
			SELECT "Requested time slot is unavailable. Rolling back ..." AS ConfirmationMessage;
			ROLLBACK;
		END IF;
		
	END;//

DELIMITER ;
