select OrderID,
    OrderDate,
    CustomerID,
    EmployeeID,
    StoreID,
    Status AS StatusCD,
    CASE
        when Status = 'active' then 'In Progress'
        else 'Cancelled'
    END AS StatusDesc,
    UPDATED_AT
from L1_LANDING.ORDERS