table 50173 EmployeeLeave
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = LeaveRequestTable.EmployeeID;
        }
        field(2; CategoryName; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = LeaveRequestTable.leaveCategory;
        }
        field(3; RemainingLeave; Integer)
        {

            DataClassification = ToBeClassified;
        }

    }




    keys
    {
        key(PK; EmployeeID)
        {
            Clustered = true;
        }
    }



}