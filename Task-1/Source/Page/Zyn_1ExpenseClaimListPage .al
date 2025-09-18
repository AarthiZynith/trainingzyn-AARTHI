page 50235 Zyn_ExpenseClaimList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    SourceTable = Zyn_ExpenseClaimTable;
    ModifyAllowed = false;
    CardPageId = Zyn_ExpenseClaimCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ClaimID; Rec.ClaimID)
                {
                    ApplicationArea = All;
                }
                field(ClaimCategory; Rec.ClaimCategory) { ApplicationArea = All; }
                field(EmployeeID; Rec.EmployeeID) { ApplicationArea = All; }
                field(ClaimDate; Rec.ClaimDate) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Bill; Rec.Bill) { ApplicationArea = All; }
                field(Remarks; Rec.Remarks) { ApplicationArea = All; }
                field(Billdate; Rec.Billdate) { ApplicationArea = All; }
                field(SubType; Rec.SubType) { ApplicationArea = All; }
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
        if UploadIntoStream('Select a file', '', '*.*', FileName, InStr) then begin
            TempBlob.CreateOutStream(OutStr); //  OutStream for writing
            CopyStream(OutStr, InStr);        //  Copy uploaded InStream into TempBlob
            Message('File stored in TempBlob: %1', FileName);
        end;
    end;
 trigger OnAfterGetRecord()
     begin
                Rec.GetUtilizedAmount();
            end;
   
}