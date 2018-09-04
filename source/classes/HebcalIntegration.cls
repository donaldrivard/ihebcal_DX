public with sharing class HebcalIntegration  {

    @future (callout = true)
    public static void convertFromGregorianToHebrew(String value,String id){
            


           try{

                    String hebCalUrl = '';
                    String convStr='';
                    Integration__mdt hebCal = [select url__c,Disable__c from Integration__mdt where DeveloperName = 'HebCal'];

                    /*
                        Check to see if the trigger has been disabled.
                        If it has throw TriggerDisabledException

                    */
                    if(hebCal.Disable__c){
                        throw new TriggerDisabledException('HebCalConversion Trigger has been disabled');
                        
                        }

                    hebCalUrl=hebCal.url__c;   
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(hebCalUrl+value);
                    req.setMethod('GET');

                    Http http = new Http();
                    HTTPResponse res = http.send(req);

                    if(res.getStatusCode()==200) {
                            HebCalConversionObject conv  = (HebCalConversionObject) JSON.deserialize(res.getBody(),HebCalConversionObject.class);

                            if(conv.events == null){
                                conv.events = new List<String>() ;
                                }

                            convStr = conv.hd + ' ' + conv.hm + ' ' + conv.hd + ', ' + conv.hebrew + ' ' + conv.events;

                            Contact c = [select Hebrew_Birthday__c from Contact where id= : Id];
                            c.Hebrew_Birthday__c = convStr;

                            update c;
                         }else{

                             throw new CalloutException('HebcalIntegration Call FAILED! CODE = ' + res.getStatusCode());
                    }


                 }catch(Exception e){
                     System.debug('HebcalIntegration:convertFromGregorianToHebrew ' + e.getMessage());

                }

            
            }

    

}