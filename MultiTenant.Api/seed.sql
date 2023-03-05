DROP DATABASE IF EXISTS multi_tenant;
CREATE DATABASE multi_tenant;

\c multi_tenant

CREATE TABLE IF NOT EXISTS Customers (
    Id uuid NOT NULL,
    Domain VARCHAR(100) NOT NULL
);

INSERT INTO Customers (Id, Domain)
SELECT '906934ac-fd31-40e9-ab8e-ae6779c2c4d9', 'mtfuture'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '906934ac-fd31-40e9-ab8e-ae6779c2c4d9'
    );

INSERT INTO Customers (Id, Domain)
SELECT '3764d2b3-1789-4356-a5fe-d9432565e8c1', 'localhost'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '3764d2b3-1789-4356-a5fe-d9432565e8c1'
    );