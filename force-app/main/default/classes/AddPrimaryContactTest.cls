@isTest
public with sharing class AddPrimaryContactTest {
    
    @TestSetup
    static void setup(){
        List<Account> accInsertNY = new List<Account>();
        List<Account> accInsertCA = new List<Account>();
        
        Contact ctt = new Contact(FirstName = 'fn', LastName = 'ln');
        
        for (integer i = 0; i < 50 ; i++){
            Account accNy = new Account();
            accNy.Name = 'NY' + i;
            accNy.BillingState = 'NY';
            accInsertNY.add(accNy);
            
            Account accCA = new Account();
            accCA.Name = 'CA' + i;
            accCA.BillingState = 'CA';
            accInsertCA.add(accCA);
        }
        
        insert ctt;
        insert accInsertNY;
        insert accInsertCA;
    }
    
    @isTest static void AddPrimaryContactTest() {
        Contact ctt = [SELECT Id, FirstName, LastName FROM Contact WHERE FirstName = 'fn' AND LastName = 'ln'][0];
                
        AddPrimaryContact apc = new AddPrimaryContact(ctt, 'CA');
       
        Test.StartTest();        
        System.enqueueJob(apc);
        Test.StopTest();

        System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE Account.BillingState = 'CA' ]);
    }
}
