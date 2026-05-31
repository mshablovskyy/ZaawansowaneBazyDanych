CREATE TABLE [Student_1].[ExamResult] (
    [ResultID]     INT            IDENTITY (1, 1) NOT NULL,
    [StudentIndex] INT            NOT NULL,
    [StudentName]  NVARCHAR (50)  NOT NULL,
    [SubjectName]  NVARCHAR (50)  NOT NULL,
    [Score]        DECIMAL (5, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([ResultID] ASC)
);
GO

