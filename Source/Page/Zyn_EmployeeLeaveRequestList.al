page 50171 Zyn_leaveRequestList
{
    Caption = 'LeaveRequestList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_LeaveRequest;
    CardPageId = Zyn_leaveRequestCard;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(RequestId; Rec.RequestId)
                {

                }
                field(EmployeeName; Rec.EmployeeID)
                {

                }
                field(leaveCategory; Rec.leaveCategory)
                {

                }
                Field(Reason; Rec.Reason)
                {

                }
                field(StartDate; Rec.StartDate)
                {

                }
                field(EndDate; Rec.EndDate)
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(RemainingLeaves; Rec.RemainingLeaves)
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error('Only Pending requests can be approved.');

                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error('Only Pending requests can be rejected.');

                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.GetRemainingDays();
    end;


}