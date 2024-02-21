select
    O.OrderID,
    O.OrderDate,
    O.CustomerID,
    O.EmployeeID,
    O.StoreID,
    O.StatusCD,
    O.StatusDesc,
    O.UPDATED_AT,
    COUNT(DISTINCT O.OrderID) AS OrderCount,
    SUM(OI.TotalPrice) as Revenue
from
    {{ ref('orders_stg') }} O
JOIN
    {{ ref('orderitems_stg') }} OI on O.OrderID = OI.OrderID

group by 
    O.OrderID,
    O.OrderDate,
    O.CustomerID,
    O.EmployeeID,
    O.StoreID