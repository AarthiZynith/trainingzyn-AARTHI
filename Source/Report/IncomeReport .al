report 50129 Zyn_IncomeExportReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Inc; Zyn_Income)
        {
            RequestFilterFields = CategoryName;

            trigger OnAfterGetRecord()
            begin
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn(Inc."IncomeID", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Inc.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Inc.Amount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Inc.Date, false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(Inc.CategoryName, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                TotalAmount += Inc.Amount;
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
        ExcelBuf.AddColumn('Income ID', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
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

        // Now Incort
        ExcelBuf.CreateNewBook('Income Report');
        ExcelBuf.WriteSheet('Incomes', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        FromDate: Date;
        ToDate: Date;
        TotalAmount: Decimal;
}
