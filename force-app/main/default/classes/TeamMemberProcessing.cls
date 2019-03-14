public class TeamMemberProcessing implements Schedulable, Database.Batchable<Team_Member__c>
{
	public void execute(SchedulableContext ctx)
    {
        database.executeBatch(this, 100);
    }
    
    public Iterable<Team_Member__c> start(Database.BatchableContext ctx)
    {
        // this will capture all fields where calculations have not run or completed
        return 
            [
            	SELECT Id, Date_of_Birth__c, Next_Birthday__c, Calculation_Updates__c 
                FROM Team_Member__c 
                WHERE Calculation_Updates__c <: system.today()
            ];
    }
    
    public void execute(Database.BatchableContext ctx, List<Team_Member__c> items)
    {
        // this will effectively prod the Workflow Trigger to perform the re-calculation
        
        for(Team_Member__c item : items)
        {
            item.Calculation_Updates__c = system.today();
        }
        
        database.upsert(items);
    }
    
    public void finish(Database.BatchableContext ctx)
    {
        
    }
}