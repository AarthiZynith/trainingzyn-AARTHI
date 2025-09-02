//Procedure calling/or raising 

pageextension 50109 CustomernewCardExt extends "Customer Card"
{
    var
        isNewCustomer: Boolean;

    trigger OnOpenPage()
    begin
        if Rec."No." = '' then
            isNewCustomer := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // CurrPage.Update(); // Flush user input into Rec
        if (isNewCustomer) and (Rec.Name = '') then begin
            Message('Please enter a customer name');
            exit(false)
        end;
        exit(true)
    end;

    trigger OnClosePage()

    Var
        publisher: Codeunit newpublisher;
    begin
        if isNewCustomer and (Rec.Name <> '') then begin
            publisher.onaftercustomercreation(Rec.Name);
            publisher.NewCompanycreation(Rec);
        end;
    end;

}




