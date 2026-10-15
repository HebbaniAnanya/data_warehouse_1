/*
This script creates the tables with the structured schema. It first checks if the table exists and if it exists it drops the table.
The object id function takes the table and type as the parameter here 'U' implies user table.
IF OBJECT_ID('bronze.crm', 'U'), you are explicitly telling SQL Server: Look for an object named bronze.crm, but only check 
if it's a regular user table. Ignore it if it's a view, a stored procedure, or anything else
*/
USE data_warehouse;

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
 cust_id INT,
 cst_key NVARCHAR(50),
 cst_firstname NVARCHAR(50),
 cst_lastname NVARCHAR(50),
 cst_material_status NVARCHAR(50),
 cst_gndr NVARCHAR(50),
 cst_create_date DATE
);

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num	NVARCHAR(50),
	sls_prd_key	NVARCHAR(50),
	sls_cust_id	INT,
	sls_order_dt INT,	
	sls_ship_dt	INT,
	sls_due_dt	INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

IF OBJECT_ID('bronze.erp_lop_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_lop_a101;
CREATE TABLE bronze.erp_lop_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat	NVARCHAR(50),
	subcat	NVARCHAR(50),
	maintenance NVARCHAR(50)
);
