page 50190 Zyn_EmployeeAssetsList
{
    Caption='EmployeeAssetsList';
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EmployeeAsset;
    CardPageId = Zyn_EmployeeAssetsCard;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(EmployeeID; Rec.EmployeeID)
                {

                }
                field(Serial_No; Rec.Serial_No)
                {
                    
                }
                field(AssetStatus; Rec.AssetStatus)
                {
                    
                }
                field(AssignedDate; Rec.AssignedDate)
                {
                    
                }
                field(ReturnedDate; Rec.ReturnedDate)
                {
                   
                }
                field(LostDate; Rec.LostDate)
                {
                   
                }
            }
        }

    }

}