-- Joins with duplicate Records
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
