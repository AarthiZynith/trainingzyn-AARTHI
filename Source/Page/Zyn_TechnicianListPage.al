page 50138 Zyn_TechnicianList
{
    Caption = 'TechnicianList';
    PageType = List;
    SourceTable = Zyn_TechnicianTable;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("ID"; rec."ID")
                {
                    
                }
                field("Name"; rec."Name")
                {
                  
                }
                field("PhoneNo"; rec."Ph.No")
                {
                    
                }
                field("Dept"; Rec.Dept)
                {
                   
                }
                field("Problem Count"; Rec."Problem Count")
                {
                    
                }
            }

            part(TechnicianProblemSubpage; Zyn_TechnicianProblemListPart)
            {
                SubPageLink = Technician = field(ID);
                ApplicationArea = All;
            }
        }
    }
}