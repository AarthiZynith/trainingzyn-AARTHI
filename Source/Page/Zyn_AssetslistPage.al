page 50189 Zyn_AssetsList
{
    Caption = 'AssetsList';
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_Assets;
    CardPageId = Zyn_AssetsCard;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            Repeater(Group)
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

        area(FactBoxes)
        {
            part("AssignedAssets"; Zyn_AssignedAssetsFactBox)
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
                    "AssetType": page Zyn_AssetTypeList;

                begin
                    AssetType.RunModal();
                end;
            }
            action(EmployeeAsset)
            {
                trigger OnAction()
                var
                    "EmployeeAssets": page Zyn_EmployeeAssetsList;
                begin
                    EmployeeAssets.RunModal();
                end;
            }
        }
    }

}