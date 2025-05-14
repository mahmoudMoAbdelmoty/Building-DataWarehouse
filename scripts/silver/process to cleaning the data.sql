--select * from bronze.crm_cust_info
-- cleaning the crm_cust_info
select 
	cst_id,
	cst_key,
	TRIM(cst_firstname) as cst_first_name,
	TRIM(cst_lastname) as cst_lastname,
	case	
		when UPPER(TRIM(cst_marital_status)) = 'M' then 'Married'
		when UPPER(TRIM(cst_marital_status)) = 'S' then 'Single'
		else 'n/a'
	end as cst_marital_status,
	case	
		when UPPER(TRIM(cst_gndr)) = 'M' then 'Male'
		when UPPER(TRIM(cst_gndr)) = 'F' then 'Female'
		else 'n/a'
	end as cst_gndr,
	cst_create_date

from(
	select *,
	ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag
	from bronze.crm_cust_info
	where cst_id is not null
) t
where flag = 1; -- select the most recent record per customer


-- prd_info
select top(100) * from bronze.crm_prd_info
select
	prd_id,
	REPLACE(SUBSTRING(prd_key, 1,5), '-', '_') as cat_id,
	SUBSTRING(prd_key, 7, len(prd_key)) as prd_key,
	prd_nm,
	ISNULL(prd_cost, 0) as prd_cost,
	CASE 
		WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		ELSE 'n/a'
	END AS prd_line, -- Map product line codes to descriptive values
	CAST(prd_start_dt as date) as prd_start_dt,
	CAST(
		LEAD(prd_start_dt) over(partition by prd_key order by prd_start_dt) - 1
		as date
	) as prd_end_dt
from bronze.crm_prd_info;


-- sales_details
select
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	case
		when sls_order_dt = 0 or len(sls_order_dt) <> 8 then NULL
		else cast(CAST(sls_order_dt as varchar) as date) 
	end as sls_order_dt,
	CASE 
		WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) <> 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END AS sls_ship_dt,
	CASE 
		WHEN sls_due_dt = 0 OR LEN(sls_due_dt) <> 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	END AS sls_due_dt,
	CASE 
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales <> sls_quantity * ABS(sls_price) 
			THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS sls_sales, -- Recalculate sales if original value is missing or incorrect
	sls_quantity,
	CASE 
		WHEN sls_price IS NULL OR sls_price <= 0 
			THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price  -- Derive price if original value is invalid
	END AS sls_price
from
	bronze.crm_sales_details;


-- erp_cust_az12
select
	case
		when cid like 'NAS%' then SUBSTRING(cid, 4, len(cid))
		else cid
	end as cid,
	case
		when bdate > GETDATE() then NULL
		else bdate
	end as bdate,
	CASE
		WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'n/a'
	END AS gen
from bronze.erp_cust_az12;

-- erp_loc_a101
SELECT
	REPLACE(cid, '-', '') AS cid, 
	CASE
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE TRIM(cntry)
	END AS cntry -- Normalize and Handle missing or blank country codes
FROM bronze.erp_loc_a101;

-- erp_px_cat
SELECT
	id,
	cat,
	subcat,
	maintenance
FROM bronze.erp_px_cat_g1v2;