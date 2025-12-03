--create tablespace
create tablespace tour_management
datafile 'C:\oracle\datafiles\TourData\tour_management.dbf'
size 5M
autoextend on next 1M maxsize 50M;
----------------------------------------------------------------------
-- check tablespace
select tablespace_name, status from dba_tablespaces;
select file_name, bytes/1024/1024 as size_MB
from dba_data_files
where tablespace_name = 'tour_management';
----------------------------------------------------------------------
--create admin user
create user tour_admin identified by pwd 
default tablespace tour_management
quota unlimited on tour_management;
--grant to admin
GRANT CREATE USER TO tour_admin;
GRANT ALTER USER TO tour_admin;
GRANT GRANT ANY PRIVILEGE TO tour_admin;
GRANT CREATE ROLE TO tour_admin;
GRANT ALTER ANY ROLE TO tour_admin;
GRANT GRANT ANY ROLE TO tour_admin;
GRANT RESTRICTED SESSION TO tour_admin;
GRANT CREATE TABLESPACE TO tour_admin;
GRANT ALTER TABLESPACE TO tour_admin;
GRANT DROP TABLESPACE TO tour_admin;
GRANT ALTER DATABASE TO tour_admin;
GRANT CREATE SESSION TO tour_admin;
GRANT CONNECT, RESOURCE TO tour_admin;
GRANT UNLIMITED TABLESPACE TO tour_admin;

-- Tạo người dùng nhân viên
create user user_employee001 identified by employee001 
default tablespace tour_management
quota unlimited on tour_management;
create user user_employee002 identified by employee002 
default tablespace tour_management
quota unlimited on tour_management;
-- Cấp quyền cho người dùng nhân viên
GRANT CREATE SESSION TO user_employee001;
GRANT CREATE TABLE TO user_employee001;
GRANT CREATE SESSION TO user_employee002;
GRANT CREATE TABLE TO user_employee002;

commit;