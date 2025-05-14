/*
=========================
create Database and Schema
=========================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.

	WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.

*/

USE master;
GO

--Drop and Recrate the Datawarehouse
IF EXISTS(select 1 from sys.databases where name='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;--FORCE sql server DB(Warehouse) into single user Mode
	-- You want to restore a backup or make schema changes and need to ensure no other users interfere.
	DROP DATABASE DataWarehouse;
END
GO

-- Create the DataWarehouse
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO
-- Create the DB Schema
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO