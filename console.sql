CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          product_name VARCHAR(30) NOT NULL,
                          company VARCHAR(20) NOT NULL,
                          product_count INT DEFAULT 0,
                          price NUMERIC NOT NULL,
                          is_discounted BOOL);

INSERT INTO products (product_name, company, product_count, price, is_discounted)
VALUES
    ('iPhone X', 'Apple', 3, 76000, false),
    ('iPhone 8', 'Apple', 2, 71000, true),
    ('iPhone 7', 'Apple', 5, 42000, true),
    ('Galaxy S9', 'Samsung', 2, 46000, false),
    ('Galaxy S8 Plus', 'Samsung', 1, 56000, true),
    ('Desire 12', 'HTC', 5, 28000, true),
    ('Nokia 9', 'HMD Global', 6, 38000, true);

-- 1. HTC компаниясынан башка компаниянын продуктуларын алыныз
SELECT * FROM products WHERE company <> 'HTC';
SELECT * FROM products WHERE company NOT IN ('HTC');
SELECT * FROM products WHERE company NOT LIKE  ('HTC%');

-- 2. Apple компаниясынын 75000минден томонку баадагы продуктуларын алыныз.
SELECT * FROM products WHERE company = 'Apple' AND price < 75000;

-- 3. Баасы 46000 жана андан ойдоку продуктулардын баарын алыныз
SELECT * FROM products WHERE price >= 46000;

--4. Эн кымбат эки продукту алыныз
SELECT * FROM products ORDER BY price DESC LIMIT (2);

-- 5. Баасы минимальный болгон продуктун атын алыныз
SELECT * FROM products WHERE price = (SELECT MIN(price) AS minimum FROM products);

--6. Дискоунт болгон продуктуларды чыгарыныз.
SELECT * FROM products WHERE is_discounted = true ;
SELECT * FROM products WHERE is_discounted <> false ;

--7. Дискоунт болбогон продуктуларды чыгарыныз.
SELECT * FROM products WHERE is_discounted = false;
SELECT * FROM products WHERE is_discounted != true;

--8. Баардык продуктулардын баасын кымбаттан арзанга карап чыгарыныз
SELECT * FROM products ORDER BY price DESC ;

--Кошумча (Баардык продуктулардын баасын арзандан кымбатына карап чыгарыныз)
SELECT * FROM products ORDER BY price ;

-- 9. Баардык продуктулардын суммасын(баасын) чыгарыныз.
SELECT COUNT(*) AS product_count,
       SUM(price) AS sum FROM products;

--10. Эки жана андан аз продуктусу бар компанияларды алыныз.
SELECT company, COUNT(*) AS product_count
FROM products
GROUP BY company
HAVING count(*) <= 2;