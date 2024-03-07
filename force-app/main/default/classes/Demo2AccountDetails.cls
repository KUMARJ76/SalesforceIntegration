@RestResource(urlMapping='/v1/Demo2AccountDetails/*')

global with sharing class Demo2AccountDetails {

    //use case:2--- Third party will send the account Id in the URL and In a response we need to send Account Information along with the related Contacts and Cases
   @httpGet
  global static AccountWrapper accountInformation(){
     //Path Variable
     String accId=RestContext.request.requestURI.subStringAfterLast('/');
     Account acc=[select Id,Name,Rating,Industry from Account where Id =:accId];
     List<Contact>conList=[select Id,Name,Email,Phone from Contact where AccountId=:accId];
     List<Case>caseList=[select Id,Subject,Description,Status,Owner.Name from case where AccountId=:accId];
     AccountWrapper wrapper=new AccountWrapper();
     wrapper.accountRecord=acc;
     wrapper.contactList=conList;
     wrapper.caseList=caseList;

     return wrapper;
   }
//Wrapper class
   global class AccountWrapper{
     global Account accountRecord;
     global List<Contact> contactList;
     global List<case> caseList;
   }

  //Usecase:3------ Create a Webservice which will accept information about Account and contacts and insert Account with related contacts in salesforce and returned the information about both Account and contacts
   @httpPost

global static AccountInformation  createAccountWithRelatedRecords (AccountInformation information){
    Account accRecord=information.accountRecord;
    Contact conRecord=information.contactRecord;
    insert accRecord;
    conRecord.AccountId=accRecord.Id;
    insert conRecord;
    return information;
}



//    global static AccountContactWrapper createAccountRelatedContacts(String accountName,String accountIndustry,String accountRating,String contactLastName,String contactEmail){
//     Account acc=new Account(
//         Name=accountName,
//         Industry=accountIndustry,
//         Rating=accountRating
//     );
//      insert acc;
//     Contact con=new Contact(
//         LastName=contactLastName,
//         Email=contactEmail,
//         AccountId=acc.Id
//     );
//     insert con;
//     AccountContactWrapper wrapper=new AccountContactWrapper();
//     wrapper.accountRecord=acc;
//     wrapper.contactRecord=con;
  

//     // return acc;
//     return wrapper;
    

//    }






   //wrapper class AcountContacts

   global class AccountContactWrapper{
    global Account accountRecord;
    global Contact contactRecord;
   }

    

    // global static Account accountInformation() {
        //query Parameter
      
    //     Map<String,String> paramsMap=  RestContext.request.params;
    //     String accId=paramsMap.get('id');
    //     Account acc=[SELECT Id,Rating,Name,Industry FROM Account WHERE Id=:accId];
    //     return acc;
    // }

 global  class AccountInformation{
   global Account accountRecord{get;set;}
   global Contact contactRecord{get;set;}


 }


}