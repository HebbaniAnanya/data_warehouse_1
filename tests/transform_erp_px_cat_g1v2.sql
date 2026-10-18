/* 
Testing the bronze.erp_px_cat_g1v2 table to perform the required transformations.

Actions:
 - Handles extra spaces with cat, subcat and maintenance columns
*/

--- erp_px_cat
USE data_warehouse;
SELECT ID, CAT, SUBCAT, MAINTENANCE
FROM bronze.erp_px_cat_g1v2;

--- can be joined with product table on CAT id
SELECT px.cat, pr.cat_id
FROM bronze.erp_px_cat_g1v2 px
LEFT JOIN silver.crm_prd_info pr
ON px.cat=pr.cat_id
WHERE px.cat IS NULL;
-- result expectation no records it meets the expectation
--check unwanted spaces

SELECT  * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

SELECT DISTINCT
subcat
FROM bronze.erp_px_cat_g1v2;

INSERT INTO silver.erp_px_cat_g1v2(id, cat, subcat, maintenance)
SELECT *
FROM bronze.erp_px_cat_g1v2;

