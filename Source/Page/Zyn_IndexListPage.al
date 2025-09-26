page 50101 Zyn_IndexList
{
    Caption='IndexList';
    PageType = List;
    SourceTable = Zyn_Index;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = Zyn_Indexcard;
    ModifyAllowed = false;
    InsertAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field(code; Rec.code)
                {
                    
                }
                field(description; Rec.description)
                {

                }
                field(PercentageIncrease; Rec.PercentageIncrease)
                {
                    
                }

            }
        }
    }
}