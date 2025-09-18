page 50165 EmployeeCard
{
    PageType = card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = EmployeeTable;

    layout
    {
        area(Content)
        {
            group(GroupName)
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

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    // var
    //     myInt: Integer;
}