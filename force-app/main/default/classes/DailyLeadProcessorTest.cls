@IsTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 1 * * ?';
    @isTest
    static void DailyLeadProcessorTest(){
        List<Lead> testData = new List<Lead>();
        for(Integer i=0; i<200; i++) {
            testData.add(new Lead(FirstName = 'testName', LastName = 'testLastName', company = 'testCompany'));
        }
        insert testData;
        Map<Id, Lead> leadMap = new Map<Id, Lead>(testData);
        List<Id> testDataIds = new List<Id>(leadMap.keySet());
        Test.startTest();
            String jobId = System.schedule('scheduleApexTest', CRON_EXP, new DailyLeadProcessor());
            List<Task> lt = [SELECT Id FROM Task WHERE WhatId IN :testDataIds];
            System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        Test.stopTest();
        List<Lead> verifyRecords = [SELECT Id, LeadSource FROM Lead WHERE Id IN :testDataIds];
        for(Lead ld : verifyRecords) {
            System.assertEquals('Dreamforce', ld.LeadSource);
        }
    }
}
