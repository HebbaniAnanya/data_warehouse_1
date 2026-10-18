/* 
Testing the bronze.bronze.erp_lop_a101 table to perform the required transformations.

Actions:
 - Modified the contents of cid column to match cid in cust_info_table
 - Handles NULL values and other inconsistencies in the country column
*/

--- erp loc a101 table
SELECT 
REPLACE(cid, '-','') cid,
cntry
FROM bronze.erp_lop_a101
WHERE REPLACE(cid, '-','') NOT IN
(SELECT cst_key FROM silver.crm_cust_info);

-- country

SELECT DISTINCT cntry
FROM silver.erp_lop_a101


-- correction --
INSERT INTO silver.erp_lop_a101( cid, cntry)
SELECT 
REPLACE(cid,'-','_') cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_lop_a101
