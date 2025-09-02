report 50100 AmountReplaced
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("CustomerAmount"; Customer)
        {
            trigger OnPreDataItem()
            begin

                CustomerAmount.SetRange("Balance", MinBalance, 500);
                
            end;

        }
        //  column("Customer No."; "No.")
        // {
        // }
        // column("Customer Name"; Name)
        // {
        // }
        // column("City"; City)
        // {
        // }
        // column("Balance"; "Balance")
        // {
        // }
    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(filters)
                {
                    field("MinBalance"; MinBalance)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        MinBalance: Decimal;
}