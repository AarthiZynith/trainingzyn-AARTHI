page 50207 SubscriptionListPage
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer Subscription";
    Editable=false;
    InsertAllowed=true;
   // ModifyAllowed=true;
    CardPageId=SubscriptionCardPage;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Subscription ID";Rec."Subscription ID")
                {
                    ApplicationArea=All;
                }
                field("Customer ID";Rec."Customer ID"){ApplicationArea=All;}
                field("Plan ID";Rec."Plan ID"){ApplicationArea=All;}
                field("Start Date";Rec."Start Date"){ApplicationArea=All;}
                field("End Date";Rec."End Date"){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
                field("Next Bill Date";Rec."Next Bill Date"){ApplicationArea=All;}
            }
        }
    }
    
   
}