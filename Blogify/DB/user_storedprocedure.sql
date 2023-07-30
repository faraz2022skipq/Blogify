IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[login_storeprocedure]'))
    DROP PROCEDURE login_storeprocedure;
GO

IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[update_password_storeprocedure]'))
    DROP PROCEDURE update_password_storeprocedure;
GO

IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[signup_storeprocedure]'))
    DROP PROCEDURE signup_storeprocedure;
GO

IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[delete_storeprocedure]'))
    DROP PROCEDURE delete_storeprocedure;
GO


--Sign up storeprocedure
CREATE PROCEDURE signup_storeprocedure
	@username varchar(50),
	@email varchar(70),
	@password varchar(100)
AS
BEGIN
	if exists(select * from [4888_users] 
	where username = @username and email = @email)
	BEGIN
		select 'Taken user name or email'
	END
	else
	BEGIN
		insert into [4888_users] (username, email, password)
			values (@username, @email, @password)
		select 'User signed up' as message
	END
END

EXEC dbo.signup_storeprocedure 'mfaraz', 'mfaraz@gmail.com', '12345';

--Login storeprocedure
CREATE PROCEDURE login_storeprocedure
	@username varchar(50),
	@password varchar(100)
AS
BEGIN
    if exists(select * from [4888_users]
	where username = @username and password = @password)
	BEGIN
	select username, email, joining_date 
		from [4888_users] 
		where username = @username and password = @password;

		select 'User logged in' as message
	END
	else
	BEGIN
		select 'Invalid user' as message
	END
END

EXEC dbo.login_storeprocedure 'faraz', '12345'; 


-- Update password storeprocedure
CREATE PROCEDURE update_password_storeprocedure
	@username varchar(50),
	@oldpassword varchar(100),
	@newpassword varchar(100)
AS
BEGIN
	if exists(select * from [4888_users] 
	where username = @username and password = @oldpassword)
	BEGIN
		update [4888_users]
		set password = @newpassword
		where username = @username and password = @oldpassword;

		select 'Password updated' as message;
	END
	else
	BEGIN
		select 'Wrong old password' as message;
	END
END

EXEC dbo.update_password_storeprocedure 'faraz', '122345', '12345';


--Delete storeprocedure
CREATE PROCEDURE delete_storeprocedure
	@username varchar(50),
	@password varchar(100)
AS
BEGIN
	if exists(select * from [4888_users] 
	where username = @username and password = @password)
	BEGIN
		delete from [4888_users]
		where username = @username and password = @password

		select 'User deleted' as message
	END
	else
	BEGIN
		select 'User does not exist' as message
	END
END

EXEC dbo.delete_storeprocedure 'mfaraz', '12345';
