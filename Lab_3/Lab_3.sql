INSERT INTO Category (name) VALUES
('Pet supplies'),
('Childrens products');

INSERT INTO Client (name, email, phone) VALUES
('user5', 'user.5@example.com', '+380533134567'),
('user6', 'user.6@example.com', '+380555534567'),
('user7', 'user.7@example.com', '+380973243567'),
('user8', 'user.8@example.com', '+386521234567');

INSERT INTO Address (street, city, country, client_id) VALUES
('вул. Лесі Українки, 10', 'Київ', 'Україна', 6),
('вул. Грушевського, 22', 'Львів', 'Україна', 7),
('просп. Незалежності, 5', 'Одеса', 'Україна', 8),
('вул. Соборна, 3', 'Рівне',  'Україна', 9);

INSERT INTO Product (name, price, description, category_id) VALUES
('Корм для котів', 650.00, 'Збалансований', 6),
('Іграшка для собак', 120.00,  'Натуральна гума', 6),
('Килимок', 890.00, 'М`який матеріал', 7),
('Конструктор', 1450.00, 'Від 4 років', 7);

INSERT INTO "order" (order_date, status, address_id, client_id) VALUES
('2025-04-01', 'pending', 7, 6),
('2025-04-03', 'processing', 8, 7),
('2025-04-05', 'shipped', 9, 8),
('2025-04-07', 'completed', 10, 9);

INSERT INTO Order_details (quantity, price, order_id, product_id) VALUES
(2, 650.00, 6, 7);  

INSERT INTO Order_details (quantity, price, order_id, product_id) VALUES
(1, 120.00, 7, 8);   

INSERT INTO Order_details (quantity, price, order_id, product_id) VALUES
(1, 1450.00, 8, 10);  

INSERT INTO Payment (amount, method, status, date, order_id) VALUES
(1300.00, 'card', 'paid', '2025-04-01', 6),
(120.00, 'cash', 'paid', '2025-04-03', 7),
(1450.00, 'bank_transfer', 'pending', '2025-04-05', 8),
(890.00, 'card', 'paid', '2025-04-07', 9);

--

UPDATE "order"
SET status = 'completed'
WHERE id = 6;

UPDATE "order"
SET status = 'cancelled'
WHERE id = 7;

UPDATE "order"
SET status = 'shipped'
WHERE id = 8;

UPDATE Client
SET email = 'user1.new@example.com'
WHERE id = 1;

UPDATE Product
SET price = price * 1.10
WHERE category_id = 6;

--

SELECT * FROM Client;

SELECT price FROM Product
WHERE category_id = 6;

SELECT name, price
FROM Product
WHERE price > 1000;

SELECT name, email
FROM Client
WHERE name = '3user';

--

DELETE FROM Order_details
WHERE order_id = 3 AND product_id = 4;

DELETE FROM Payment WHERE order_id = 2;

DELETE FROM Order_details WHERE order_id = 2;

DELETE FROM "order" WHERE id = 2;