page 50138 TechnicianListPage
{
    PageType = List;
    SourceTable = TechnicianTable;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("ID"; rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; rec."Name")
                {
                    ApplicationArea = All;
                }
                field("PhoneNo"; rec."Ph.No")
                {
                    ApplicationArea = All;
                }
                field("Dept"; Rec.Dept)
                {
                    ApplicationArea = All;
                }
                field("Problem Count"; Rec."Problem Count")
                {
                    ApplicationArea = All;


                }

            }

            part(TechnicianProblemSubpage; "Technician Problem Subpage")
            {
                SubPageLink = Technician = field(ID);
                ApplicationArea = All;
            }
        }
    }
}