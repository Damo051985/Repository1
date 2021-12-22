table 50100 TestTable
{
    Caption = 'TestTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNO; Integer)
        {
            Caption = 'EntryNO';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[249])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Description 2"; Text[249])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
        field(4; Name; Text[249])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Name 2"; Text[249])
        {
            Caption = 'Name 2';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; EntryNO)
        {
            Clustered = true;
        }
    }

}
