public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> ids) {        
        
        for (String acc : ids ){
            Account accUpdate = new Account();
            accUpdate = [SELECT Id FROM Account WHERE Id = :acc];
            
            List<Contact> listCtt = new List<Contact>([SELECT Id FROM Contact WHERE AccountId = :acc]);
            
            accUpdate.Number_Of_Contacts__c = listCtt.Size();
            
            update accUpdate;
        }
    }
}