codeunit 50125 "Delete MyCompany Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerDatabase()
    var
        CompMgt: Codeunit "Company-Initialize";
        CompanyName: Text;
        companyrec: record Company;
    begin
        CompanyName := 'MyCompany';   // <-- Change this if needed

        if CompanyRec.Get(CompanyName) then begin
            // *** PERMANENTLY deletes all data of the company ***
            CompanyRec.Delete(true);  // true = run triggers
        end;
    end;
}
