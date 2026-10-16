---check for nulls duplicates in primary key
-- expectation no result

SELECT cust_id, COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cust_id
HAVING COUNT(*) >1 OR cust_id is NULL;

--- cust_id is NULL is important to add cause what if
-- there is only one NULL id it still needs to be addressed

SELECT * from 
(SELECT *, 
ROW_NUMBER() OVER(PARTITION BY cust_id ORDER BY cst_create_date DESC) as last_rec
FROM bronze.crm_cust_info)t
where last_rec =1

-- you want only the latest date one 

SELECT cst_firstname, cst_lastname FROM silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)
OR cst_lastname != TRIM(cst_lastname)

-- checking unwanted spaces in the string

SELECT  
cust_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
FROM(
	SELECT *, 
	ROW_NUMBER() OVER(PARTITION BY cust_id ORDER BY cst_create_date DESC) as last_rec
	FROM bronze.crm_cust_info)t
where last_rec =1

--implement the trimming of names

SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

--
USE data_warehouse;

INSERT INTO silver.crm_cust_info(
	cust_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)
SELECT  
cust_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'SINGLE'
	 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'MARRIED'
	 ELSE 'n/a'
END cst_marital_status,
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F'THEN 'Female'
	 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	 ELSE 'n/a'
END cst_gndr,
cst_create_date
FROM(
	SELECT *, 
	ROW_NUMBER() OVER(PARTITION BY cust_id ORDER BY cst_create_date DESC) as last_rec
	FROM bronze.crm_cust_info)t
where last_rec =1
