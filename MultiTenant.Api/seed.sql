DROP DATABASE IF EXISTS multi_tenant;
CREATE DATABASE multi_tenant;

\connect multi_tenant;

DROP SCHEMA IF EXISTS tenant_one;
CREATE SCHEMA tenant_one;

DROP SCHEMA IF EXISTS tenant_two;
CREATE SCHEMA tenant_two;

CREATE TABLE IF NOT EXISTS public.Customers (
    Id uuid NOT NULL,
    Domain VARCHAR(100) NOT NULL,
    Schema VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.Config (
    Id uuid NOT NULL,
    Description VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tenant_one.Config (
    Id uuid NOT NULL,
    Description VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tenant_two.Config (
    Id uuid NOT NULL,
    Description VARCHAR(100) NOT NULL
);


INSERT INTO public.Customers (Id, Domain, Schema)
SELECT '3764d2b3-1789-4356-a5fe-d9432565e8c1', 'localhost', 'public'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '3764d2b3-1789-4356-a5fe-d9432565e8c1'
    );

INSERT INTO public.Customers (Id, Domain, Schema)
SELECT '906934ac-fd31-40e9-ab8e-ae6779c2c4d9', 'mt-one', 'tenant_one'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '906934ac-fd31-40e9-ab8e-ae6779c2c4d9'
    );

INSERT INTO public.Customers (Id, Domain, Schema)
SELECT '29ef3ea5-cce3-4443-96ab-43571d7d782b', 'mt-two', 'tenant_two'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '29ef3ea5-cce3-4443-96ab-43571d7d782b'
    );


INSERT INTO public.Config (Id, Description)
SELECT '3a7fbab0-e0f0-4dbf-9e8c-5d84edab9b62', 'localhost configuration'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '3a7fbab0-e0f0-4dbf-9e8c-5d84edab9b62'
    );

INSERT INTO tenant_one.Config (Id, Description)
SELECT '5983c769-4f81-4225-968f-88fd803579dc', 'tenant_one configuration'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '5983c769-4f81-4225-968f-88fd803579dc'
    );

INSERT INTO tenant_two.Config (Id, Description)
SELECT '0a17adb9-dd5c-4882-975e-a96b572443e7', 'tenant_two configuration'
WHERE 
    NOT EXISTS (
        SELECT Id from Customers WHERE Id = '0a17adb9-dd5c-4882-975e-a96b572443e7'
    );