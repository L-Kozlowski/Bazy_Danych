CREATE or ALTER FUNCTION Fibonacci(@limit int)
RETURNS @numbers TABLE(number int)
AS
BEGIN
	Declare @a int = 0;
	Declare @b int =1;
	Declare @i int=0;

	Insert Into @numbers Values(@a),(@b)
	WHILE (@i<=@limit-2)
	BEGIN 
		Insert Into @numbers Values(@b+@a)
		Set @b = @b + @a --pod zmienn¹ b przypisujemy wyraz nastêpny czyli a+b
		Set @a = @b - @a --pod zmienn¹ a przypisujemy wartoœæ zmiennej b
		Set @i += 1
	END	
	RETURN 
END

CREATE or ALTER PROCEDURE select_fibo(@n int)
AS 
BEGIN
	Select * from dbo.Fibonacci(@n)
END

EXECUTE select_fibo 7