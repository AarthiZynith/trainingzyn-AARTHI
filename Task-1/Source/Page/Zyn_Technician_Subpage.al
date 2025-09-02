page 50143 "Technician Problem Subpage"
{
    PageType = ListPart;
    SourceTable = "ProblemTable";
    AutoSplitKey = true;
    Editable=false;
    InsertAllowed=false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec."Customer No.") { ApplicationArea = All; }
                field(Name; Rec."Customer Name") { ApplicationArea = All; }
                field(Problem; Rec.Problem) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }
            }
        }
    }



}
