public with sharing class UglyCode {
    private void uglyCode() {
        for(PE_Team_Member__c teamMember : [SELECT Id, PE_Contact__c, PE_Championship__c,PE_Full_Name__c,
                                                PE_Teams__c,PE_Teams__r.Name, PE_Team_Role__c, PE_Pit_Crew__c, PE_Phone__c,
                                                PE_Email__c, PE_First_Name__c, PE_Last_Name__c, PE_Teams__r.PE_Company__r.Name 
                                                FROM PE_Team_Member__c where PE_Championship__c  =: championship.Id And PE_Active__c = true
                                                Order By PE_Teams__r.Name ASC]){

                                                    if(!rowData.containsKey(teamMember.PE_Teams__c))
                                                        rowData.put(teamMember.PE_Teams__c,new Map<String,String>());
                                                    
                                                    Map<String,String> row = rowData.get(teamMember.PE_Teams__c);
                                                    row.put('Team Company', teamMember.PE_Teams__r.Name + '\n' + teamMember.PE_Teams__r.PE_Company__r.Name );
                                                    row.put('Team', teamMember.PE_Teams__r.Name );
                                                    
                                                    for(String role : this.teamRoles){
                                                        if(role == teamMember.PE_Team_Role__c && role!= 'DRR' ){
                                                            row.put(role, teamMember.PE_First_Name__c + ' ' + teamMember.PE_Last_Name__c + '\n' + teamMember.PE_Email__c + '\n' + teamMember.PE_Phone__c);
                                                        } else if(role == teamMember.PE_Team_Role__c && role == 'DRR'){
                                                            row.put(role, teamMember.PE_First_Name__c + ' ' + teamMember.PE_Last_Name__c + '\n' + teamMember.PE_Email__c);
                                                        }
                                                    }
                                                    for(String role : pitCrewRoles){
                                                        if(teamMember.PE_Pit_Crew__c == role){
                                                            if(!row.containsKey('Pit Crew')){
                                                                row.put('Pit Crew','');
                                                            }
                                                            row.put('Pit Crew',row.get('Pit Crew') + teamMember.PE_Full_Name__c + ' ' + teamMember.PE_Email__c + '\n');
                                                        }
                                                    }
                                                    rowData.put(teamMember.PE_Teams__c,row);   
                                                }
        }
    
}
