page 50192 AssignedAssetsFactBoxPage
{
    PageType = listPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Assets;
    SourceTableTemporary=true;
    
    layout
    {
        area(Content)
        {
            cuegroup(Group)
            {
                field(TotalAssets;TotalAssets)
                {
                    ApplicationArea=All;
                    DrillDown=true;
                   // DrillDownPageId=AssetsListPage;
                    trigger OnDrillDown()
                    var AssetRec: record EmployeeAsset;
                    begin
                        AssetRec.Reset();
                        AssetRec.SetRange(AssetStatus,AssetRec.AssetStatus::Assigned);
                        if AssetRec.FindSet() then

                        Page.run(page:: EmployeeAssetsListPage,AssetRec);
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