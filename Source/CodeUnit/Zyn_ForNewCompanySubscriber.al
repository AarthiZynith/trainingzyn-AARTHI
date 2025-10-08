codeunit 50122 "Zyn_NewCompanyCustomerSync"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Zyn_newpublisher, 'NewCompanycreation', '', false, false)]
    procedure OnCustomerCreated(var Rec: Record Customer)
    var
        CompanyMirror: Record "Zyn_Company"; // Table that stores target company names
        TargetCustomer: Record Customer;
        TempCustomer: Record Customer temporary;
    begin
        // Copy source customer to a temporary variable
        TempCustomer := Rec;

        // Loop through all mapped companies
        if CompanyMirror.FindSet() then
            repeat
                TargetCustomer.ChangeCompany(CompanyMirror.Name); // ← No hardcoding

                if not TargetCustomer.Get(Rec."No.") then begin
                    TargetCustomer := TempCustomer;
                    TargetCustomer.Insert(true); // Insert with validation
                end;
            until CompanyMirror.Next() = 0;
    end;
}
