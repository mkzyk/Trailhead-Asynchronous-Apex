public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;
    public AddPrimaryContact(Contact contactRecord, String stateName) {
        this.contact = contactRecord;
        this.state = stateName;
    }
    public void execute(QueueableContext context) {
        List<Account> act = [SELECT Id, Name FROM Account WHERE BillingState =:state LIMIT 200];
        List<Contact> cnt = new List<Contact>();
        for(Account ac : act) {
            Contact c = contact.clone(false,false,false,false);
            c.AccountId = ac.id;
            cnt.add(c);
        }
        if(cnt.size() > 0) {
            insert cnt;
        }
    }
}
