global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<lead> leadRecords = [SELECT Id, LastName, FirstName, LeadSource FROM Lead WHERE LeadSource = '' LIMIT 200];
        for(Lead record : leadRecords) {
            record.LeadSource = 'Dreamforce';
        }
        update leadRecords;
    }
}
