pageextension 50131 "PostedCreditMemoExt" extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            part("Extended Text Part"; CreditMemoSubPageextn)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."), "Enum Method" = const(BeginText);
                Editable = false;
            }

            part("Extended Text "; CreditMemoSubPageextn2)
            {
                ApplicationArea = All;
                SubPageLink =
                              "No." = field("No."), "Enum Method" = const(EndText);

                Editable = false;
            }










        }
    }
}
