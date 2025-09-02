report 50136 "Expense Export Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Exp; Expense)
        {
            RequestFilterFields = CategoryName;

            trigger OnAfterGetRecord()
            begin
                // (Step 2) Add data rows for each record
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn(Exp."ExpenseID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Exp.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Exp.Amount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Exp.Date, false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(Exp.CategoryName, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                TotalAmount += Exp.Amount;
            end;
        }
    }



  requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("From Date"; FromDate) { ApplicationArea = All; }
                    field("To Date"; ToDate) { ApplicationArea = All; }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        // (Step 1) Initialize buffer and add header row
        ExcelBuf.DeleteAll();

        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Expense ID', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Date', false, '', true, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn('Category', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin
    // Add a blank row
    ExcelBuf.NewRow();

    // Add TOTAL row
    ExcelBuf.NewRow();
    ExcelBuf.AddColumn('TOTAL', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    ExcelBuf.AddColumn(TotalAmount, false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);
    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

    // Now export
    ExcelBuf.CreateNewBook('Expense Report');
    ExcelBuf.WriteSheet('Expenses', CompanyName, UserId);
    ExcelBuf.CloseBook();
    ExcelBuf.OpenExcel();
end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        
        FromDate: Date;
        ToDate: Date;
        TotalAmount: Decimal;
}
