page 50164 Zyn_EmployeeList
{
    Caption='EmployeeList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_EmployeeTable;
    CardPageId = Zyn_EmployeeCard;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EmployeeID; Rec.EmployeeID)
                {
                    
                }
                field(Name; Rec.Name)
                {

                }
                field(EmployeeRole; Rec.EmployeeRole)
                {
                    
                }
                field(Department; Rec.Department)
                {
                    
                }
            }
        }

        area(FactBoxes)
        {
            part("AssetHistory"; Zyn_AssetHistoryFactBox)
            {
                ApplicationArea = All;
                SubPageLink = EmployeeID = field(EmployeeID);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LeaveRequest)
            {
                ApplicationArea = All;
                image = Camera;
                RunObject = page Zyn_leaveRequestList;
            }
        }
    }

}