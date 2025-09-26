page 50139 Zyn_TechnicianProblemCard
{
    Caption='TechnicianProblemCard';
    PageType = Card;
    SourceTable = Zyn_ProblemTable;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                   
                }
                field("Customer No."; rec."Customer No.")
                {

                }
                field("Customer Name"; rec."Customer Name")
                {
                   
                }
                field(Problem; rec."Problem")
                {
                    
                }
                field(Dept; rec."Dept")
                {

                }
                field(Technician; rec.Technician)
                {
                   
                }
                field(Description; rec.Description)
                {

                }
                field(Date; rec.Date)
                {
                   
                }
            }
        }
    }
}