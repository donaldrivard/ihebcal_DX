public with sharing class HebcalIntegration  {

    @future (callout = true)
    public static void convertFromGregorianToHebrew(String value,String query,String hebrewDateField){
           try{
				
                    String hebCalUrl = '';
                    String convStr='';
                    Integration__mdt hebCal = [select 
                                              		url__c
                                              from 
                                              		Integration__mdt 
                                              where 
                                              		label = 'HebCal'];

                    hebCalUrl=hebCal.url__c;   
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(hebCalUrl+value);
                    req.setMethod('GET');
                    Http http = new Http();
                    HTTPResponse res = http.send(req);
               
               		If(res.getStatusCode() == 301 || res.getStatusCode() == 302){
                   		req.setEndpoint(res.getHeader('Location'));
				   		res = new Http().send(req);
       			     }	
					
                    if(res.getStatusCode()==200) {
                            HebCalConversionObject conv  = (HebCalConversionObject) JSON.deserialize(res.getBody(),HebCalConversionObject.class);

                            if(conv.events == null){
                                conv.events = new List<String>() ;
                                }

                              convStr = conv.hd + ' ' + conv.hm + ' ' + conv.hd + ', ' + conv.hebrew + ' ' + conv.events;
							  SObject c = Database.query(query);
                              c.put(hebrewDateField,convStr);
                              
                        	  update c;
                         }else{
                            throw new CalloutException('HebcalIntegration Call FAILED! CODE = ' + res.getStatusCode());
                    }
                 }catch(Exception e){
                     System.debug('HebcalIntegration:convertFromGregorianToHebrew ' + e.getMessage());
	}
}

    

}