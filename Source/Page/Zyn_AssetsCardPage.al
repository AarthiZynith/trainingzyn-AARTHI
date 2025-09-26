page 50188 Zyn_AssetsCard
{
    Caption='AssetsCard';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_Assets;

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field(AssetTypes; Rec.AssetTypes)
                {
                    
                }
                field(SerialNo; Rec.SerialNo)
                {
                   
                }
                field(ProcuredDate; Rec.ProcuredDate)
                {
                
                }
                field(Vendor; Rec.Vendor)
                {
                    
                }
                field(Availability; Rec.Availability)
                {
                   
                }
            }
        }
    }
}