SELECT SUM(amount) AS total_revenue
FROM Payment;

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM Product;

SELECT
    status,
    COUNT(*) AS orders_count
FROM "order"
GROUP BY status
ORDER BY orders_count DESC;
