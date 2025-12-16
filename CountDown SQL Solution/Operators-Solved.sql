USE DemoCountDownSQLSolution
GO
--Create table tb_number1 (constant INT)
--Create Table tb_operator ([sign] tinyint)
--Create table tb_number2 (constant INT)
--Create table tb_number3 (constant INT)
--Create table tb_number4 (constant INT)
--Create table tb_number5 (constant INT)
--Create table tb_number6 (constant INT)
Go
--Insert into tb_number1 values (1)
--Insert into tb_operator values (0),(1),(2),(3)
--Insert into tb_number2 values (1)
--Insert into tb_number3 values (1)
--Insert into tb_number4 values (1)
--Insert into tb_number5 values (1)
--Insert into tb_number6 values (1)
GO

Select * from tb_number1 [num1] join tb_operator [op1] on 1=1 --4
				join tb_number2 [num2] on 1=1 join tb_operator [op2] on 1=1 --16
				join tb_number3 [num3] on 1=1 join tb_operator [op3] on 1=1 --64
				join tb_number4 [num4] on 1=1 join tb_operator [op4] on 1=1 --256
				join tb_number5 [num5] on 1=1 join tb_operator [op5] on 1=1 --1024
				join tb_number6 [num6] on 1=1 --1024

--Next step is to figure out how many unique data sets we have (order is important!)