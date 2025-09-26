pageextension 50131 Zyn_PostedCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            part("Extended Text Part"; Zyn_CreditMemoSubPageextn)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."), "Enum Method" = const(BeginText);
                Editable = false;
            }

            part("Extended Text "; Zyn_CreditMemoSubPageextn2)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."), "Enum Method" = const(EndText);

                Editable = false;
            }










        }
    }
}
