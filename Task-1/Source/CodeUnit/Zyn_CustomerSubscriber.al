codeunit 50129 mysubscriber
{

    [EventSubscriber(ObjectType::Codeunit, codeunit::newpublisher, onaftercustomercreation, '', false, false)]
    procedure check(customer: text)

    begin
        Message('new customer   %1', customer);
    end;
}
