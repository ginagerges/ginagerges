SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.TotalCost, 
    m.MenuID
    
FROM 
    CustomerDetails c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    Menu m ON o.MenuID = m.MenuID

WHERE 
    o.TotalCost > 150
ORDER BY 
    o.TotalCost ASC;


