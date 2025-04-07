/* 
==========
create database and schema
==========
scipts pupose 
this scrips is used to create database and schemas( brown, silver, and gold).

warning
please back up your data before execute the script other wise yours would lose.
*/






use master;

create database datawarhouse;
use datawarhouse;
go


create schema bronze;
go
create schema silver;
go
create schema gold;
go
