IF OBJECT_ID(N'dbo.GetDataTypes', N'IF') IS NOT NULL DROP FUNCTION dbo.GetDataTypes;
GO

CREATE FUNCTION dbo.GetDataTypes(@SCHEMA_NAME AS NVARCHAR(128)
                              , @TABLE_NAME AS NVARCHAR(128)
						                  , @COLUMN_NAME AS NVARCHAR(128)) RETURNS TABLE
AS
RETURN
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
GO