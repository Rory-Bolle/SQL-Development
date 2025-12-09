# Automatic deploy of SQL logging trigger for table changes
This folder will show you how I develop once and then am able to deploy the same trigger to new tables by just executing the proc...

### Instructions ###
Run 1_Setup.sql on any open SQL Server instance.

### Explanation/Walkthrough ###
The Above will create a new database add add a few tables (namely tb_bob which we are wanting to log activity)
Then the proc is executed with tb_bob as an input and the proc creates a trigger on tb_bob.
From then on any changes made on tb_bob Inserts updates etc... will populate the logging table dbo.tb_LoggedValues

Youtube link? Still to come/be created...