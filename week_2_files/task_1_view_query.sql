CREATE VIEW `OrdersView` AS
SELECT OrderID, Quantity, Cost
FROM Orders
WHERE Quantity > 2;