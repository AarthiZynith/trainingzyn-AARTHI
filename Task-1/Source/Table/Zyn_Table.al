// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ALProject5;

using Microsoft.Sales.Customer;

table 50121 "Visit Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Visit Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Purpose"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Notes"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
