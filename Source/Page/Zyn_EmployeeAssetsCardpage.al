page 50191 Zyn_EmployeeAssetsCard
{
    Caption = 'EmployeeAssetsCard';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = EmployeeAsset;

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field(EmployeeID; Rec.EmployeeID)
                {

                }
                field(Serial_No; Rec.Serial_No)
                {

                }
                field(AssetStatus; Rec.AssetStatus)
                {
                    trigger OnValidate()
                    var
                        AssetData: Record Zyn_Assets;
                    begin
                        SetEditableFields();
                        AssetData.Reset();
                        AssetData.SetRange(SerialNo, rec.Serial_No);
                        if AssetData.FindFirst() then begin
                            case rec.AssetStatus of
                                rec.AssetStatus::Assigned:
                                    AssetData.Availability := false;
                                rec.AssetStatus::Returned:
                                    AssetData.Availability := true;
                                rec.AssetStatus::lost:
                                    AssetData.Availability := false;

                            end;
                            AssetData.Modify();
                        end;

                    end;

                }
                field(AssignedDate; Rec.AssignedDate)
                {
                    Editable = AssignedDateEditable;
                }
                field(ReturnedDate; Rec.ReturnedDate)
                {
                    Editable = ReturnedDateEditable;
                }
                field(LostDate; Rec.LostDate)
                {
                    Editable = LostDateEditable;
                }
            }
        }
    }

    var
        AssignedDateEditable: Boolean;
        ReturnedDateEditable: Boolean;
        LostDateEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        SetEditableFields();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableFields();
    end;

    local procedure SetEditableFields()
    begin
        // Reset all
        AssignedDateEditable := false;
        ReturnedDateEditable := false;
        LostDateEditable := false;

        case Rec.AssetStatus of
            Rec.AssetStatus::Assigned:
                begin
                    AssignedDateEditable := true;
                end;

            Rec.AssetStatus::Returned:
                begin
                    AssignedDateEditable := true;
                    ReturnedDateEditable := true;
                end;

            Rec.AssetStatus::Lost:
                begin
                    AssignedDateEditable := true;
                    LostDateEditable := true;
                end;
        end;
    end;

}