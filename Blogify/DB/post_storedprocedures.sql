
--Publish post storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[PublishPost]'))
    DROP PROCEDURE PublishPost;
GO

CREATE PROCEDURE PublishPost
	@user_id int,
	@category_id int,
	@title varchar(70),
	@content text
AS
BEGIN
	insert into [4888_posts] (user_id, category_id, title, content)
	values
		(@user_id, @category_id, @title, @content)
END

EXEC dbo.PublishPost 2, 2, 'Rebook', 'Rebook was acquired by Adidas.';

--Update post storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[UpdatePost]'))
    DROP PROCEDURE UpdatePost;
GO

CREATE PROCEDURE UpdatePost
	@user_id int,
	@post_id int,
	@category_id int,
	@title varchar(70),
	@content text
AS
BEGIN
	if exists(select 1 from [4888_posts]
	where post_id = @post_id and user_id = @user_id)
	BEGIN
		update [4888_posts]
		set 
			title = @title,
			content = @content,
			category_id = @category_id
		where
			post_id = @post_id
		select 'Post updated' as message
	END
	else
	BEGIN
		select 'You are not authorize to updated this post' as message
	END
END

EXEC dbo.UpdatePost 2, 1003, 2, 'H&M', 'H&M is launching new denim pants.';

--Delete post storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[DeletePost]'))
    DROP PROCEDURE DeletePost;
GO

CREATE PROCEDURE DeletePost
	@user_id int,
	@post_id int
AS
BEGIN
	if exists(select 1 from [4888_posts]
	where post_id = @post_id and user_id = @user_id)
	BEGIN
		delete from [4888_posts]
		where post_id = @post_id;
		select 'Post deleted' as message
	END
	else
	BEGIN
		select 'You are not authorize to delete this post' as message
	END
END

EXEC dbo.DeletePost 2, 1004;

--Read post storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ReadPost]'))
    DROP PROCEDURE ReadPost;
GO

CREATE PROCEDURE ReadPost
AS
BEGIN
	select
		[4888_posts].post_id,
		[4888_users].username as author,
		title,
		content,
		publication_date,
		[4888_categories].category_name as category,
		[4888_comments].comment as comment,
		[4888_comments].comment_time as comment_time
	from [4888_posts]
	--Getting names from user table coresponding to the user id in posts table
	inner join [4888_users] on [4888_posts].user_id = [4888_users].user_id
	left join [4888_categories] on [4888_posts].category_id = [4888_categories].category_id
	left join [4888_comments] on [4888_posts].post_id = [4888_comments].post_id
	order by [4888_posts].publication_date DESC, [4888_comments].comment_time DESC
END

EXEC dbo.ReadPost;


--Read post by category storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ReadPostbyCategory]'))
    DROP PROCEDURE ReadPostbyCategory;
GO

CREATE PROCEDURE ReadPostbyCategory
	@category_id int
AS
BEGIN
	select
		[4888_posts].post_id,
		[4888_users].username as author,
		title,
		content,
		publication_date,
		[4888_categories].category_name as category,
		[4888_comments].comment as comment,
		[4888_comments].user_id as commen_author,
		[4888_comments].comment_time as comment_time
	from [4888_posts]
	--Getting names from user table coresponding to the user id in posts table
	inner join [4888_users] on [4888_posts].user_id = [4888_users].user_id
	left join [4888_categories] on [4888_posts].category_id = [4888_categories].category_id
	left join [4888_comments] on [4888_posts].post_id = [4888_comments].post_id
	where [4888_categories].category_id = @category_id
	order by [4888_posts].publication_date DESC, [4888_comments].comment_time DESC
END

EXEC dbo.ReadPostbyCategory 12;

--Read post by user storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ReadPostbyUser]'))
    DROP PROCEDURE ReadPostbyUser;
GO

CREATE PROCEDURE ReadPostbyUser
	@user_id int
AS
BEGIN
	select
		[4888_posts].post_id,
		[4888_users].username as author,
		title,
		content,
		publication_date,
		[4888_categories].category_name as category,
		[4888_comments].comment as comment,
		[4888_comments].user_id as commen_author,
		[4888_comments].comment_time as comment_time
	from [4888_posts]
	--Getting names from user table coresponding to the user id in posts table
	inner join [4888_users] on [4888_posts].user_id = [4888_users].user_id
	left join [4888_categories] on [4888_posts].category_id = [4888_categories].category_id
	left join [4888_comments] on [4888_posts].post_id = [4888_comments].post_id
	where [4888_users].user_id = @user_id
	order by [4888_posts].publication_date DESC, [4888_comments].comment_time DESC
END

EXEC dbo.ReadPostbyCategory 3;