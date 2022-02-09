// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 CustomerListExt extends "Customer List"
{

    actions
    {
        Addfirst(Navigation)
        {
            Action("Check License")
            {
                Caption = 'Check License';
                Trigger OnAction()
                Var
                    CheckLicense: Page CheckLicense;
                    TestPage: Page TestPage;
                    lTestTable: Record "TestTable";
                Begin
                    Message('TestDano1');
                    TestPage.Run;
                    lTestTable.Findset;
                    TaskScheduler.CreateTask(Codeunit::TestCodeunit, Codeunit::TestCodeunit2, True, CompanyName, CurrentDateTime, lTestTable.RecordID);
                End;
            }
        }
    }
    trigger OnOpenPage();
    var
        CheckLicence: Page CheckLicense;
    begin
        //Message('App published: Hello world');
        //CheckLicence.Run;
    end;

}

https://planetary-equinox-317127.postman.co/workspace/BC-API-for-LL~2310f2c4-9e47-46eb-a74e-d1f94be8881b/request/14067098-0c30a7b8-b8af-4a49-b7c4-a2ee26a2189a
