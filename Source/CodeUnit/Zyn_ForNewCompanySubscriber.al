codeunit 50122 Zyn_NewCompanyCustomerSync
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::Zyn_newpublisher, NewCompanycreation, '', false, false)]
    procedure OnCustomerCreated(var Rec: Record Customer)
    var
        TargetCustomer: Record Customer;
        TempCustomer: Record Customer temporary;
    begin

        TempCustomer := Rec;
        TargetCustomer.ChangeCompany('Aarthi Arumugam');
        if not TargetCustomer.Get(Rec."No.") then begin
            TargetCustomer := TempCustomer;
            TargetCustomer.Insert();    // Insert with validation
        end;
    end;





    // procedure OnCustomerCreated(var Rec: Record Customer)
    // var
    //     TargetCustomer: Record Customer;
    // begin
    //     TargetCustomer.ChangeCompany('Aarthi Arumugam ');
    //     if not  TargetCustomer.Get(Rec."No.") then  begin
    //         TargetCustomer.Init();
    //         TargetCustomer.TransferFields(Rec);
    //         TargetCustomer.Insert();

    //     end;
    // end;
}