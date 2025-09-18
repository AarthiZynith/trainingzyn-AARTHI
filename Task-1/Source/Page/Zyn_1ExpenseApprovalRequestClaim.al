page 50238 Zyn_ExpenseApprovalRequest
{
    PageType = List;
    SourceTable = Zyn_ExpenseClaimTable;
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    Editable = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ClaimID; rec.ClaimID)
                {
                    ApplicationArea = All;
                }
                field(EmployeeID; Rec.EmployeeID)
                {
                    ApplicationArea = All;
                }
                field(ClaimCategory; Rec.ClaimCategory)
                {
                    ApplicationArea = All;
                }
                field(ClaimDate; Rec.ClaimDate)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Billdate; Rec.Billdate)
                {
                    ApplicationArea = All;
                }
                field(BillFileName; Rec.BillFileName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ApproveClaimAction)
            {
                Caption = 'Approve Claim';
                Image = Approve;
                trigger OnAction()
                begin
                    Rec.ApproveClaim();
                end;
            }

            action(RejectClaimAction)
            {
                Caption = 'Reject Claim';
                Image = Reject;
                trigger OnAction()
                begin
                    Rec.RejectClaim();
                end;
            }

            action(CancelClaimAction)
            {
                Caption = 'Cancel Claim';
                Image = Cancel;
                trigger OnAction()
                begin
                    Rec.CancelClaim();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::PendingApproval);
    end;

     trigger OnAfterGetRecord()
     begin
                Rec.GetUtilizedAmount();
            end;
}
