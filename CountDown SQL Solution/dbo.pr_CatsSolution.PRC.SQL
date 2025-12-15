--USE MASTER
--GO

--IF EXISTS (
--        SELECT name
--        FROM sys.databases
--        WHERE name = 'DemoCountDownSQLSolution'
--        )
--BEGIN
--    ALTER DATABASE DemoCountDownSQLSolution

--    SET SINGLE_USER
--    WITH

--    ROLLBACK IMMEDIATE;

--    DROP DATABASE DemoCountDownSQLSolution;
--END;

--CREATE DATABASE DemoCountDownSQLSolution;
--GO

USE DemoCountDownSQLSolution;
GO
--Variables and Base tables
DROP PROCEDURE IF EXISTS dbo.pr_CatsSolution;
GO
IF type_id('[dbo].[NumberSet]') IS NOT NULL
        DROP TYPE dbo.NumberSet;
CREATE TYPE dbo.NumberSet AS TABLE ([Target] INT, Value1 INT, Value2 INT, Value3 INT, Value4 INT, Value5 INT, Value6 INT);
GO
USE DemoCountDownSQLSolution;
GO
CREATE or Alter FUNCTION fn_maths
(@Value1 BIGINT,@Value2 BIGINT,@Operator TINYINT)
RETURNS BIGINT
AS
BEGIN
  declare @return BIGINT
  
  If (@Operator = 0) 
    Select @Return = @Value1 + @Value2
  If (@Operator = 1) 
    Select @Return = @Value1 - @Value2
  If (@Operator = 2) 
    Select @Return = @Value1 * @Value2
  If (@Operator = 3) 
    Select @Return = @Value1 / @Value2

  RETURN @return
END
GO

--Select * from dbo.Operators
--========================================================================================================================
--========================================================================================================================
--========================================================================================================================
DROP PROCEDURE IF EXISTS dbo.pr_CatsSolution;
GO
create procedure dbo.pr_CatsSolution @Countdown_NumberSet NumberSet READONLY
as

SELECT *
,dbo.fn_maths (Value1,Value2,0) [1&2+]
,dbo.fn_maths (Value2,Value3,0) [2&3+]
,dbo.fn_maths (Value3,Value4,0) [3&4+]
,dbo.fn_maths (Value4,Value5,0) [4&5+]
,dbo.fn_maths (Value5,Value1,0) [5&1+]
from @Countdown_NumberSet
GO
--========================================================================================================================
--========================================================================================================================
--========================================================================================================================


-- Source - https://stackoverflow.com/a
-- Posted by Matthew Sontum, modified by community. See post 'Timeline' for change history
-- Retrieved 2025-12-15, License - CC BY-SA 3.0

--Test Set 1
DECLARE @InputList NumberSet
INSERT @InputList VALUES (153,50,9,6,3,4,2) --Solution = (3*50)+(6/2)
EXEC dbo.pr_CatsSolution @InputList

----Test Set 2
--DECLARE @InputList2 NumberSet
--INSERT @InputList2 VALUES (154,50,9,6,3,4,2) --Solution = (3*50)+(6/2)
--EXEC dbo.pr_CatsSolution @InputList2

----Test Set 3
--DECLARE @InputList3 NumberSet
--INSERT @InputList3 VALUES (155,50,9,6,3,4,2) --Solution = (3*50)+(6/2)
--EXEC dbo.pr_CatsSolution @InputList3