codeunit 50129 Zyn_mysubscriber
{

    [EventSubscriber(ObjectType::Codeunit, codeunit::Zyn_newpublisher, onaftercustomercreation, '', false, false)]
    procedure check(customer: text)

    begin
        Message('new customer   %1', customer);
    end;
}
