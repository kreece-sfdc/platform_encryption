@isTest
public class TeamMemberProcessingTests 
{
	@isTest
    static void TestUpdates()
    {
        Team_Member__c tm = new Team_Member__c
            (
                Date_of_Birth__c = Date.newInstance(1980, 01, 01),
                Calculation_Updates__c = system.today().addDays(-1)
            );
        insert tm;
        
        system.assertEquals(null, tm.Next_Birthday__c);
        
        test.startTest();
        
        database.executeBatch(new TeamMemberProcessing(), 100);
        
        test.stopTest();
        
        List<Team_Member__c> items = [SELECT Id, Date_of_Birth__c, Next_Birthday__c, Calculation_Updates__c FROM Team_Member__c];
        
        Team_Member__c item = items.get(0);
        
        system.assertNotEquals(null, item.Next_Birthday__c);
    }
}