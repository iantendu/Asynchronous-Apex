@isTest
public class UpdateParentAccountTest {
    
    @testSetup
    static void setup(){
        List<Account> accList=new List<Account>();
        accList.add(new Account(Name='Ian Test'));
        for(Integer i=0;i<100;i++){
             accList.add(new Account(Name='Test' +i));
        }
        insert accList;
    }
    
    @isTest
    private static void testQueueable(){
        Id parentId=[SELECT Id FROM Account WHERE Name='Ian Test'][0].id;
        
        List<Account> accList=[SELECT Id,Name From Account WHERE Name LIKE 'Test%'];
        
        UpdateParentAccount updateJob=new UpdateParentAccount(accList,parentId);
        Test.startTest();
		Id jobId=System.enqueueJob(updateJob);
        Test.stopTest();
        
        System.assertEquals(100, [SELECT count() FROM Account WHERE parentId=:parentId]);
        
    }

}