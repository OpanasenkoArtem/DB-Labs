INSERT INTO Category (name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Garden'),
('Sports');

INSERT INTO Client (name, email, phone) VALUES
('1user', 'user.1@gmail.com',  '+380501234567'),
('2user', 'user.2@gmail.com',  '+380679876543'),
('3user', 'user.3gmail.com',   '+380931112233'),
('4user', 'user.4@gmail.com',  '+380934445566'),
('5user', 'user.5@gmail.com',  '+380934445566');

INSERT INTO City (city, country) VALUES
('Київ',   'Україна'),
('Харків', 'Україна'),
('Одеса',  'Україна'),
('Madrid', 'Spain'),
('London', 'UK');

INSERT INTO Address (street, city_id, client_id) VALUES
('вул. Хрещатик, 1',    1, 1),  -- Київ,   1user
('вул. Сумська, 45',    2, 2),  -- Харків, 2user
('Calle Mayor, 10',     4, 3),  -- Madrid, 3user
('10 Downing Street',   5, 4),  -- London, 4user
('просп. Перемоги, 12', 1, 5),  -- Київ,   5user
('вул. Набережна, 7',   3, 1);  -- Одеса,  1user

INSERT INTO Product (name, price, description, category_id) VALUES
('Смартфон',        29999.99, '6.2" AMOLED, 256 GB',            1),
('Навушники',        9499.00, 'Бездротові, шумопоглинання',      1),
('Зимова куртка',    3200.00, 'Розмір M, чорна',                 2),
('Книга',             450.00, 'Видання 2023, тверда обкладинка', 3),
('Тенісна ракетка',  2750.50, 'Carbon frame, 300g',              5),
('Садовий шланг',     680.00, 'Reinforced rubber',               4);


INSERT INTO "order" (order_date, status, address_id, client_id) VALUES
('2025-03-01', 'completed',  1, 1),
('2025-03-05', 'processing', 2, 2),
('2025-03-10', 'shipped',    3, 3),
('2025-03-12', 'pending',    4, 4),
('2025-03-15', 'cancelled',  5, 5);

INSERT INTO Payment (amount, method, status, date, order_id) VALUES
(29999.99, 'card',          'paid',    '2025-03-01', 1),
( 9499.00, 'card',          'pending', '2025-03-05', 2),
( 3200.00, 'cash',          'paid',    '2025-03-10', 3),
( 2750.50, 'bank_transfer', 'pending', '2025-03-12', 4),
(  450.00, 'card',          'refunded','2025-03-15', 5);

INSERT INTO Order_details (quantity, price, order_id, product_id) VALUES
(1, 29999.99, 1, 1),  -- Смартфон
(1,  9499.00, 2, 2),  -- Навушники
(2,  3200.00, 3, 3),  -- Зимова куртка x2
(1,  2750.50, 4, 5),  -- Тенісна ракетка
(3,   450.00, 5, 4);  -- Книга x3