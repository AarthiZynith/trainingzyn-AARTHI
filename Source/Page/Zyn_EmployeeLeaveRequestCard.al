page 50172 Zyn_leaveRequestCard
{
    Caption = 'LeaveRequestCard';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Zyn_LeaveRequest;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(RequestId; Rec.RequestId)
                {

                }
                field(EmployeeID; Rec.EmployeeID)
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

    trigger OnAfterGetRecord()
    begin
        rec.GetRemainingDays();
    end;


}