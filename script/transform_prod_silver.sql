
/* this is the silver layer transformation on table crm_prd_info */

USE data_warehouse;
/* checking which category ids from the prod_details are missing from the 
erp_px_cat_g1v2 table CO_PE IS MISSING */
SELECT 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key_con,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	 WHEN  'M' THEN 'Mountain',
	 WHEN  'R' THEN 'Road',
	 WHEN  'S' THEN 'other sales',
	 WHEN  'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
prd_start_dt,
prd_end_dt
FROM bronze.crm_prd_info
WHERE REPLACE(SUBSTRING(prd_key,1,5),'-','_') NOT IN
(SELECT distinct id from bronze.erp_px_cat_g1v2)

SELECT DISTINCT prd_line
from bronze.crm_prd_info

-- check for invalid date orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- some end dates are before the start dates 
-- there are overlapping dates i.e for the same product
-- two time periods are mentioned that overlap but the price 
-- has changed.
-- the fix is end date = 1 day before the start date of the next row of the same product category

SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	 WHEN  'M' THEN 'Mountain',
	 WHEN  'R' THEN 'Road',
	 WHEN  'S' THEN 'other sales',
	 WHEN  'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) -1 AS DATE) AS prd_end_dt,
FROM bronze.crm_prd_info

-- INSERTING THE TRANSFORMED DATA INTO THE SILVER SCHEMA
INSERT INTO SILVER.crm_prd_info(prd_id ,
	cat_id,
	prd_key ,
	prd_nm ,
	prd_cost ,
	prd_line ,
	prd_start_dt,
	prd_end_dt)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	 WHEN  'M' THEN 'Mountain'
	 WHEN  'R' THEN 'Road'
	 WHEN  'S' THEN 'other sales'
	 WHEN  'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) -1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info
