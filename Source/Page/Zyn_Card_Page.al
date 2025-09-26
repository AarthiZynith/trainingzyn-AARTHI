page 50137 Zyn_VisitLogCard
{
    Caption='VisitLogCard';
    PageType = Card;
    SourceTable = Zyn_VisitLog;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No."; rec."Customer No.")
                {

                }
                field("Visit Date"; rec."Visit Date")
                {

                }
                field("Purpose"; rec."Purpose")
                {

                }
                field("Notes"; rec."Notes")
                {

                }
            }
        }
    }
}
