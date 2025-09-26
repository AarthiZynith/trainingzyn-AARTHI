page 50107 Zyn_IncomeList
{
    Caption = 'IncomeList';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Zyn_Income;
    CardPageId = Zyn_IncomeCard;

    layout
    {
        area(Content)
        {
            repeater(genereal)
            {
                field(IncomeID; Rec.IncomeID)
                {
                    
                }
                field(Description; Rec.Description)
                {
                    
                }
                field(Amount; Rec.Amount)
                {
                  
                }
                field(Date; Rec.Date)
                {
                    
                }

                field(CategoryName; Rec.CategoryName)
                {
                
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(categories)
            {
                RunObject = page Zyn_IncomeCategoryList;
            }
            action(IncomeExport)
            {
                RunObject = report Zyn_IncomeExportReport;

            }
        }
    }
}