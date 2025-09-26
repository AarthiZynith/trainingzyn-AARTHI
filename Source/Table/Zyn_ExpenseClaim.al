table 50232 Zyn_ExpenseClaim
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ClaimID; Text[100])
        {
            Caption = 'ClaimID';
            DataClassification = ToBeClassified;

        }
        field(2; ClaimCategory; Text[100])
        {
            Caption = 'ClaimCategory';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_ExpenseClaimCategory.ClaimCode;
        }
        field(3; EmployeeID; code[100])
        {
            Caption = 'EmployeeID';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(4; ClaimDate; Date)
        {
            Caption = 'ClaimDate';
            DataClassification = ToBeClassified;

        }
        field(5; CategoryName; Text[100])
        {
            Caption = 'CategoryName';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_ExpenseClaimCategory.CategoryName;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ExpenseClaimCate: record Zyn_ExpenseClaimCategory;
            begin

                ExpenseClaimCate.Reset();
                ExpenseClaimCate.SetRange(ClaimCode, Rec.ClaimCategory);
                ExpenseClaimCate.SetRange(SubType, Rec.SubType);
                if ExpenseClaimCate.FindFirst() then begin
                    if Rec.Amount > ExpenseClaimCate.CategoryLimit then
                        Error(AmountFieldErrorCheck);
                end;
                rec.GetUtilizedAmount();
            end;
        }
        field(7; Status; enum Zyn_ExpenseClaimStatus)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;

        }
        field(8; Bill; Blob)
        {
            Caption = 'Bill';
            DataClassification = ToBeClassified;
            Subtype = Memo;

        }
        field(9; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(10; Billdate; Date)
        {
            Caption = 'Billdate';
            DataClassification = ToBeClassified;
        }
        field(11; SubType; Text[100])
        {
            Caption = 'SubType';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_ExpenseClaimCategory.SubType;

        }
        field(12; BillFileName; Text[100])
        {
            Caption = 'BillFileName';
            DataClassification = ToBeClassified;
        }
        field(13; UtilizedAmount; Decimal)
        {
            Caption = 'Utilized Amount';
            Editable = false;
        }

        field(14; AvailableAmount; Decimal)
        {
            Caption = 'Available Amount';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; ClaimID, EmployeeID, ClaimCategory)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Rec.Status := Rec.Status::PendingApproval;
    end;

    var
        limitamount: Decimal;
        AvailableLimit: Decimal;

    procedure ApproveClaim()
    var
        ExpenseClaim: Record Zyn_ExpenseClaim;
        ExpenseClaimCategory: Record Zyn_ExpenseClaimCategory;
        BillDateCheck: Date;
        UsedAmount: Decimal;

    begin
        // Status check
        if Status <> Status::PendingApproval then
            Error(StatusCheck);

        // Fetch category details
        ExpenseClaimCategory.Reset();
        ExpenseClaimCategory.SetRange(ClaimCode, ClaimCategory);
        ExpenseClaimCategory.SetRange(SubType, SubType);
        if ExpenseClaimCategory.FindFirst() then begin

            // Calculate used amount for this employee
            ExpenseClaim.Reset();
            ExpenseClaim.SetRange(EmployeeID, EmployeeID);
            ExpenseClaim.SetRange(ClaimCategory, ClaimCategory);
            ExpenseClaim.SetRange(SubType, SubType);
            ExpenseClaim.SetRange(Status, ExpenseClaim.Status::Approved);
            UsedAmount := 0;
            if ExpenseClaim.FindSet() then
                repeat
                    UsedAmount += ExpenseClaim.Amount;
                until ExpenseClaim.Next() = 0;

            AvailableLimit := ExpenseClaimCategory.CategoryLimit - UsedAmount;
            // Validate against available limit
            if Amount > AvailableLimit then
                AmountErrorCheck := StrSubstNo('Amount exceeds available category limit for this employee. Available: %1', AvailableLimit);

            Error(AmountErrorCheck);
            //  Update table fields, not local vars
            Rec.UtilizedAmount := UsedAmount;
            Rec.AvailableAmount := AvailableLimit;
        end;
        // Bill date check
        if ClaimDate <> 0D then
            BillDateCheck := CalcDate('<-3M>', ClaimDate);
        if (Billdate < BillDateCheck) then
            Error(BillCheck);
        // Duplicate check
        ExpenseClaim.Reset();
        ExpenseClaim.SetRange(CategoryName, CategoryName);
        ExpenseClaim.SetRange(EmployeeID, EmployeeID);
        ExpenseClaim.SetRange(Billdate, Billdate);
        ExpenseClaim.SetRange(SubType, SubType);
        ExpenseClaim.SetFilter(ClaimID, '<>%1', ClaimID);
        if ExpenseClaim.FindFirst() then
            Error(DuplicateErrorCheck);
        // Final approval
        Status := Status::Approved;
        Modify(); //  Persist changes
    end;

    procedure RejectClaim()
    begin
        if Status <> rec.Status::PendingApproval then
            Error(RejectClaimStatusCheck);
        Rec.Reset();
        Rec.SetRange("ClaimID", ClaimID);
        Rec.SetRange("EmployeeID", EmployeeID);
        Rec.SetRange("ClaimCategory", ClaimCategory);
        Rec.SetFilter("BillFileName", '<>%1', ''); // Ensures file is uploaded
        if not Rec.FindFirst() then
            Error(RejectClaimBillCheck);
        Rec.Status := Rec.Status::Rejected;
        Rec.Modify();
    end;

    procedure CancelClaim()
    begin
        if Status <> rec.Status::PendingApproval then
            Error(CancelClaimStatusCheck);
        rec.Status := rec.Status::Cancelled;
        Modify();
    end;


    procedure GetUtilizedAmount(): Decimal
    var
        CategoryRec: Record Zyn_ExpenseClaimCategory;
        ClaimRec: Record Zyn_ExpenseClaim;
        Total: Decimal;
        UtilizedAmount: Decimal;
    begin
        ClaimRec.Reset();
        ClaimRec.SetRange(ClaimCategory, rec.ClaimCategory);
        ClaimRec.SetRange(SubType, rec.SubType);
        ClaimRec.SetRange(EmployeeID, rec.EmployeeID); // Current record's EmployeeID
        ClaimRec.SetRange(Status, ClaimRec.Status::Approved);
        if ClaimRec.FindSet() then
            repeat
                Total += ClaimRec.Amount;
            until ClaimRec.Next() = 0;
        Rec.UtilizedAmount := Total;
        CategoryRec.Reset();
        CategoryRec.SetRange(CategoryName, Rec.CategoryName);
        CategoryRec.SetRange(SubType, Rec.SubType);
        if CategoryRec.FindFirst() then begin
            Rec.AvailableAmount := CategoryRec.CategoryLimit - Rec.UtilizedAmount;
        end;
        rec.Modify();
    end;

    var
        DuplicateErrorCheck: Label 'A claim with same Category, Employee, Bill Date, and SubType already exists.';
        AmountErrorCheck: Text;
        BillCheck: Label 'Billdate should be within limit.';
        StatusCheck: Label 'Status must be PendingApproval to approve.';
        RejectClaimStatusCheck: Label 'Status is not exist in PendingApproval.';
        RejectClaimBillCheck: Label 'Expense claim not found or bill not uploaded.';
        CancelClaimStatusCheck: Label 'Status is not exist in PendingApproval';
        AmountFieldErrorCheck: Label 'Amount exceeds category limit.';
}