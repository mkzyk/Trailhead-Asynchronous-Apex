@IsTest
public class AddPrimaryContactTest {
    @TestSetup
    static void makeData(){
        List<Account> AccData = new List<Account>();
        for(Integer i=0; i<100; i++) {
            if(i < 50) {
                AccData.add(new Account(name='Account ' + String.valueOf(i), BillingState='NY'));
            } else {
                AccData.add(new Account(name='Account ' + String.valueOf(i), BillingState='CA'));
            }
        }
        insert AccData;
    }
    @IsTest
    public static void AddPrimaryContactTest() {
        Contact cnt = new Contact(FirstName='test', LastName='test');
        AddPrimaryContact apc = new AddPrimaryContact(cnt, 'CA');
        Test.startTest();
            System.enqueueJob(apc);
        Test.stopTest();
    }
}
