page 50171 leaveRequestList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LeaveRequestTable;
    CardPageId = leaveRequestCard;
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
                    ApplicationArea = All;

                }
                field(EmployeeName; Rec.EmployeeID) { ApplicationArea = All; }
                field(leaveCategory; Rec.leaveCategory) { ApplicationArea = All; }
                Field(Reason; Rec.Reason) { ApplicationArea = All; }
                field(StartDate; Rec.StartDate) { ApplicationArea = All; }
                field(EndDate; Rec.EndDate) { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field(RemainingLeaves;Rec.RemainingLeaves){
                    ApplicationArea=All;
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