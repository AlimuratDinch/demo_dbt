select
    OS.CustomerID,
    C.CUSTOMERNAME,
    SUM(OS.OrderCount) AS OrderCount,
    SUM(OS.Revenue) as Revenue
from
    {{ ref('orders_fact') }} OS
JOIN
    {{ ref('customers_stg') }} C on OS.CustomerID = C.CustomerID
group by 
    OS.CustomerID,
    C.CustomerName