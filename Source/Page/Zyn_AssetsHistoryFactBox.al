page 50193 Zyn_AssetHistoryFactBox
{
    Caption='AssetHistoryFactBox';
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_EmployeeTable;

    layout
    {
        area(Content)
        {
            Cuegroup(Group)
            {
                field(AssignedIndividualAssets; Rec.AssignedIndividualAssets)
                {
                    DrillDownPageId =Zyn_EmployeeAssetsList;
                }
            }
        }
    }

}