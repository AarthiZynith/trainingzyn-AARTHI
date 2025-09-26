table 50173 Zyn_EmployeeLeave
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            Caption = 'EmployeeID';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_LeaveRequest.EmployeeID;
        }
        field(2; CategoryName; Text[100])
        {
            Caption = 'CategoryName';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_LeaveRequest.leaveCategory;
        }
        field(3; RemainingLeave; Integer)
        {
            Caption = 'RemainingLeave';
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