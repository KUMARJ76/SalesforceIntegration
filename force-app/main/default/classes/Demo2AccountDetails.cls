@RestResource(urlMapping='/v1/Demo2AccountDetails/*')

global with sharing class Demo2AccountDetails {
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

    

    // global static Account accountInformation() {
        //query Parameter
      
    //     Map<String,String> paramsMap=  RestContext.request.params;
    //     String accId=paramsMap.get('id');
    //     Account acc=[SELECT Id,Rating,Name,Industry FROM Account WHERE Id=:accId];
    //     return acc;
    // }
}