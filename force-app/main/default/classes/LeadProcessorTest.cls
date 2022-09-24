@isTest
public with sharing class LeadProcessorTest {
    
    @TestSetup
    static void makeData(){
        List<Lead> leads = new List<Lead>();
        for (integer i = 0; i < 200 ; i++ ){
            leads.add(new Lead(LastName = 'name ' + i,
                                Company = 'Company ' + i ));
        }

        insert leads;
    }
   
    @isTest static void LeadProcessorTest() {
        Test.StartTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchID = Database.executeBatch(lp);
        Test.StopTest();
        
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}
