USE MASTER
GO

IF EXISTS (
        SELECT name
        FROM sys.databases
        WHERE name = 'DemoLoggingTriggerDeploy'
        )
BEGIN
    ALTER DATABASE DemoLoggingTriggerDeploy

    SET SINGLE_USER
    WITH

    ROLLBACK IMMEDIATE;

    DROP DATABASE DemoLoggingTriggerDeploy;
END;

CREATE DATABASE DemoLoggingTriggerDeploy;
GO

USE DemoLoggingTriggerDeploy;
GO

----Create table for Trigger config
--IF OBJECT_ID(N'dbo.tb_LogTriggerConfig', N'U') IS NULL
--BEGIN
--    CREATE TABLE dbo.tb_LogTriggerConfig (
--        ID INT identity(1, 1)
--        ,TableName sysname
--        )
--END;
--Create log output table
IF OBJECT_ID(N'dbo.tb_LoggedValues', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tb_LoggedValues (
        ID BIGINT identity(1, 1)
        ,[DateTime] DATETIME2(7) DEFAULT GetUtcDate()
        ,Operation CHAR(1) NOT NULL
        ,ColumnValues NVARCHAR(max) NULL
        )
END;

--Create demo "normal" tables
IF OBJECT_ID(N'dbo.tb_Bob', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.tb_Bob (
        ID BIGINT identity(1, 1)
        ,Firstname NVARCHAR(20) NULL
        ,Lastname NVARCHAR(20) NULL
        )
END;
GO

--Create a proc to create a trigger
CREATE
    OR

ALTER PROCEDURE dbo.pr_CreateLoggingTrigger (
    @schemaname SYSNAME
    ,@TableName SYSNAME
    )
AS
BEGIN
    DECLARE @SQLString NVARCHAR(max) = N'
        Create or alter trigger dbo.tr_loggingTrigger on ' + @schemaName + '.' + @tablename + 
        ' 
        FOR INSERT, UPDATE, DELETE
        AS
            BEGIN
            Declare @Inserted bit
            Declare @deleted bit
            Declare @Operation char(1)
            Declare @ColumnValues nvarchar(max)
            Select @Inserted = count(1) from inserted
            Select @deleted = count(1) from deleted

            Select @Operation = Case 
                When @Inserted > 0 and @deleted > 0 THEN ''U''
                When @Inserted > 0 and @deleted = 0 THEN ''I''
                When @Inserted = 0 and @deleted > 0 THEN ''D''
                Else ''E''
                END
            END

            set @ColumnValues = (Select * from (
            Select @Operation[Operation],* from inserted 
            Union All
            Select @Operation[Operation],* from deleted 
            )as data for JSON PATH)

            Insert into dbo.tb_LoggedValues (Operation,ColumnValues) VALUES (@Operation,@columnValues)
        '

    EXECUTE sp_executesql @SQLString
END
GO

EXEC dbo.pr_CreateLoggingTrigger @schemaname = 'dbo'
    ,@tablename = 'tb_bob'
GO

sp_helptrigger 'dbo.tb_bob'
GO

INSERT INTO dbo.tb_bob (
    Firstname
    ,Lastname
    )
VALUES (
    'Ronald'
    ,'Raegan'
    )

UPDATE dbo.tb_bob
SET Firstname = 'RonaldS'

DELETE TOP (1)
FROM dbo.tb_bob

SELECT *
FROM dbo.tb_LoggedValues
