@IsTest
private class LeadProcessorTest {
    @TestSetup
    static void makeData(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++) {
            leads.add(new Lead(FirstName='Taro', LastName='Test', Company='Test', LeadSource='test'));
        }
        insert leads;
    }
    @IsTest
    static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        for(Lead l : [SELECT LeadSource FROM Lead]) {
            System.assertEquals('Dreamforce', l.LeadSource);
        }
    }
}
