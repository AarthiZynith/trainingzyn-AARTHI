tableextension 50113 CustomerExt extends Customer
{
    trigger OnModify()
    begin
        if Rec.Name <> xRec.Name then
            InsertLog('Name', xRec.Name, Rec.Name);

        if Rec."Name 2" <> xRec."Name 2" then
            InsertLog('Name 2', xRec."Name 2", Rec."Name 2");

        if Rec.Address <> xRec.Address then
            InsertLog('Address', xRec.Address, Rec.Address);

        if Rec.City <> xRec.City then
            InsertLog('City', xRec.City, Rec.City);

        if Rec."Post Code" <> xRec."Post Code" then
            InsertLog('Post Code', xRec."Post Code", Rec."Post Code");

        if Rec."Language Code" <> xRec."Language Code" then
            InsertLog('Language Code', xRec."Language Code", Rec."Language Code");

        if Rec."Payment Terms Code" <> xRec."Payment Terms Code" then
            InsertLog('Payment Terms Code', xRec."Payment Terms Code", Rec."Payment Terms Code");
    end;

    local procedure InsertLog(FieldName: Text; OldValue: Text; NewValue: Text)
    var
        LogEntry: Record "Customer Modify Log";
    begin
        LogEntry.Init();
        LogEntry."Customer No." := Rec."No.";
        LogEntry."Field Name" := FieldName;
        LogEntry."Old Value" := OldValue;
        LogEntry."New Value" := NewValue;
        LogEntry."User ID" := UserId;
        LogEntry."Modified On" := CurrentDateTime;
        LogEntry.Insert();
    end;
}

///Additional i guess 
