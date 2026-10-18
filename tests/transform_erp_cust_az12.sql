/* 
Testing the bronze.erp_cust_az12 table to perform the required transformations.

Actions:
 - Modified the contents of cid column to match cid in cust_info_table
 - Checked the bdate column for out of range birthdays eg: future dates
*/

SELECT 
* FROM bronze.erp_cust_az12;


-- in the cid it has extra 3 characters NAS
SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	 ELSE cid
END AS cid,
bdate,
gen FROM bronze.erp_cust_az12
WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
	ELSE cid
END NOT IN ( SELECT DISTINCT cst_key FROM silver.crm_cust_info)

---- checking bdates

select distinct
bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

--- 
SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	 ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
     ELSE bdate
END AS bdate,
gen 
FROM bronze.erp_cust_az12

--- check gender collumn

SELECT DISTINCT gen
FROM bronze.erp_cust_az12
-- cleaning it up
SELECT DISTINCT 
gen,
CASE 
	 WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12

---
INSERT INTO silver.erp_cust_az12( cid, bdate, gen)
SELECT 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	 ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
     ELSE bdate
END AS bdate,
CASE 
	 WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12
