--Publish comment storeprocedure
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[PublishComment]'))
    DROP PROCEDURE PublishComment;
GO

CREATE PROCEDURE PublishComment
	@user_id int,
	@post_id int,
	@comment text
AS
BEGIN
	insert into [4888_comments] (user_id, post_id, comment)
	values
		(@user_id, @post_id, @comment)
END

EXEC dbo.PublishComment 2, 2, 'Recently ABG has accquired rebook';


--Update comment storedprocedue
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[UpdateComment]'))
    DROP PROCEDURE UpdateComment;
GO

CREATE PROCEDURE UpdateComment
	@user_id int,
	@comment_id int,
	@updated_comment text
AS
BEGIN
	declare @original_user_id as int
	
	SET @original_user_id = (
		select user_id
		from [4888_comments]
		where comment_id = @comment_id 
	);

	if (@original_user_id = @user_id)
	BEGIN
		update [4888_comments]
		set comment = @updated_comment
		where comment_id = @comment_id
		
		select 'Comment updated' as message
	END
	else
	BEGIN
		select 'You are not authorized to edit this comment' as message
	END
END

EXEC dbo.UpdateComment 2, 6, 'Recently, ABG has accquired rebook from Adidas';

--Update comment storedprocedue
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[DeleteComment]'))
    DROP PROCEDURE DeleteComment;
GO

CREATE PROCEDURE DeleteComment
	@user_id int,
	@comment_id int
AS
BEGIN
	declare @original_user_id as int
	
	SET @original_user_id = (
		select user_id
		from [4888_comments]
		where comment_id = @comment_id 
	);

	if (@original_user_id = @user_id)
	BEGIN
		delete
		from [4888_comments]
		where comment_id = @comment_id
		
		select 'Comment deleted' as message
	END
	else
	BEGIN
		select 'You are not authorized to delete this comment' as message
	END
END

EXEC dbo.DeleteComment 2, 4;
