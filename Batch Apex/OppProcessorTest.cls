@isTest
public class OppProcessorTest {
    @isTest
    private static void testBatchClass(){
       List<Opportunity> oppList=new List<Opportunity>();
        
        for(Integer i=0;i<200;i++){
            Opportunity opp=new Opportunity();
            opp.Name='Test' +i;
            opp.CloseDate=System.today();
            opp.StageName='Prospecting';
            oppList.add(opp);
        }
        Test.startTest();
        insert oppList;
        OppProcessor oppProcess=new OppProcessor();
		Id batchId=Database.executeBatch(oppProcess,200);
        Test.stopTest();
        
        List<Opportunity> updatedOpp=[SELECT ID FROM Opportunity WHERE LeadSource='Web'];
        
        System.assertEquals(200, updatedOpp.size());
        
    }

}