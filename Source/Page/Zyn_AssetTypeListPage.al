page 50186 Zyn_AssetTypeList
{
    Caption = 'AssetTypeList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_AssetType;
    CardPageId = Zyn_AssetTypeCard;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            Repeater(Group)
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

