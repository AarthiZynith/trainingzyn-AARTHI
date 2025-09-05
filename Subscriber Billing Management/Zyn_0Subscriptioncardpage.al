page 50208 SubscriptionCardPage
{
    PageType = card;
    ApplicationArea = All;
   // UsageCategory = Administration;
    SourceTable = "Customer Subscription";
    
    layout
    {
        area(Content)
        {
            group(General)
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
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}