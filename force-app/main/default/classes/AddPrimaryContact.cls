public with sharing class AddPrimaryContact implements Queueable {
    
    Contact ctt = new Contact();
    String state;
    public AddPrimaryContact(Contact contact, String state) {
        this.ctt = contact;
        this.state = state;
    }

    public void execute(QueueableContext context){
        List<Account> accList = new List<Account>([SELECT Name, BillingState
                                                   FROM Account 
                                                   WHERE BillingState = :this.state
                                                   LIMIT 200 ]);
        
        List<Contact> cttListUpdate = new List<Contact>();
     
        for (Account acc : accList){
            Contact clonedCtt = this.ctt.clone(false, false, false, false);
            clonedCtt.AccountId = acc.Id;
            cttListUpdate.add(clonedctt);
        }
        insert cttListUpdate;
    }
}