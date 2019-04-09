@isTest
public class TeamMemberProcessingTests 
{
    @testSetup
    static void Setup()
    {
       Team_Member__c tm = new Team_Member__c
            (
                Date_of_Birth__c = Date.newInstance(1980, 01, 01),
                Calculation_Updates__c = system.today().addDays(-1),
                Forename__c = 'Bob',
                Surname__c = 'Smith'
            );
        
        insert tm;
    }
    
	@isTest
    static void TestUpdates()
    {
        test.startTest();
        
        database.executeBatch(new TeamMemberProcessing(), 100);
        
        test.stopTest();
        
        List<Team_Member__c> items = [SELECT Id, Date_of_Birth__c, Next_Birthday__c, Age__c, Age_Range__c, Calculation_Updates__c FROM Team_Member__c];
        
        Team_Member__c item = items.get(0);
        
        system.assertNotEquals(null, item.Next_Birthday__c);
        system.assertNotEquals(null, item.Age__c);
        system.assertNotEquals(null, item.Age_Range__c);
    }
    
    @isTest
    static void TestSort()
    {
        Team_Member__c tm = new Team_Member__c
            (
                Date_of_Birth__c = Date.newInstance(1980, 02, 02),
                Calculation_Updates__c = system.today().addDays(-1),
                Forename__c = 'Bob',
                Surname__c = 'Freddo'
            );
        
        insert tm;
        
        List<Team_Member__c> items = TeamMemberQueries.GetAllSortedBySurname();
        
        for(Team_Member__c item : items)
        {
        	system.debug(item.Surname__c);    
        }
        
        Team_Member__c freddo = items.get(0);
        Team_Member__c smith = items.get(1);
        
        system.assertEquals('Freddo', freddo.Surname__c);
        system.assertEquals('Smith', smith.Surname__c);
    }
}