page 50187 Zyn_AssetTypeCard
{
    Caption = 'AssetTypeCard';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_AssetType;

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(EntryNo; Rec.AssetID)
                {
                   
                }
                field(Category; Rec.Category)
                {
                   
                }
                field(Name; Rec.Name)
                {
                   
                }
            }
        }
    }

}