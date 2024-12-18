SELECT MenuName
FROM Menus m
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    WHERE oi.MenuItemID IN (SELECT MenuItemID FROM MenuItems WHERE MenuID = m.MenuID)
    GROUP BY oi.MenuItemID
    HAVING SUM(oi.Quantity) > 2
);

