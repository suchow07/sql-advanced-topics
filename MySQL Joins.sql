-- MySQL JOINs

CREATE TABLE Clients (
   ClientID VARCHAR(10) DEFAULT NULL, 
   FullName VARCHAR(100) DEFAULT NULL, 
   ContactNumber BIGINT DEFAULT NULL
);
INSERT INTO Clients (ClientID, FullName, ContactNumber) VALUES    
("Cl1", "Michael Scott", 351786345),
("Cl2", "Pam Haris", 351547243), 
("Cl3", "Jim Hooper", 351791324), 
("Cl4", "James Cook", 351667386), 
("Cl5", "Angela Martin", 351724113), 
("Cl6", "Ryan Howard", 351796523),
("Cl7", "Sharmi Kapoor", 351891654);

CREATE TABLE Orders (
   OrderID INT NOT NULL PRIMARY KEY, 
   ClientID VARCHAR(10), 
   ProductID VARCHAR(10), 
   Quantity INT, 
   Cost DECIMAL(10,2), 
   Date DATE
);

INSERT INTO Orders (OrderID, ClientID, ProductID, Quantity, Cost, Date) VALUES
(101, 'Cl5', 'P1', 2, 29.99, '2024-10-01'),
(102, 'Cl2', 'P2', 1, 115.50, '2024-10-02'),
(103, 'Cl7', 'P3', 3, 245.00, '2024-10-03'),
(104, 'Cl3', 'P4', 5, 12.75, '2024-10-04'),
(105, 'Cl6', 'P5', 4, 22.30, '2024-10-05');


select * from clients;
select * from orders;

-- INNER JOIN
SELECT clients.ClientID,
	   clients.FullName,
       orders.OrderID
FROM   clients
INNER JOIN orders
      ON clients.ClientID = orders.ClientID;
      
-- LEFT JOIN
SELECT clients.ClientID,
       clients.FullName,
       orders.OrderID
FROM   clients
LEFT JOIN orders
      ON clients.ClientID = orders.ClientID;
      
-- RIGHT JOIN
SELECT clients.ClientID,
       clients.FullName,
       orders.OrderID
FROM   clients
RIGHT JOIN orders
      ON clients.ClientID = orders.ClientID;
      
-- SELF JOIN
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Role VARCHAR(50),
    ManagerID INT
);

INSERT INTO Employee (EmployeeID, FullName, Role, ManagerID) VALUES
(1, 'Alice Thompson', 'Manager', NULL), 
(2, 'Erica Brown', 'Executive', 1),       
(3, 'Daniel White', 'Assistant', 1),      
(4, 'Eva Sharma', 'Accountant', 5),       
(5, 'Monica Kohli', 'Manager', NULL);     

SELECT * FROM Employee;

SELECT e1.EmployeeID, 
       e1.FullName AS EmployeeName, 
       e1.Role, 
       e2.FullName AS ManagerName
FROM Employee e1
LEFT JOIN Employee e2 ON e1.ManagerID = e2.EmployeeID;

-- FULL OUTER JOIN
SELECT clients.ClientID, 
       clients.FullName, 
       orders.OrderID
FROM clients
LEFT JOIN orders ON clients.ClientID = orders.ClientID

UNION 

SELECT clients.ClientID, 
       clients.FullName, 
       orders.OrderID
FROM clients
RIGHT JOIN orders ON clients.ClientID = orders.ClientID;



