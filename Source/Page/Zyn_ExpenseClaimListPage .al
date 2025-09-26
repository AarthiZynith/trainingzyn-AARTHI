page 50235 Zyn_ExpenseClaimList
{
    PageType = List;
    Caption = 'ExpenseClaimList';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    SourceTable = Zyn_ExpenseClaim;
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

                }
                field(ClaimCategory; Rec.ClaimCategory)
                {

                }
                field(EmployeeID; Rec.EmployeeID)
                {

                }
                field(ClaimDate; Rec.ClaimDate)
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Status; Rec.Status)
                {

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