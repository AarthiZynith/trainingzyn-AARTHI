page 50172 leaveRequestCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LeaveRequestTable;
    
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(RequestId;Rec.RequestId)
                {
                    ApplicationArea=All;
                }
                field(EmployeeID;Rec.EmployeeID){ApplicationArea=All;}
                field(leaveCategory;Rec.leaveCategory){ApplicationArea=All;}
                Field(Reason;Rec.Reason){ApplicationArea=All;}
                field(StartDate;Rec.StartDate){ApplicationArea=All;}
                field(EndDate;Rec.EndDate){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
                
                field(RemainingLeaves;Rec.RemainingLeaves){
                    ApplicationArea=All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.GetRemainingDays();
    end;
    
    
}