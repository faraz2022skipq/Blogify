IF EXISTS (SELECT 1 FROM sys.tables WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[4888_users]'))
DROP TABLE [4888_users]

IF EXISTS (SELECT 1 FROM sys.tables WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[4888_posts]'))
DROP TABLE [4888_posts]

IF EXISTS (SELECT 1 FROM sys.tables WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[4888_categories]'))
DROP TABLE [4888_categories]




--Creating user table
BEGIN
	CREATE TABLE [4888_users] (
		user_id int primary key identity(1,1) NOT NULL,
		username varchar(50) NOT NULL unique,
		email varchar(70) NOT NULL unique,
		password varchar(100) NOT NULL,
		joining_date datetime default CURRENT_TIMESTAMP)
END

INSERT INTO [4888_users] (username, email, password)
VALUES
    ('Faraz', 'faraz@gmail.com', 12345),
    ('Khushnood', 'khushnood@gmail.com', 12345),
    ('Sufyan', 'sufyan@gmail.com', 12345);

SELECT * FROM [4888_users]

-- Creating category table
BEGIN
	CREATE TABLE [4888_categories] (
		category_id int primary key identity(1,1) NOT NULL,
		category_name varchar(100) NOT NULL unique)
END

INSERT INTO [4888_categories] (category_name)
VALUES
	('Tech'),
	('Fashion'),
	('Business');

SELECT * FROM [4888_categories]

--Creating posts table
BEGIN
	CREATE TABLE [4888_posts] (
		post_id int primary key identity(1,1) NOT NULL,
		category_id int,
		user_id int,
		title varchar(70) NOT NULL,
		content text NOT NULL,
		publication_date datetime default CURRENT_TIMESTAMP,
		foreign key(user_id) references [4888_users](user_id) on delete cascade,
		foreign key(category_id) references [4888_categories](category_id) on delete set NULL)
END

INSERT INTO [4888_posts] (user_id, category_id, title, content)
VALUES
	(1, 1, 'SpaceX', 'SpaceX is a technology company'),
	(2, 2, 'Nike', 'Nike is a fashion brand'),
	(3, 3, 'Banking', 'Banking ia a profitable business sector');

SELECT * FROM [4888_posts]

--Creating comments table
IF EXISTS (SELECT 1 FROM sys.tables WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[4888_comments]'))
DROP TABLE [4888_comments]


BEGIN
	CREATE TABLE [4888_comments] (
		comment_id int primary key identity(1,1) NOT NULL,
		user_id int,
		--username varchar(50),
		post_id int,
		comment text NOT NULL,
		comment_time datetime default CURRENT_TIMESTAMP,
		foreign key(post_id) references [4888_posts](post_id) on delete no action,
		foreign key(user_id) references [4888_users](user_id) on delete cascade)
END

INSERT INTO [4888_comments] (user_id, post_id, comment)
VALUES
	(1, 2, 'Good'),
	(2, 1, 'Excellent'),
	(3, 3, 'Outstanding'),
	(2, 1003, 'to delete');

SELECT * FROM [4888_comments]