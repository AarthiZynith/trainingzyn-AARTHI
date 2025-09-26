page 50165 Zyn_EmployeeCard
{
    Caption = 'EmployeeCard';
    PageType = card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_EmployeeTable;

    layout
    {
        area(Content)
        {
            group(GroupName)
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
    }
}