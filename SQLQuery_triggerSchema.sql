create database Assignment05Db
use Assignment05Db

drop table bank.Customer

create schema bank
create table bank.Customer
(
CId int primary key identity(1000,1),
CName nvarchar(50) not null,
CEmail nvarchar(50) not null unique,
Contact nvarchar(10) not null unique,
CPwd as RIGHT(CName,2)+convert(nvarchar(50),CId)+LEFT(Contact,2) persisted
)

create table bank.MailInfo
(
MailTo nvarchar(50),
MailDate date,
MailMessage nvarchar(50)
)

select * from bank.Customer
select * from bank.MailInfo

create trigger trgMailtoCust
ON bank.Customer
after insert
AS
begin
declare @cid int
declare @cname nvarchar(50)
declare @cemail nvarchar(50)
declare @contact nvarchar(10)
declare @cpwd nvarchar(50)
declare @message nvarchar(100)
select @cid = CId, @cname=CName, @cemail=CEmail,@contact=Contact,
@cpwd=(RIGHT(CName,2)+convert(nvarchar(50),CId)+LEFT(Contact,2)) from inserted
select @message='Your net banking password is: '+@cpwd+' It is valid upto 2days only. Update it.' 

insert into bank.MailInfo values(@cemail,GETDATE(),@message)

if(@@ROWCOUNT>=1)
begin
print 'Inserted succesfully'
end
end

insert into bank.Customer(CName,CEmail,Contact) values ('Sam','Sam@gmail.com','9876789876')
insert into bank.Customer(CName,CEmail,Contact) values ('Ravi','ravi@gmail.com','9876542246')
insert into bank.Customer(CName,CEmail,Contact) values ('Ankit','ankit@gmail.com','9987656780')
insert into bank.Customer(CName,CEmail,Contact) values ('Arsh','arsh@gmail.com','9876787612')
insert into bank.Customer(CName,CEmail,Contact) values ('Deep','deep@gmail.com','9876789098')

select * from bank.Customer
select * from bank.MailInfo