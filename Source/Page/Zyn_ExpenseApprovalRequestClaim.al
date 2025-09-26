page 50238 Zyn_ExpenseApprovalRequest
{
    Caption = 'ExpenseApprovalRequest';
    PageType = List;
    SourceTable = Zyn_ExpenseClaim;
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

                }
                field(EmployeeID; Rec.EmployeeID)
                {

                }
                field(ClaimCategory; Rec.ClaimCategory)
                {

                }
                field(ClaimDate; Rec.ClaimDate)
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Billdate; Rec.Billdate)
                {

                }
                field(BillFileName; Rec.BillFileName)
                {

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
