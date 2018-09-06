public class HebcalFlowIntegration {

    public class DateParameters{
        //Need to make this generic 
        @InvocableVariable(required=true)
        public Id ObjectID;
        
        @InvocableVariable(required=true)
        public String ObjectName;
        
        @InvocableVariable(required=true)
        public Date DateToBeConverted;
        
        @InvocableVariable(required=true)
        public String hebrewDatename;
        
        @InvocableVariable(required=true)
        public Boolean afterSunset;
    }
    
@InvocableMethod(label='Handle HebCal Date Integration' description='Convert Date to Hebrew Date')    
    public static void handleDate(List<DateParameters> parameters) {
           
        for(DateParameters p : parameters){
            Integer day = p.DateToBeConverted.day();
            Integer month = p.DateToBeConverted.month();
            Integer year = p.DateToBeConverted.year(); 
              
            if(p.afterSunset == true){
					day++;
              }

            String call = '?cfg=json&gy='+year+'&gm='+month+'&gd='+day+'&g2h=1';
            String cId = '\'' + p.ObjectID + '\'';
			String q ='Select ' + p.hebrewDatename + ' from ' + p.ObjectName + ' where Id = '+ cId;
            HebcalIntegration.convertFromGregorianToHebrew(call,q,p.hebrewDatename);
            
        }
    }
}