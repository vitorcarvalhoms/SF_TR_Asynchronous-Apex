@isTest
public with sharing class DailyLeadProcessorTest {
    
    @TestSetup
    static void setup(){
        List<Lead> lds = new List<Lead>();
        
        for(integer i = 0 ; i < 200 ; i++){
            Lead ld = new Lead();
            ld.FirstName = 'fn ' + i;
            ld.LastName = 'ln ' + i;
            ld.Company = 'cmp ' + i;
            lds.add(ld);
        }

        insert lds;
    }

    @isTest
    public static void DailyLeadProcessorTest() {
        DailyLeadProcessor dlp = new DailyLeadProcessor();
        String sch = '0 0 0 25 9 ? 2022';
        
        Test.StartTest();
        
        String jobId = system.schedule('DailyLeadProcessor', sch, dlp);
        System.System.debug([SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
        System.assertEquals(0, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
        
        Test.StopTest();
        System.System.debug([SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}