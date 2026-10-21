/*
===============================================================================
Stored Procedure : Load Bronze Layer (Source >> Bronze)
===============================================================================
Script Purpose:
    This Stored Procedure Loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from csv files to bronze tables 

PARAMETERS :
    NONE.
  This stored Procedure does not accept any parameters or returns any values.

Usage Example :
  EXEC bronze.load_bronze
===============================================================================

*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
	--4
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY

		PRINT '======================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================================================';

		PRINT '-------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------------';
		--4
		SET @start_time = GETDATE ()

		PRINT '>> Truncating Table : bronze.crm_cust_info' ;
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>> Inserting Data Into : bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM	
		'C:\Users\DELL\OneDrive\Desktop\source_crm\cust_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		--4
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST ( DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------------'

		SET @start_time = GETDATE ()
		PRINT '>> Truncating Table :bronze.crm_prd_info ' ;
		TRUNCATE TABLE bronze.crm_prd_info 

		PRINT '>> Inserting Data Into : bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\Users\DELL\OneDrive\Desktop\source_crm\prd_info.csv'

		WITH
		(	FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST ( DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------------'

		;

		SET @start_time = GETDATE ()
		PRINT '>> Truncating Table :  bronze.crm_sales_details ' ;
		TRUNCATE TABLE [bronze].[crm_sales_details]

		PRINT '>> Inserting Data Into : bronze.crm_sales_details'
		BULK INSERT [bronze].[crm_sales_details] 
		FROM 'C:\Users\DELL\OneDrive\Desktop\source_crm\sales_details.csv'

		WITH
		(	FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST ( DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------------'
		;

		--source_erp
		
		PRINT '-------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------------------';

		SET @start_time = GETDATE ()
		PRINT '>> Truncating Table :  bronze.erp_CUST_AZ12' ;
		TRUNCATE TABLE [bronze].[erp_CUST_AZ12]

		PRINT '>> Inserting Data Into : bronze.erp_CUST_AZ12'
		BULK INSERT [bronze].[erp_CUST_AZ12]
		FROM 'C:\Users\DELL\OneDrive\Desktop\source_erp\CUST_AZ12.csv'

		WITH
		(	FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST ( DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------------'

		;

		SET @start_time = GETDATE ()

		PRINT '>> Truncating Table :  bronze.erp_LOC_A101' ;
		TRUNCATE TABLE [bronze].[erp_LOC_A101]

		PRINT '>> Inserting Data Into : bronze.erp_LOC_A101'
		BULK INSERT [bronze].[erp_LOC_A101]
		FROM 'C:\Users\DELL\OneDrive\Desktop\source_erp\LOC_A101.csv'

		WITH
		(	FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST ( DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------------'
		;

		SET @start_time = GETDATE ()

		PRINT '>> Truncating Table :  bronze.erp_PX_CAT_G1V2'
		TRUNCATE TABLE [bronze].[erp_PX_CAT_G1V2]

	
		PRINT '>> Inserting Data Into : bronze.erp_PX_CAT_G1V2'
		BULK INSERT [bronze].[erp_PX_CAT_G1V2]
		FROM 'C:\Users\DELL\OneDrive\Desktop\source_erp\PX_CAT_G1V2.csv'

		WITH
		(	FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST ( DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------------'

	;
	END TRY
	BEGIN CATCH -- Only if END block has An ERROR 
		PRINT '==========================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE () ;
		PRINT 'Error Message' + CAST (ERROR_NUMBER () AS NVARCHAR) ; 
		PRINT 'Error Message' + CAST (ERROR_STATE () AS NVARCHAR) ; 
		PRINT '==========================================================';

	END CATCH
END
