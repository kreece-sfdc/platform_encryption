public class TeamMemberQueries 
{
	public static List<Team_Member__c> GetAll()
    {
        return 
            [
                SELECT Id, Date_of_Birth__c, Next_Birthday__c, Age__c, Age_Range__c, Calculation_Updates__c, Forename__c, Surname__c
                FROM Team_Member__c
                WHERE Id != NULL
            ];
    }
    
    public static List<Team_Member__c> GetAllSortedBySurname()
    {
        List<Team_Member__c> items = new List<Team_Member__c>
            ([
                SELECT Id, Date_of_Birth__c, Next_Birthday__c, Age__c, Age_Range__c, Calculation_Updates__c, Forename__c, Surname__c
                FROM Team_Member__c
                WHERE Id != NULL
            ]);
        
        Collection.Sort(items, Team_Member__c.Surname__c);
        
        for(Team_Member__c item : items)
        {
        	system.debug(item.Surname__c);    
        }
        
        return items;
    }
}