page 50164 EmployeeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = EmployeeTable;
    CardPageId = EmployeeCard;
    InsertAllowed=false;
    ModifyAllowed=false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EmployeeID; Rec.EmployeeID)
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(EmployeeRole; Rec.EmployeeRole) { ApplicationArea = all; }
                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LeaveRequest)
            {
                ApplicationArea=All;
                image=Camera;

               RunObject=page leaveRequestList;
            }
        }
    }

    
}