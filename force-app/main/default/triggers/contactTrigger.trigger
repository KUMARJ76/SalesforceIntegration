trigger contactTrigger on Contact (after insert) {

    //Note:- Some trigger can be used for update trigger as well
    if(trigger.isInsert && trigger.isAfter){
        ContactTriggerHelper.afterInsert(trigger.new);

    }

}