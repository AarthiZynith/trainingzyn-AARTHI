page 50143 Zyn_TechnicianProblemListPart
{
    Caption='TechnicianProblemListPart';
    PageType = ListPart;
    SourceTable = Zyn_ProblemTable;
    AutoSplitKey = true;
    Editable = false;
    InsertAllowed = false;
    ApplicationArea=All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec."Customer No.")
                {
                    
                }
                field(Name; Rec."Customer Name")
                {
                   
                }
                field(Problem; Rec.Problem)
                {
                  
                }
                field(Description; Rec.Description)
                {
                   
                }
                field(Date; Rec.Date)
                {
                  
                }
            }
        }
    }
}
