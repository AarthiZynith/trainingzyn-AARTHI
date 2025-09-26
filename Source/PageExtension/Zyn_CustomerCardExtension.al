pageextension 50102 Zyn_CustomerCardExte extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Allowed Credit"; Rec."Allowed Credit")
            {
                ApplicationArea = All;
            }
            field("Credit Used"; Rec."Credit Used")
            {
                ApplicationArea = All;
            }
            field("Loyalty Points"; rec."Loyalty Points")
            {
                ApplicationArea = All;
            }

        }

        addlast(factboxes)
        {
            part(CustomerStats; Zyn_CustomerStatsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }

    }

    actions
    {
        addlast(Processing)
        {
            action(ViewModifyLog)
            {
                Caption = 'View Modify Log';
                ApplicationArea = All;
                Image = History;

                trigger OnAction()
                var
                    ChangeLogEntry: Record Zyn_CustomerModifyLog;
                begin
                    // ✅ Manually filter by table and customer number
                    ChangeLogEntry.SetRange("Customer No.", Rec."No.");

                    PAGE.RunModal(PAGE::Zyn_CustomerModifyLogList, ChangeLogEntry);
                end;
            }

            action(TechnicianProblem)
            {
                RunObject = page Zyn_TechnicianProblemListPart;
                ApplicationArea = All;
                Caption = 'TechnicianProblemPage';
                image = Camera;
                RunPageLink = "Customer No." = field("No.");
            }

        }

    }
}