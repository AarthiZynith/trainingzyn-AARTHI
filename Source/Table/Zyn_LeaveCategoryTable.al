table 50166 Zyn_LeaveCategory
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CategoryName; Text[100])
        {
            Caption = 'CategoryName';
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "No of Days Allowed"; Integer)
        {
            Caption = 'No of Days Allowed';
            DataClassification = ToBeClassified;
        }
        field(4; EmployeeID; Integer)
        {
            Caption = 'EmployeeID';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_EmployeeTable.EmployeeID;
        }
        field(5; Status; Integer)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_LeaveRequest.Status;
        }
    }

    keys
    {
        key(PK; CategoryName)
        {
            Clustered = true;
        }
    }

}