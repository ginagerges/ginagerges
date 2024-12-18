SELECT 
    m.MenuID
FROM 
    Menu m
WHERE 
    m.MenuID = ANY (
        SELECT 
            o.MenuID
        FROM 
            Orders o
        GROUP BY 
            o.MenuID
        HAVING 
            COUNT(o.OrderID) > 2
    );
