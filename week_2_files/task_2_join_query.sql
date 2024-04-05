SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.Cost, Menus.MenuID, MenuItems.Course
FROM Orders
JOIN Menus
ON Orders.MenuID = Menus.MenuID
JOIN MenuItems
ON Menus.MenuItemsID = MenuItems.MenuItemsID
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
WHERE Cost > 150;