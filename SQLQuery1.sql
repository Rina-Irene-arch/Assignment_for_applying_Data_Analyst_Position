WITH SalesData AS (
    SELECT 
        Region,
        Category,
        SUM(Sales) AS Total_Sales
    FROM [dbo].[global_superstore_orders_1]
    GROUP BY Region, Category
),
ReturnsData AS (
    SELECT 
        o.Region,
        o.Category,
        COUNT(r.Order_ID) AS Total_Returns
    FROM [dbo].[global_superstore_orders_1] o
    JOIN global_superstore_returnes r ON o.Order_ID = r.Order_ID
    WHERE r.Returned = 'Yes'
    GROUP BY o.Region, o.Category
)
SELECT 
    s.Region,
    s.Category,
    s.Total_Sales,
    COALESCE(r.Total_Returns, 0) AS Total_Returns
FROM SalesData s
LEFT JOIN ReturnsData r ON s.Region = r.Region AND s.Category = r.Category
ORDER BY s.Region, s.Category;
