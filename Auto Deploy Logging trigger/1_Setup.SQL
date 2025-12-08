USE MASTER
GO

IF EXISTS (
        SELECT name
        FROM sys.databases
        WHERE name = 'DemoLoggingTriggerDeploy'
        )
BEGIN
    --ALTER DATABASE DemoLoggingTriggerDeploy SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DemoLoggingTriggerDeploy;
END;

CREATE DATABASE DemoLoggingTriggerDeploy;
GO

USE DemoLoggingTriggerDeploy;
GO

--Create trigger config table
--Create log output table
--Create demo "normal" tables
