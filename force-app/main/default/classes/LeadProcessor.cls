public class LeadProcessor implements Database.Batchable<sObject>{
    public static Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        for(Integer i=0; i<scope.size(); i++) {
            Lead l = scope.get(i);
            l.LeadSource = 'Dreamforce';
            scope.set(i, l);
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
        system.debug(job);
    }
}
