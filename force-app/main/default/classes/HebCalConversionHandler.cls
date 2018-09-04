public with sharing class HebCalConversionHandler  {



        public static void setHebrewBirthday(List<Contact> contacts, Map<id,Contact> oldContacts){

        if (Schema.sObjectType.Contact.fields.Hebrew_Birthday__c.isUpdateable()){
                     for(Contact c : contacts){
                            if(c.Birthdate != null){ 

                                     
                                Integer day = c.Birthdate.day();
                                Integer month = c.Birthdate.month();
                                Integer year = c.Birthdate.year(); 
                                String afterSunset = '&gs=off';

                                if(c.BirthdayAftersunset__c){
                                    afterSunset = '&gs=on';
                                }

                                                                                    
                                String call = '?cfg=json&gy='+year+'&gm='+month+'&gd='+day+'&g2h=1' + afterSunset;
                                   if(System.Trigger.isUpdate){
                                        Contact oldC = oldContacts.get(c.Id);
                                    
                                            if((c.Birthdate != oldC.Birthdate) || (c.BirthdayAftersunset__c != oldC.BirthdayAftersunset__c)){
                                                HebcalIntegration.convertFromGregorianToHebrew(call,c.Id);  
                                            }

                                             }else{
                                                HebcalIntegration.convertFromGregorianToHebrew(call,c.Id);  
                                      }

                        }

                 }
            }else{
                throw new DmlException('User ' + UserInfo.getName() + ' does not have update access to the Hebrew_Birthday__c field');
            }

    }
}