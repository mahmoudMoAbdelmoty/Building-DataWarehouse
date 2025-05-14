/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.
===============================================================================
*/

-- EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
Begin
	BEGIN TRY

		PRINT '-----------------------------------------------------------';
		PRINT '		>> Loading the Bronze Layer';
		PRINT '-----------------------------------------------------------';

		PRINT '===========================================================';
		PRINT '  >>> Load the Data from CRM Source and Insert Into Tables ';
		PRINT '===========================================================';
	
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'G:\DataWarehousing Project\Building DW\datasets\source_crm\cust_info.csv'
		WITH(
		FIELDTERMINATOR = ',',
		FIRSTROW = 2,
		TABLOCK
		);


		PRINT '>> Truncate Table bronze.crm_prd_inf'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'G:\DataWarehousing Project\Building DW\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		PRINT 'Truncate  table bronze.crm_sales_datails';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT 'Insret Data Into: bronze.crm_sales_datails';
		BULK INSERT bronze.crm_sales_details
		FROM 'G:\DataWarehousing Project\Building DW\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',', 
			TABLOCK
		);

		PRINT '===========================================================';
		PRINT '  >>> Load the Data from ERP Source and Insert Into Tables ';
		PRINT '===========================================================';
	
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'G:\DataWarehousing Project\Building DW\datasets\source_erp\cust_az12.csv'
		WITH(
		FIELDTERMINATOR = ',',
		FIRSTROW = 2,
		TABLOCK
		);


		PRINT '>> Truncate Table bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'G:\DataWarehousing Project\Building DW\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		PRINT 'Truncate  table bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT 'Insret Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'G:\DataWarehousing Project\Building DW\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',', 
			TABLOCK
		);

		PRINT '----------------------------------------------------------------';
		PRINT '		>> Loading the Bronze Layer is Completed';
		PRINT '----------------------------------------------------------------';

	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH

End