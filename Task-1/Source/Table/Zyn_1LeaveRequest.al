table 50168 LeaveRequestTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; RequestId; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; EmployeeID; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = EmployeeTable.EmployeeID;

        }
        field(3; leaveCategory; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = LeaveCategoryTable.CategoryName;
            trigger OnValidate()
            begin
                GetRemainingDays();
            end;
        }
        field(4; Reason; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; StartDate; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     CalcTotalDays();
            // end;
        }
        field(6; EndDate; date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     CalcTotalDays();
            // end;
        }
        field(7; Status; enum Status)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if rec.Status=rec.Status::Approved then 
                GetRemainingDays();
            end;
        }
        // field(8; DaysTaken; Integer)
        // {
        //     CalcFormula = count of days between StartDate and EndDate + 1;
        // }

        field(8; RemainingLeaves; Integer)
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = Lookup(EmployeeLeave.RemainingLeave
            //                     WHERE(EmployeeID = FIELD(EmployeeID),
            //                           CategoryName = FIELD(leaveCategory)));

        }
        field(9; TotalDays; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false; // user cannot change, only calculated
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
        //if Status = 0 then  // enum default = first value in the list
        Status := Status::Pending;
    end;

    trigger OnDelete()
    begin
        if Status <> Status::Pending then
            Error('You can only delete leave requests with status Pending.');
    end;

    // local procedure CalcTotalDays()
    // begin
    //     if (StartDate <> 0D) and (EndDate <> 0D) then
    //         TotalDays := (EndDate - StartDate) + 1
    //     else
    //         TotalDays := 0;
    // end;


    // local procedure GetRemainingLeaves(): Integer
    // var
    //     EmpLeave: Record EmployeeLeave;
    // begin
    //     if EmpLeave.Get(EmployeeID, leaveCategory) then
    //         exit(EmpLeave.RemainingLeave - TotalDays);

    //     exit(0);
    // end;


    procedure GetRemainingDays()
    var
        LeaveCat: Record LeaveCategoryTable;
        LeaveRequest: Record LeaveRequestTable;
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

    // trigger OnModify()
    // var
    //     EmpLeave: Record EmployeeLeave;
    // begin
    //     if (Status = Status::Approved) then begin
    //         if EmpLeave.Get(EmployeeID, leaveCategory) then begin
    //             EmpLeave.RemainingLeave := GetRemainingLeaves();
    //             EmpLeave.Modify();
    //         end;
    //     end;
    // end;

}
