page 50189 AssetsListPage
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Assets;
    CardPageId = AssetsCardPage;
    InsertAllowed = false;
    //ModifyAllowed=true;
    Editable = false;


    layout
    {
        area(Content)
        {
            Repeater(Group)
            {
                field(AssetTypes; Rec.AssetTypes)
                {
                    ApplicationArea = All;

                }
                field(SerialNo; Rec.SerialNo) { ApplicationArea = All; }
                field(ProcuredDate; Rec.ProcuredDate) { ApplicationArea = All; }
                field(Vendor; Rec.Vendor) { ApplicationArea = All; }
                field(Availability; Rec.Availability)
                {
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            part("AssignedAssets"; AssignedAssetsFactBoxPage)
            {
                ApplicationArea = All;


            }
        }


    }


    actions
    {
        area(Processing)
        {
            action(AssetType)
            {

                trigger OnAction()
                var
                    "AssetType": page AssetTypeListPage;

                begin
                    AssetType.RunModal();
                end;
            }
            action(EmployeeAsset)
            {
                trigger OnAction()
                var
                    "EmployeeAssets": page EmployeeAssetsListPage;
                begin
                    EmployeeAssets.RunModal();
                end;
            }
        }
    }


}