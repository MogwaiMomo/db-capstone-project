# INSERT INTO Customers (CustomerID, CustomerName, LocationID);
INSERT INTO Customers (CustomerID, CustomerName, LocationID)
SELECT `Customer ID`, `Customer Name`, LocationID
FROM littlelemon_data
JOIN Locations
ON littlelemon_data.Country = Locations.Country
AND littlelemon_data.City = Locations.City
AND littlelemon_data.`Postal Code` = Locations.PostalCode;

