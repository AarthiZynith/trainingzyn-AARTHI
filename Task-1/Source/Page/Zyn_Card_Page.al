page 50137 "Visit Log Card"
{
    PageType = Card;
    SourceTable = "Visit Log";
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No."; rec."Customer No.") { }
                field("Visit Date"; rec."Visit Date") { }
                field("Purpose"; rec."Purpose") { }
                field("Notes"; rec."Notes") { }
            }
        }
    }
}
