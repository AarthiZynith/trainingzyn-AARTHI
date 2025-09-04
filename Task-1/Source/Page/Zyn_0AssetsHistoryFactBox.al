page 50193 AssetHistoryFactBox
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EmployeeTable;

    layout
    {
        area(Content)
        {
            Cuegroup(Group)
            {
                field(AssignedIndividualAssets; Rec.AssignedIndividualAssets)
                {
                    ApplicationArea = All;
                    DrillDownPageId = EmployeeAssetsListPage;
                }
            }
        }
    }

}