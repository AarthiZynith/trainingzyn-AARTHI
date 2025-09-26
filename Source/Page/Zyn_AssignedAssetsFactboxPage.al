page 50192 Zyn_AssignedAssetsFactBox
{
    Caption = 'AssignedAssetsFactBox';
    PageType = listPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_Assets;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            cuegroup(Group)
            {
                field(TotalAssets; TotalAssets)
                {        
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        AssetRec: record EmployeeAsset;
                    begin
                        AssetRec.Reset();
                        AssetRec.SetRange(AssetStatus, AssetRec.AssetStatus::Assigned);
                        if AssetRec.FindSet() then
                            Page.run(page::Zyn_EmployeeAssetsList, AssetRec);
                    end;

                }
            }
        }
    }

    var
        TotalAssets: Integer;

    trigger OnOpenPage()
    var
        AssetRec: Record EmployeeAsset;
    begin
        AssetRec.Reset();
        TotalAssets := AssetRec.Count;
        rec.Init();
        rec.Insert();  // count all assets in system
    end;

}