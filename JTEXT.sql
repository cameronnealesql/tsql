CREATE SCHEMA JTEXT AUTHORIZATION dbo;
GO

IF OBJECT_ID(N'JTEXT.HIRAKATA', N'FN') IS NOT NULL DROP FUNCTION JTEXT.HIRAKATA;
GO

CREATE FUNCTION JTEXT.HIRAKATA(@HIRAGANA AS NVARCHAR(MAX))
  RETURNS NVARCHAR(MAX)

AS
BEGIN
  DECLARE @KATAKANA AS NVARCHAR(MAX) = N''
  DECLARE @POS AS INT = 0
  DECLARE @TEMPCHAR AS INT

  WHILE @POS <= LEN(@HIRAGANA)
    BEGIN
      SET @TEMPCHAR = UNICODE(SUBSTRING(@HIRAGANA, @POS, 1))
      SET @KATAKANA = CONCAT(
                        @KATAKANA,
                        NCHAR(@TEMPCHAR + CASE
                                            WHEN @TEMPCHAR >= 12353
                                              AND @TEMPCHAR <= 12438 THEN 96
                                            ELSE 0
                                          END))
      SET @POS += 1
  END
  RETURN @KATAKANA
END;
GO



IF OBJECT_ID(N'JTEXT.KATAHIRA', N'FN') IS NOT NULL DROP FUNCTION JTEXT.KATAHIRA;
GO

CREATE FUNCTION JTEXT.KATAHIRA(@KATAKANA AS NVARCHAR(MAX))
  RETURNS NVARCHAR(MAX)

AS
BEGIN
  DECLARE @HIRAGANA AS NVARCHAR(MAX) = N''
  DECLARE @POS AS INT = 0
  DECLARE @TEMPCHAR AS INT

  WHILE @POS <= LEN(@KATAKANA)
    BEGIN
      SET @TEMPCHAR = UNICODE(SUBSTRING(@KATAKANA, @POS, 1))
      SET @HIRAGANA = CONCAT(
                        @HIRAGANA,
                        NCHAR(@TEMPCHAR - CASE
                                            WHEN @TEMPCHAR >= 12449
                                              AND @TEMPCHAR <= 12540 THEN 96
                                            ELSE 0
                                          END))
      SET @POS += 1
  END
  RETURN @HIRAGANA
END;
GO

SELECT JTEXT.HIRAKATA(N'ケーキを食べたい') AS hiragana_to_katakana, JTEXT.KATAHIRA(N'ケーキを食べたい' AS katakana_to_hiragana;
