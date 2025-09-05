pageextension 50133 "Customer List Extension" extends "Customer List"
{

    layout
    {
        addlast(factboxes)
        {
        
            
             part(CustomerStats; "Customer Stats FactBox")
                {
                    ApplicationArea = All;
                    SubPageLink = "No." = field("No.");
                }
                part(ActiveSubscriptionstatus;SubscriptionFactbox){
                    ApplicationArea=All;
                    //SubPageLink="No."=field("No.");
                }
            }
        }


        
    actions
    {
        addlast(processing)
        {
            action(Empty)
            {
                ApplicationArea = All;
                Image = Report;
                RunObject = report AmountReplaced;
            }
        }
    }
    }

