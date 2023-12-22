CREATE TABLE [Date_DIM](
	[Date_key] int NOT NULL,
	[Date] date NULL,
	[Month] char(10) NULL,
    [Year] smallint NULL,
    [Month_num] smallint NULL,
    [Week_num] smallint NULL,
    [Week_day] char(10) NULL,
    [Week_day_num] smallint NULL,
	PRIMARY KEY ([Date_key])
);

DECLARE @start DATE = '2023-01-01'
DECLARE @end DATE = '2100-01-01'
WHILE @start <= @end
BEGIN
INSERT INTO [dbo].[Date_DIM]([Date_key], [Date],[Month], [Year], [Month_num], [Week_num], [Week_day], [Week_day_num])
SELECT DATEPART(YY, @start)*10000+DATEPART(mm, @start)*100+DATEPART(dd, @start) AS [Date_key],
		@start AS [Date],
		SUBSTRING(DATENAME(mm, @start), 1, 3) as [Month],
		DATEPART(YY, @start) AS [Year],
		DATEPART(mm, @start) AS [Month_num],
		DATEPART(ww, @start) AS [Weeknum],
		DATENAME(dw, @start) AS [Week_day],
    	DATEPART(dw, @start) AS [Week_day_num]
	SET @start = DATEADD(dd, 1, @start)
END
SELECT * FROM Date_DIM