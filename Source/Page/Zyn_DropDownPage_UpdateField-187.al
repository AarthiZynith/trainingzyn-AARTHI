page 50100 Zyn_UpdateFieldDialog
{
    PageType = Card;
    Caption = 'Update Field';
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SelectedTableID; SelectedTableID)
                {
                    Caption = 'Table Name';
                    TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(table));

                }
                field(SelectedFieldNo; SelectedFieldNo)
                {
                    Caption = 'Field';
                    DrillDown = true;
                    trigger OnDrillDown()

                    var
                        RecRef: RecordRef;
                        FieldRef: FieldRef;
                        TempBuffer: Record Zyn_DropDownTable temporary;
                        i: Integer;
                        FN: Text[250];
                    begin
                        if SelectedTableID = 0 then
                            Error('Please select a table first.');

                        RecRef.Open(SelectedTableID);

                        for i := 1 to RecRef.FieldCount do begin
                            FieldRef := RecRef.FieldIndex(i);
                            TempBuffer.Init();
                            TempBuffer."ID" := FieldRef.Number;
                            FN := FieldRef.Name;
                            TempBuffer."Name" := FN;
                            TempBuffer.Insert();
                        end;

                        RecRef.Close();

                        if Page.RunModal(Page::"Zyn_DropDownList", TempBuffer, selectno) = Action::LookupOK then begin
                            fieldid := TempBuffer.ID;
                            SelectedFieldNo := TempBuffer.Name;
                        end;

                    end;
                }


                field(SelectedRecordID; SelectedRecordID)
                {
                    Caption = 'Record';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        RecRef: RecordRef;
                        FldRef: FieldRef;
                        Tempbuffer: Record Zyn_FieldValueBuffer temporary;
                        LineNo: Integer;
                    begin

                        RecRef.Open(SelectedTableID);
                        FldRef := RecRef.Field(fieldid);
                        if RecRef.FindSet() then begin
                            LineNo := 0;
                            repeat
                                LineNo += 1;
                                Tempbuffer.Init();
                                Tempbuffer."Field Id" := LineNo;
                                Tempbuffer."Field Name" := Format(FldRef.Value);
                                Tempbuffer."Record Id" := RecRef.RecordId;
                                Tempbuffer.Insert();
                            until RecRef.Next() = 0;
                            RecRef.Close();
                            if Page.RunModal(Page::Zyn_FieldValueList, Tempbuffer, SelectVal) = Action::LookupOK then begin
                                SelectedRecordID := Tempbuffer."Field Name";
                                RecordID := Tempbuffer."Record Id";

                            end;
                        end;
                    end;

                }

                field(NewValue; NewValue)
                {
                    Caption = 'Value';
                    trigger OnValidate()
                    var
                        recref: RecordRef;
                        fldref: FieldRef;
                    begin

                        recref.Open(SelectedTableID);
                        if not recref.Get(RecordID) then
                            Error('Could not find the selected rcord');
                        fldref := recref.Field(fieldid);
                        fldref.Value := NewValue;
                        recref.Modify();
                        Message('Value Updated Sucessfully');
                        CurrPage.Close();
                    end;
                }
            }
        }
    }

    var
        SelectedRecordID: Text[250];
        SelectedTableID: Integer;
        SelectedFieldNo: Text[250];
        fieldid: Integer;
        selectno: Integer;

        fieldName: text[100];
        NewValue: Text[100]; // Adjust size/type as needed
        RecRef: RecordRef;
        FldRef: FieldRef;
        RecordSection: Text[200];
        RecordID: RecordId;
        SelectVal: Integer;

}
