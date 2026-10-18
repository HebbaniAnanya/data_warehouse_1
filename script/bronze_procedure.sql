/* 
====================================================================================
DDL Script: This script is used to create and execute a stored procedure load_bronze.
====================================================================================
Strict purpose:
The purpose of this script is to create tables in the bronze schema, it will drop the 
tables if they already exist.
Run this script to re define the the DDL structure of the bronze tables.
====================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start DATETIME, @batch_end DATETIME
	BEGIN TRY
	PRINT '===============================================';
	PRINT 'Loading Bronze Layer';
	PRINT '===============================================';

	PRINT '-----------------------------------------';
	PRINT 'CRM Tables';
	PRINT '-----------------------------------------';

	SET @batch_start = GETDATE();
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_cust_info;
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\MuraliHebbani\sql-warehouse-dataset\source_crm\cust_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_prd_info;
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\MuraliHebbani\sql-warehouse-dataset\source_crm\prd_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 


	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\MuraliHebbani\sql-warehouse-dataset\source_crm\sales_details.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 


	PRINT '-----------------------------------------';
	PRINT 'ERP Tables';
	PRINT '-----------------------------------------';

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_lop_a101;
	BULK INSERT bronze.erp_lop_a101
	FROM 'C:\Users\MuraliHebbani\sql-warehouse-dataset\source_erp\loc_a101.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 


	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_cust_az12;
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\MuraliHebbani\sql-warehouse-dataset\source_erp\cust_az12.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 


	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\MuraliHebbani\sql-warehouse-dataset\source_erp\px_cat_g1v2.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration:' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' 
    
	SET @batch_end = GETDATE();
	PRINT '====================================';
	PRINT 'Batch load complete'
	PRINT '====================================';
	PRINT 'BATCH LOAD TIME:' + CAST(DATEDIFF(second, @batch_start, @batch_end) AS NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
		PRINT '====================================';
		PRINT 'ERROR OCCURED WHILE LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_MESSAGE() AS NVARCHAR);
		PRINT '====================================';
	END CATCH
END

EXEC bronze.load_bronze
