
@isTest
private class Demo2AccountDetailsTest {


    @isTest
     static void accountInformationTest() {
        //create records
        String recordId=createTestRecord();
        //create the instance of RestRequest
        RestRequest request=new RestRequest();
        request.requestURI='/service/apexrest/v1/Demo2AccountDetails/'+recordId;
        request.httpMethod='GET';
        RestContext.request=request;

        Test.startTest();
        Demo2AccountDetails.AccountWrapper wrapper=Demo2AccountDetails.accountInformation();
        System.assertNotEquals(null,wrapper);
        Test.stopTest();
    }

    @isTest
    static void createAccountWithRelatedRecordsTest(){
        RestRequest request=new RestRequest();
        request.requestURI='/service/apexrest/v1/Demo2AccountDetails/';
        request.httpMethod='POST';
        Account acc=new Account(Name='Test Account');
        Contact con=new Contact(LastName='Test Contact',AccountId=acc.id);
        Demo2AccountDetails.AccountInformation information= new Demo2AccountDetails.AccountInformation();
        information.accountRecord=acc;
        information.contactRecord=con;
        RestContext.request=request;
       

        Test.startTest();
        Demo2AccountDetails.AccountInformation response= Demo2AccountDetails.createAccountWithRelatedRecords(information);
        System.assertNotEquals(null,response);
       
        Test.stopTest();
        

    }

 

    static Id createTestRecord(){
        Account testAcc=new Account(Name='Test rec',Rating='Hot',Industry='Energy');
        insert testAcc;
        Contact testCon=new Contact(LastName='Test Rec_Contact',AccountId=testAcc.id);
        insert testCon;
        Case testCase=new Case(Subject='Test Subject',Priority='High',AccountId=testAcc.id);
        insert testCase;
        return testAcc.Id;
    }
}