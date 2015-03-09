--Checks if the GetDataTypes inline-table function exists and deletes it so that it can be updated
--with changes. The N'IF' parameter is optional, but follows best practices.
IF OBJECT_ID(N'dbo.GetDataTypes', N'IF') IS NOT NULL DROP FUNCTION dbo.GetDataTypes;
GO

--Creates the functions. The dbo prefix ensures that the function can be used by the database
--owner without explicitly specifying a schema. The size of NVARCHAR is set to 128 characters
--which accomodates the maximum length of an object name in standard SQL.
CREATE FUNCTION dbo.GetDataTypes(
    @SCHEMA_NAME AS NVARCHAR(128)
  , @TABLE_NAME AS NVARCHAR(128)
  , @COLUMN_NAME AS NVARCHAR(128)) RETURNS TABLE
AS

RETURN
--From here you can see the basic query used to find data type information in SQL Server.
--The columns returned can easily be modified. If you wish to return all information about
--a column, the SELECT clause can be rewritten as SELECT *, although it is best practice in
--SQL to return only the data that you need.
SELECT
  TABLE_SCHEMA
  , TABLE_NAME
  , COLUMN_NAME
  , DATA_TYPE
  , CHARACTER_MAXIMUM_LENGTH
FROM
  INFORMATION_SCHEMA.COLUMNS
WHERE
  TABLE_SCHEMA     = ISNULL(@SCHEMA_NAME,TABLE_SCHEMA) 
  AND TABLE_NAME   = ISNULL(@TABLE_NAME,TABLE_NAME)
  AND COLUMN_NAME  = ISNULL(@COLUMN_NAME,COLUMN_NAME);
--End the batch with the GO command. This command may differ if you have specified an alternative
--statement in your RDBMS settings.
GO
