trigger ContactTrigger on Contact (before insert, after insert, 
                                   before update, after update, 
                                   before delete, after delete){



                if (Trigger.isBefore) {
                    if (Trigger.isInsert) {
                          
                        } 
                    if (Trigger.isUpdate) {
                          
                    }
                    if (Trigger.isDelete) {
                      // Call class logic here!
                    }
                }

                  if (Trigger.IsAfter) {
                    if (Trigger.isInsert) {
                        HebCalConversionHandler.setHebrewBirthday(Trigger.new,null);
                    } 
                    if (Trigger.isUpdate) {
                         if(!System.isFuture() && !System.isBatch()){
                         HebCalConversionHandler.setHebrewBirthday(Trigger.new,Trigger.oldMap);
                        }
                    }
                    if (Trigger.isDelete) {
                      // Call class logic here!
                    }
                  }

                    



    }