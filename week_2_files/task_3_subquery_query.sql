SELECT MenuName
FROM Menus
WHERE MenuID = ANY 
(SELECT MenuID
FROM Orders
WHERE Quantity > 2);