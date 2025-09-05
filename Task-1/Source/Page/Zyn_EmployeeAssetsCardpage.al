page 50191 EmployeeAssetsCardPage
{
    PageType = Card;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = EmployeeAsset;
    // InsertAllowed=false;
    // ModifyAllowed=false;

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field(EmployeeID; Rec.EmployeeID)
                {
                    ApplicationArea = all;
                }
                field(Serial_No; Rec.Serial_No) { ApplicationArea = All; }
                field(AssetStatus; Rec.AssetStatus)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        AssetData: Record Assets;
                    begin
                        SetEditableFields();
                       // CurrPage.Update();
                        AssetData.Reset();
                        AssetData.SetRange(SerialNo, rec.Serial_No);
                        if AssetData.FindFirst() then begin
                            case rec.AssetStatus of
                                rec.AssetStatus::Assigned:
                                    AssetData.Availability := false;
                                rec.AssetStatus::Returned:
                                    AssetData.Availability := true;
                                rec.AssetStatus::lost:
                                   AssetData. Availability := false;

                            end;
                            AssetData.Modify();
                        end;



                        // if rec.Serial_No <> '' then begin
                        //     if AssetData.get(rec.Serial_No, rec.AssetTypeName) then begin
                        //    AssetData.updateavl(Rec.AssetStatus);
                        //         AssetData.Modify();
                        //     end;
                        // end;


                    end;


                    //this will do refresh operation 

                }
                field(AssignedDate; Rec.AssignedDate)
                {
                    ApplicationArea = All;
                    Editable = AssignedDateEditable;
                }
                field(ReturnedDate; Rec.ReturnedDate)
                {
                    ApplicationArea = All;
                    Editable = ReturnedDateEditable;
                }
                field(LostDate; Rec.LostDate)
                {
                    ApplicationArea = All;
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
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    // var
    //     myInt: Integer;
}