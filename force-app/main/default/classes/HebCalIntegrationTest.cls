@isTest

private class HebCalIntegrationTest  {


            @testSetup static void setup() {
                HebCalConversionObject obj = new HebCalConversionObject();
                obj.gd = 1;
                obj.gm = 1;
                obj.gy = 1;
                obj.hd = 1;
                obj.hy = 1;
                obj.events = new String[]{};


            }



            @IsTest
            private static void testHebCalInsertCallout() {
                    Test.setMock(HttpCalloutMock.class, new HebCalCalloutMock());

                    Contact c = new Contact();
                    c.LastName = 'Testing 1';
                    c.Birthdate = Date.newInstance(1962, 11, 22);

                    Test.startTest();
                        insert c;
                    Test.stopTest();

                    Contact uContact = [select Hebrew_Birthday__c from Contact where Id =: c.Id];
                    System.assertEquals('25 Cheshvan 25, כ״ה בְּחֶשְׁוָן תשכ״ג (Parashat Chayei Sara)',uContact.Hebrew_Birthday__c);

            }


            @IsTest
            private static void testHebCalCalloutBadResponse() {
                    Test.setMock(HttpCalloutMock.class, new HebCalCalloutMockBadStatus());

                    Contact c = new Contact();
                    c.LastName = 'Testing 1';
                    c.Birthdate = Date.newInstance(1962, 11, 22);

                    Test.startTest();
                        insert c;
                    Test.stopTest();

                    Contact uContact = [select Hebrew_Birthday__c from Contact where Id =: c.Id];
                    System.assertEquals(null,uContact.Hebrew_Birthday__c);

            }



              @IsTest
                private static void testHebCalUpdateBirthdayChangedCallout() {
                    Test.setMock(HttpCalloutMock.class, new HebCalCalloutMock());

                    Contact c = new Contact();
                    c.LastName = 'Testing 1';
                    insert c;
                    
                     Contact iContact = [select Birthdate,Hebrew_Birthday__c from Contact where Id =: c.Id];
                     iContact.Birthdate = Date.newInstance(1962, 11, 22);

                      Test.startTest();
                           update iContact;
                      Test.stopTest();

                     Contact uContact = [select Birthdate,Hebrew_Birthday__c from Contact where Id =: iContact.Id];
                    
                     System.assertEquals('25 Cheshvan 25, כ״ה בְּחֶשְׁוָן תשכ״ג (Parashat Chayei Sara)',uContact.Hebrew_Birthday__c);

            }


             @IsTest
                private static void testHebCalUpdateAfterSunsetCallout() {
                    Test.setMock(HttpCalloutMock.class, new HttpCalloutAfterSunsetMock());

                    Contact c = new Contact();
                    c.LastName = 'Testing 1';
                    c.Birthdate = Date.newInstance(1962, 11, 22);
                    c.BirthdayAftersunset__c = false;
                   
                     insert c;
                    
                        
                      Contact iContact = [select Birthdate,Hebrew_Birthday__c from Contact where Id =: c.Id];
                      iContact.BirthdayAftersunset__c = true;

                      Test.startTest();
                           update iContact;
                      Test.stopTest();

                      Contact uContact = [select Birthdate,Hebrew_Birthday__c from Contact where Id =: iContact.Id];
                    
                      System.assertEquals('26 Cheshvan 26, כ״ו בְּחֶשְׁוָן תשכ״ג (Parashat Chayei Sara)',uContact.Hebrew_Birthday__c);

            }


}