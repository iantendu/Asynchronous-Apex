@isTest
public class DailyOppProcessorTest {
    
  
	@isTest
    private static void testScheduledApex(){
          String sch='0 0 0 ? * * *';
        List<Opportunity> oppList=new List<Opportunity>();
        for(Integer i=0;i<500;i++){
            if(i<250){
                oppList.add(new Opportunity(Name='Test' +i,StageName='Prospecting',CloseDate=System.today(),LeadSource='Email'));
            }else{
              oppList.add(new Opportunity(Name='Test' +i,StageName='Prospecting',CloseDate=System.today(),LeadSource='Web'));  
            }
        }
        insert oppList;
        Test.startTest();
        String JobId=System.schedule('Process opps', sch, new DailyOppProcessor());
        Test.stopTest();
        
        List<Opportunity> updateOpps=new List<Opportunity>();
        updateOpps=[SELECT Id,LeadSource FROM Opportunity WHERE LeadSource='web'];
        System.assertEquals(250, updateOpps.size());
    }
}