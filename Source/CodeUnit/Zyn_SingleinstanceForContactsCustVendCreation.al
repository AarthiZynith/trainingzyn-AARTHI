codeunit 50104 "Zyn_Single Instance Management"
{
    SingleInstance = true;

    internal procedure SetFromCreateAs()
    begin
        FromCreateAs := true;
    end;

    internal procedure GetFromCreateAs(): Boolean
    begin
        exit(FromCreateAs);
    end;

    internal procedure ClearCreateAs()
    begin
        Clear(FromCreateAs);
    end;

    var
        FromCreateAs: Boolean;
}