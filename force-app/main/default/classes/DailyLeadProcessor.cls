public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {

        List<Lead> leads = new List<Lead>([SELECT Name, LeadSource 
                                           FROM Lead 
                                           WHERE LeadSource = null 
                                           LIMIT 200]);
        
        for(Lead lds : leads){
            lds.LeadSource = 'Dreamforce';
        }

        update leads;
    }
}
