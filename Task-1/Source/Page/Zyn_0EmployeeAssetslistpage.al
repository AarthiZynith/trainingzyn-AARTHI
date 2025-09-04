page 50190 EmployeeAssetsListPage
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EmployeeAsset;
    CardPageId = EmployeeAssetsCardPage;
     InsertAllowed=false;
    // ModifyAllowed=false;
    Editable=false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(EmployeeID; Rec.EmployeeID)
                {
                    ApplicationArea = all;
                }
                field(Serial_No; Rec.Serial_No) { ApplicationArea = All; }
                field(AssetStatus; Rec.AssetStatus) { ApplicationArea = All; }
                field(AssignedDate; Rec.AssignedDate) { ApplicationArea = All; }
                field(ReturnedDate; Rec.ReturnedDate) { ApplicationArea = All; }
                field(LostDate; Rec.LostDate) { ApplicationArea = All; }
            }
        }

        
    }

}