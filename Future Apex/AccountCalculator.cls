public class AccountCalculator {

    @future
    public static void countContacts(List<Id> accIds){
     List<Account> accList =[SELECT Id,Count_Number_of_Contacts__c,(SELECT Id FROM Contacts) FROM Account Where Id IN: accIds];
        for(Account acc:accList){
           acc.Count_Number_of_Contacts__c=acc.Contacts.size(); 
        }   
        if(!accList.isEmpty()){
            update accList;
        }
    }
}