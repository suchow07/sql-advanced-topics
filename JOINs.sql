use sharonya;
use datalemurdb;

CREATE TABLE seats (
    id INT,
    student VARCHAR(10)
);

INSERT INTO seats VALUES 
(1, 'Amit'),
(2, 'Deepa'),
(3, 'Rohit'),
(4, 'Anjali'),
(5, 'Neha'),
(6, 'Sanjay'),
(7, 'Priya');
with cte as (select 
case when count(*) % 2 = 0 then Max(id)+ 1 else Max(id) end as cnt
from seats)
select *

from seats
where id < (SELECT cnt FROM cte)


drop table seats;


create table purchase_history
(userid int
,productid int
,purchasedate date
);
SET DATEFORMAT dmy;
insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012')
;

select * from purchase_history;


select userid
from purchase_history
group by userid
having count(distinct purchasedate)> 1
and count(distinct productid) = count(productid);

drop table purchase_history;

CREATE TABLE ProductSpend (
    category VARCHAR(50),
    product VARCHAR(100),
    user_id INT,
    spend DECIMAL(10, 2)
);

INSERT INTO ProductSpend (category, product, user_id, spend) VALUES
('appliance', 'refrigerator', 165, 26.00),
('appliance', 'refrigerator', 123, 3.00),
('appliance', 'washing machine', 123, 19.80),
('electronics', 'vacuum', 178, 5.00),
('electronics', 'wireless headset', 156, 7.00),
('electronics', 'vacuum', 145, 15.00),
('electronics', 'laptop', 114, 999.99),
('fashion', 'dress', 117, 49.99),
('groceries', 'milk', 243, 2.99),
('groceries', 'bread', 645, 1.99),
('home', 'furniture', 276, 599.99),
('home', 'decor', 456, 29.99);

with cte as(
select category,
product,
sum(spend) over(partition by product) as Spend,
dense_rank() over(partition by category order by spend desc) as rnk
from ProductSpend)

select category, product, spend
from cte
where rnk <= 2;


drop table ProductSpend;

drop table transactions;

CREATE TABLE transactions (
    product_id INT,
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);

INSERT INTO transactions (product_id, user_id, spend, transaction_date)
VALUES
(3673, 123, 68.90, '2022-07-08 10:00:00'),
(9623, 123, 274.10, '2022-07-08 10:00:00'),
(1467, 115, 19.90, '2022-07-08 10:00:00'),
(2513, 159, 25.00, '2022-07-08 10:00:00'),
(1452, 159, 74.50, '2022-07-10 10:00:00'),
(1452, 123, 74.50, '2022-07-10 10:00:00'),
(9765, 123, 100.15, '2022-07-11 10:00:00'),
(6536, 115, 57.00, '2022-07-12 10:00:00'),
(7384, 159, 15.50, '2022-07-12 10:00:00'),
(1247, 159, 23.40, '2022-07-12 10:00:00');  


select * from transactions;




WITH cte AS (
    SELECT 
        user_id, 
        MAX(transaction_date) AS max_date
    FROM transactions
    GROUP BY user_id
)
SELECT 
    cte.max_date AS transaction_date,
    t.user_id, 
    COUNT(t.product_id) AS purchase_count
FROM transactions t 
JOIN cte ON t.user_id = cte.user_id AND t.transaction_date = cte.max_date
GROUP BY cte.max_date, t.user_id;

with cte as(
select user_id,
max(transaction_date) as max_date
from transactions
group by user_id)
select t.transaction_date,
t.user_id,
count(t.product_id) as cnt
from transactions t
join cte 
on t.transaction_date = cte.max_date
and t.user_id = cte.user_id
group by t.user_id, t.transaction_date;

drop table transactions;
drop table table_a;
drop table table_b;

CREATE TABLE table_a (
    data_a INT
);

CREATE TABLE table_b (
    data_b INT
);
-- Insert data into table A
INSERT INTO table_a (data_a) VALUES
(1),
(1),
(0),
(0),
(1),
(2),
(NULL);

-- Insert data into table B
INSERT INTO table_b (data_b) VALUES
(1),
(0),
(NULL),
(NULL),
(1);

select * from table_a;
select * from table_b;

SELECT a.data_a AS data_a
, b.data_b AS  data_b
FROM table_a a
INNER JOIN table_b b
ON a.data_a = b.data_b;

SELECT a.data_a AS data_a
, b.data_b AS  data_b
FROM table_a a
LEFT JOIN table_b b
ON a.data_a = b.data_b;

SELECT a.data_a AS data_a
, b.data_b AS  data_b
FROM table_a a
RIGHT JOIN table_b b
ON a.data_a = b.data_b;

SELECT a.data_a AS data_a
, b.data_b AS  data_b
FROM table_a a
FULL OUTER JOIN table_b b
ON a.data_a = b.data_b;

SELECT a.data_a AS data_a
, b.data_b AS  data_b
FROM table_a a
LEFT JOIN table_b b
ON a.data_a = b.data_b
UNION ALL
SELECT a.data_a AS data_a
, b.data_b AS  data_b
FROM table_a a
RIGHT JOIN table_b b
ON a.data_a = b.data_b;