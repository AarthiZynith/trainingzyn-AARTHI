page 50234 Zyn_ExpenseClaimCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Zyn_ExpenseClaim;
    Caption='ExpenseClaimCard';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ClaimID; Rec.ClaimID)
                {
                    
                }
                field(ClaimCategory; Rec.ClaimCategory)
                {
                     trigger OnAfterLookup(Selected: RecordRef)
            var
                ExpenseClaimCategoryRec: Record Zyn_ExpenseClaimCategory;
            begin
                if PAGE.RunModal(PAGE::"Zyn_ExpenseClaimCategoryList", ExpenseClaimCategoryRec) = ACTION::LookupOK then begin
                    Rec.ClaimCategory := ExpenseClaimCategoryRec.ClaimCode;
                    Rec.SubType := ExpenseClaimCategoryRec.SubType;
                    limitamount:=ExpenseClaimCategoryRec.CategoryLimit;
                end;
            end;
                }
                field(EmployeeID; Rec.EmployeeID)
                {
                  
                }
                field(ClaimDate; Rec.ClaimDate)
                {  
                    trigger OnValidate()
                    begin
                      rec.AvailableAmount:=limitamount-Rec.UtilizedAmount;
                     end;
                }
                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    var
                        ExpenseClaimCate: record Zyn_ExpenseClaimCategory;
                    begin

                        ExpenseClaimCate.Reset();
                        ExpenseClaimCate.SetRange(ClaimCode, Rec.ClaimCategory);
                        ExpenseClaimCate.SetRange(SubType, Rec.SubType);
                        if ExpenseClaimCate.FindFirst() then begin
                            if Rec.Amount > ExpenseClaimCate.CategoryLimit then
                                Error(AmountExceedLimitCheck);
                        end;
                    end;
                }
                field(Status; Rec.Status)
                {
                   Editable=false;
                }
                field(Bill; Rec.Bill)
                 { 
                    
                 }
                field(Remarks; Rec.Remarks) 
                {
                  
                }
                field(Billdate; Rec.Billdate)
                { 
                    
                }
                field(SubType; Rec.SubType) 
                { 
                             
                }
                field(BillFileName;Rec.BillFileName)
                {
                 
                }
                field(UtilizedAmount;Rec.UtilizedAmount)
                {
                    
                }
                field(AvailableAmount;Rec.AvailableAmount)
                {

                }

            }
        }
    }
    actions{
        area(Processing){
             action(UploadFile)
            {
                ApplicationArea = All;
                Image = TestFile;
                trigger OnAction()
                begin
                    UploadAndStoreFile();
                end;
            }
        }
    }
    procedure UploadAndStoreFile()
    var
        FileName: Text;
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        if UploadIntoStream('Select a file', '', '', FileName, InStr) then begin
            TempBlob.CreateOutStream(OutStr); //  OutStream for writing
                   //  Copy uploaded InStream into TempBlob
             Rec.Bill.CreateOutStream(OutStr);
             CopyStream(OutStr, InStr);
               Rec.BillFileName := FileName;       // if you want to save name
        Rec.Modify();
            Message('File stored in TempBlob: %1', FileName);
        end;
    end;
    
    trigger OnAfterGetRecord()
            begin
                Rec.GetUtilizedAmount();
            end;
            var
            limitamount:Decimal;
            AmountExceedLimitCheck: Label 'Amount exceeds category limit.';
        }
     