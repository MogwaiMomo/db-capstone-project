# Exercise 2 - Task 2 (Prepared Statement)
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost FROM Orders WHERE CustomerID = ?';
SET @id = "00-090-3491";
EXECUTE GetOrderDetail USING @id;