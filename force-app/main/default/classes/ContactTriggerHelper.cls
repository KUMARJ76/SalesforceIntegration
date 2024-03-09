public with sharing class ContactTriggerHelper {
    public static void afterInsert(List<Contacts>conList) {
        Map <Id,String>phoneDetailsMap=new Map <Id,String>();
       for(Contact con:conList){
        if(String.isNotBlank(con.Phone))
          phoneDetailsMap.put(con.id,con.phone);
       }
       if(!phoneDetailsMap.isEmpty()){
        validatePhone(phoneDetailsMap);
       }
      
    }
     @future(callout=true)
    public static void validatePhone(Map<Id,String>phoneDetails){
      Map <Id,Boolean>phoneVerificationResult=new Map<Id,Boolean>();
       for(Id conId:phoneDetailsMap.keySet()){
        String phoneNumber=phoneDetailsMap.get(conId);
        //make sure that remote site setting is defined for this URL. -http://apiLayer.net
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        String endpoint=System.LABEL.numVerifyUrl+System.LABEL.numVerifyAccessCode+'&number='+PhoneNumber+'&format=1';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');
        request.setTimeout(120000);  //default-10s can be writable to 120s
        //send the request
        HttpResponse response=http.send(request);
        Integer statusCode=response.getStatusCode();
        if(statusCode==200){
         String responseBody=response.getBody();
         /* JSON.deserializeUntyped(responseBody);
         create a jsontoapex class and then define it in org and call it
         umVerifyclass formattedResponse=numVerifyclass.parse(responseBody);
         phoneVerificationResult.put(conId,formattedResponse.valid);

         */
        }else{
         System.debug('Error'+response.getBody());
        }

       }
   
          List<Contact>conList=[Select Id,Phone,con.is_phone_valid__c from Contact where Id =:phoneDetailsMap.keySet()];
          for(Contact con:conList){
            con.is_phone_valid__c=phoneVerificationResult.get(con.id);
          }
          if(!conList.isEmpty()){
            try{
               update conList;
            }catch(Exception e){
              System.debug(e.getMessage());
            }
          }
        

      }

}