page 50101 IndexLIstPage
{
    PageType = List;
    SourceTable = index;
    ApplicationArea = All;
    UsageCategory = Lists; 
    CardPageId=IndexcardPage;
    ModifyAllowed=false;
    InsertAllowed=false;
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field(code; Rec.code)
                {
                    ApplicationArea = All;
                }
                field(description; Rec.description)
                { ApplicationArea = All; }
                field(PercentageIncrease; Rec.PercentageIncrease)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}