page 50139 TechnicianProblemPage
{
    PageType = Card;
    SourceTable = ProblemTable;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(group)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }

                field(Problem; rec."Problem")
                {
                    ApplicationArea = All;

                }
                field(Dept; rec."Dept")
                {
                    ApplicationArea = All;

                }
                field(Technician; rec.Technician)
                {
                    ApplicationArea = All;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;

                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
            }




        }
    }



}