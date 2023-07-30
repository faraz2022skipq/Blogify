IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[set_new_category]'))
    DROP PROCEDURE set_new_category;
GO

--Sign up storeprocedure
CREATE PROCEDURE set_new_category
	@category_name varchar(100)
AS
BEGIN
	declare @count as int

	SET @count = (
		select count(*)
		from [4888_categories]
		where  category_name = @category_name
	);

	if @count = 0
	BEGIN
	insert into [4888_categories] (category_name)
		values (@category_name)
		select 'Category added' as message
	END
	else
	BEGIN
		SELECT 'Already exists' as message
	END
END

EXEC dbo.set_new_category 'Agriculture';

--Get all caterories
IF EXISTS (SELECT 1 FROM sys.procedures WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[GetCategories]'))
    DROP PROCEDURE GetCategories;
GO

--Sign up storeprocedure
CREATE PROCEDURE GetCategories
AS
BEGIN
	select category_name
	from [4888_categories]
END

EXEC dbo.GetCategories;