# Documentation sur DBT


### Condtions préalables

`python3` ou `python`

### Le Début
Dans votre WSL, créez le dossier `dbt`.<br> 
Dans ce dossier-là, on doit écrit
```
python3 -m venv dbt_venv
```

Ça va nous créer le dossier dbt_venv qui va être utile pour créer l'environnement<br>
Pour acitver l'environnement, on écrit 
```
cd dbt_venv
source bin/activate
```
### Installation de dbt et d'adapter de snowflake

Commençons par installer dbt et dbt-snowflake
```
pip install dbt-snowflake
```
Vous pouvez vérifier si tout est bien installé en écrivant `dbt --version`. Vous devez avoir cette image-là:
```
Core:
  - installed: 1.7.8
  - latest:    1.7.8 - Up to date!

Plugins:
  - snowflake: 1.7.2 - Up to date!
```

### Initiation de Project

Pour faire le porjet, écrivez `dbt init`. Il va vous demender de choisir l'adapteur de snowflake. Choisissez son numéro. <br>
Pour bien configurer où on peut avoir l'information de configuration, vous pouvez regarder cette vidéo: `https://www.youtube.com/watch?v=w5JUGXqSbe4`

Pour le moment, vous devriez avoir 
```
account: jazbnsx-uo63135
user: alimrtdinch312
database: SNOWFLAKE_SAMPLE_DATA
warehouse: COMPUTE_WH
role: accountadmin
schema: TPCH_SF1
```

### profiles.yml

Pour accéder au fichier `profiles.yml`, vous pouvez regarder la documentation de `dashboard_store`<br>
Le contenue de fichier `profiles.yml` doit être semblé à celui-là:

```
adapter type: snowflake
adapter version: 1.7.2
Configuration:
profiles.yml file [OK found and valid]
dbt_project.yml file [OK found and valid]
Required dependencies:
- git [OK found]

Connection:
account: jazbnsx-uo63135
user: alimrtdinch312
database: SNOWFLAKE_SAMPLE_DATA
warehouse: COMPUTE_WH
role: accountadmin
schema: TPCH_SF1
authenticator: None
private_key_path: None
oauth_client_id: None
query_tag: None
client_session_keep_alive: False
host: None
port: None
proxy_host: None
proxy_port: None
protocol: None
connect_retries: 1
connect_timeout: None
retry_on_database_errors: False
retry_all: False
insecure_mode: False
reuse_connections: None
Registered adapter: snowflake=1.7.2
Connection test: [OK connection ok]

All checks passed!
```
Le contenue de votre fichier `profiles.yml` doit ressembé à celui-là:

```
oms_dbt_proj:
  outputs:
    dev:
      account: jazbnsx-uo63135
      database: SNOWFLAKE_SAMPLE_DATA
      password: votreMotDePass
      role: accountadmin
      schema: TPCH_SF1
      threads: 3
      type: snowflake
      user: alimrtdinch312
      warehouse: COMPUTE_WH
  target: dev
```

### La création de tables 
Écrivez cette commande-là pour avoir des tables qu'on va travailler avec.

```
CREATE DATABASE SLEEKMART_OMS;

CREATE SCHEMA L1_LANDING;

CREATE SCHEMA L2_PROCESSING;

CREATE SCHEMA L3_CONSUMPTION;

 

USE database SLEEKMART_OMS;

USE SCHEMA L1_LANDING;



CREATE TABLE IF NOT EXISTS Dates (

Date DATE NOT NULL,

Day VARCHAR(3) NULL,

Month VARCHAR(10) NULL,

Year VARCHAR(4) NULL,

Quarter INT NULL,

DayOfWeek VARCHAR(10) NULL,

WeekOfYear INT NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (Date));



CREATE TABLE IF NOT EXISTS customers (

CustomerID VARCHAR(10),

FirstName VARCHAR(50),

LastName VARCHAR(50),

Email VARCHAR(100),

Phone VARCHAR(100),

Address VARCHAR(100),

City VARCHAR(50),

State VARCHAR(2),

ZipCode VARCHAR(10),

Updated_at TIMESTAMP);



CREATE TABLE IF NOT EXISTS Employees (

EmployeeID INT NOT NULL,

FirstName VARCHAR(100) NULL,

LastName VARCHAR(100) NULL,

Email VARCHAR(200) NULL,

JobTitle VARCHAR(100) NULL,

HireDate DATE NULL,

ManagerID INT NULL,

Address VARCHAR(200) NULL,

City VARCHAR(50) NULL,

State VARCHAR(50) NULL,

ZipCode VARCHAR(10) NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (EmployeeID));



CREATE TABLE IF NOT EXISTS Stores (

StoreID INT NOT NULL,

StoreName VARCHAR(100) NULL,

Address VARCHAR(200) NULL,

City VARCHAR(50) NULL,

State VARCHAR(50) NULL,

ZipCode VARCHAR(10) NULL,

Email VARCHAR(200) NULL,

Phone VARCHAR(50) NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (StoreID));



CREATE TABLE IF NOT EXISTS Suppliers (

SupplierID INT NOT NULL,

SupplierName VARCHAR(100) NULL,

ContactPerson VARCHAR(100) NULL,

Email VARCHAR(200) NULL,

Phone VARCHAR(50) NULL,

Address VARCHAR(50) NULL,

City VARCHAR(50) NULL,

State VARCHAR(10) NULL,

ZipCode VARCHAR(10) NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (SupplierID));



CREATE TABLE IF NOT EXISTS Products (

ProductID INT NOT NULL,

Name VARCHAR(100) NULL,

Category VARCHAR(100) NULL,

RetailPrice DECIMAL(10,2) NULL,

SupplierPrice DECIMAL(10,2) NULL,

SupplierID INT NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (ProductID));



CREATE TABLE IF NOT EXISTS OrderItems (

OrderItemID INT NOT NULL,

OrderID INT NULL,

ProductID INT NULL,

Quantity INT NULL,

UnitPrice DECIMAL(10,2) NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (OrderItemID));



CREATE TABLE IF NOT EXISTS Orders (

OrderID INT NOT NULL,

OrderDate DATE NULL,

CustomerID INT NULL,

EmployeeID INT NULL,

StoreID INT NULL,

Status VARCHAR(10) NULL,

Updated_at TIMESTAMP NULL,

PRIMARY KEY (OrderID));


```

### Le schéma des tables
> [!IMPORTANT]
> C'est important d'avoir la visualisation des tables.

![Capture d’écran 2024-02-21 084130](https://github.com/AlimuratDinch/demo_dbt/assets/132238708/f1bfd8a1-b91e-42bf-8ff7-27a5759e48e2)

### Les tables
```
INSERT INTO L1_LANDING.customers (CUSTOMERID,
	FIRSTNAME ,
	LASTNAME,
	EMAIL ,
	PHONE ,
	ADDRESS ,
	CITY ,
	STATE ,
	ZIPCODE,
	UPDATED_AT)
VALUES ('1','François','Roy','Roy@gmail.com','438-563-1234','St-Denis', 'Montréal','QC','H4V 3R5', null),
('2','Yusuf','Kanridag','Yusuf@gmail.com','438-573-1274','Guy-Concorria', 'Montréal','QC','H8V 4R5', null),
('3','Li','Kim','Kim@gmail.com','514-383-2374','Guy-Concoria', 'Montréal','QC','H8V 4R5', null);

select * from L1_LANDING.customers

INSERT INTO L1_LANDING.orders (OrderID,

OrderDate,

CustomerID,

EmployeeID,

StoreID,

Status ,

Updated_at )
VALUES (1,null,2,1,2,'active',null),
(2,null,2,1,2,'active',null),
(3,null,1,1,2,'done', null);

select * from L1_LANDING.orders
```
### Opération
```
select C.CUSTOMERID, CONCAT(C.FIRSTNAME,' ', C.LASTNAME) AS CUSTOMERNAME,COUNT(O.ORDERID) AS NO_OF_ORDERS 
from L1_LANDING.CUSTOMERS C
JOIN L1_LANDING.ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
GROUP BY C.CUSTOMERID, CUSTOMERNAME
ORDER BY NO_OF_ORDERS DESC;
```
![s1](https://github.com/AlimuratDinch/demo_dbt/assets/132238708/96de5d62-7d2a-47e8-8041-e39ca3006106)

## CTE

### Requête Régulière
```
SELECT column1, column2...
FROM table_name
...
```
### Requête CTE équivalente
```
SELECT cte_name AS(
SELECT column1, column2...
FROM table_name
...)
SELECT * FROM cte_name
```
`Exemple`
```
with CUSTOMERORDERS as(

select C.CUSTOMERID, CONCAT(C.FIRSTNAME,' ', C.LASTNAME) AS CUSTOMERNAME,COUNT(O.ORDERID) AS NO_OF_ORDERS 
from L1_LANDING.CUSTOMERS C
JOIN L1_LANDING.ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
GROUP BY C.CUSTOMERID, CUSTOMERNAME
ORDER BY NO_OF_ORDERS DESC
)

SELECT CUSTOMERID, CUSTOMERNAME, NO_OF_ORDERS
FROM CUSTOMERORDERS

```

### Éxecution de premier model

Vous devez créer le nouveau fichier de SQL et enter le code précédent.

![s2](https://github.com/AlimuratDinch/demo_dbt/assets/132238708/11fb9555-78fe-4870-b612-5e1c94a8397b)


Écrivez `dbt run`

Il va vous donner cette image
```
Found 1 model, 0 sources, 0 exposures, 0 metrics, 430 macros, 0 groups, 0 semantic models

Concurrency: 3 threads (target='dev')

1 of 1 START sql view model TPCH_SF1.customerorders ............................ [RUN]
1 of 1 OK created sql view model TPCH_SF1.customerorders ....................... [SUCCESS 1 in 0.80s]

Finished running 1 view model in 0 hours 0 minutes and 3.65 seconds (3.65s).
 
Completed successfully

Done. PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1
```

### Wikis

Les prochaines étapes vont être écrites dans les Wikis
