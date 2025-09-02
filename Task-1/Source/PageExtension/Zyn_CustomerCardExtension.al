pageextension 50102 CustomerCardExte extends "Customer Card"
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





            // field("Sales Year"; Rec."Sales Year")
            //     {
            //         ApplicationArea = All;
            //         //ToolTip = 'Enter a date range to filter sales, e.g. 01/07/2025..31/07/2025';
            //     }
            //     field("Sales Amount"; Rec."Sales Amount")
            //     {
            //         ApplicationArea = All;
            //         //ToolTip = 'Shows total sales amount for the given Sales Year range';
            //         Editable = false;
            //     }
        }

addlast(factboxes)
        {
            part(CustomerStats; "Customer Stats FactBox")
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
                    ChangeLogEntry: Record "Customer Modify Log";
                begin
                    // ✅ Manually filter by table and customer number
                    ChangeLogEntry.SetRange("Customer No.", Rec."No.");

                    PAGE.RunModal(PAGE::"Customer Modify Log List", ChangeLogEntry);
                end;
            }

            action(TechnicianProblem){
                RunObject=page TechnicianProblemPage;
                ApplicationArea=All;
                Caption='TechnicianProblemPage';
                image=Camera;
                RunPageLink="Customer No."=field("No.");
            }

        }



     

    }


    // trigger OnModifyRecord(): Boolean
    // begin
    //     if Rec."Credit Used" > Rec."Allowed Credit" then
    //         Error('Credit Used exceeds the Allowed Credit limit.');
    // end;



}