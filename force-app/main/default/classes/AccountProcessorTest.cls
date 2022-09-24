@isTest
public with sharing class AccountProcessorTest {
    
    @isTest public static void AccountProcessorTest() {
        
        Account accTest = new Account(Name = 'accTest');
        insert accTest;
        
        List<Id> listAccTest = new List<Id>();
        listAccTest.add(accTest.Id);
        
        Contact cttTest = new Contact(FirstName = 'cttTest fn',
                              LastName = 'cttTest ln',
                             AccountId = accTest.Id);

        insert cttTest;
               
        Test.StartTest();
        AccountProcessor.countContacts(listAccTest);
        Test.StopTest();

        Account accTest2 = new Account();
        accTest2 = ([SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id = :accTest.Id]);
        System.assertEquals(1, accTest2.Number_Of_Contacts__c);
    }
}