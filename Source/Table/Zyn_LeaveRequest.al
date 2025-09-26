table 50168 Zyn_LeaveRequest
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; RequestId; Integer)
        {
            Caption = 'RequestId';
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; EmployeeID; Integer)
        {
            Caption = 'EmployeeID';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_EmployeeTable.EmployeeID;

        }
        field(3; leaveCategory; text[100])
        {
            Caption = 'leaveCategory';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_LeaveCategory.CategoryName;
            trigger OnValidate()
            begin
                GetRemainingDays();
            end;
        }
        field(4; Reason; Text[100])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;
        }
        field(5; StartDate; Date)
        {
            Caption = 'StartDate';
            DataClassification = ToBeClassified;

        }
        field(6; EndDate; date)
        {
            Caption = 'EndDate';
            DataClassification = ToBeClassified;

        }
        field(7; Status; enum Zyn_Status)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if rec.Status = rec.Status::Approved then
                    GetRemainingDays();
            end;
        }
        field(8; RemainingLeaves; Integer)
        {
            Caption = 'RemainingLeaves';
            DataClassification = ToBeClassified;

        }
        field(9; TotalDays; Integer)
        {
            Caption = 'TotalDays';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; RequestId, EmployeeID)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Status := Status::Pending;
    end;

    trigger OnDelete()
    begin
        if Status <> Status::Pending then
            Error('You can only delete leave requests with status Pending.');
    end;

    procedure GetRemainingDays()
    var
        LeaveCat: Record Zyn_LeaveCategory;
        LeaveRequest: Record Zyn_LeaveRequest;
        UsedDays: Integer;
    begin
        if LeaveCat.Get(leaveCategory) then begin
            UsedDays := 0;
            LeaveRequest.Reset();
            LeaveRequest.SetRange(EmployeeID, EmployeeID);
            LeaveRequest.SetRange(leaveCategory, leaveCategory);
            LeaveRequest.SetRange(Status, LeaveRequest.Status::Approved);
            if LeaveRequest.FindSet() then
                repeat
                    UsedDays += (LeaveRequest.EndDate - LeaveRequest.StartDate + 1);
                until LeaveRequest.Next() = 0;
            RemainingLeaves := LeaveCat."No of Days Allowed" - UsedDays;
        end
        else
            RemainingLeaves := 0;
    end;
}
