CREATE   VIEW v_DoubleView AS
SELECT Student_1.MyLogicView.CustomerID, Student_1.MyLogicView.FirstName, Student_1.MyLogicView.LastName, Student_1.MyLogicView.OrderDate, SalesLT.CustomerComplaint.ComplaintID, SalesLT.CustomerComplaint.Description
FROM Student_1.MyLogicView LEFT JOIN SalesLT.CustomerComplaint ON Student_1.MyLogicView.CustomerID = SalesLT.CustomerComplaint.CustomerID;
GO

