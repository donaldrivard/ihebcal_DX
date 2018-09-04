@isTest
global class HttpCalloutAfterSunsetMock  implements HttpCalloutMock {


     global HttpResponse respond(HttpRequest req) {
        // Create a fake response
        //Yes
        System.debug('HebCalCalloutMock req '+ req);
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"gy": 2011,"gm": 6,"gd": 2,"hy": 5723,"hm": "Cheshvan","hd": 26,"hebrew": "כ״ו בְּחֶשְׁוָן תשכ״ג","events": ["Parashat Chayei Sara"]}}');
        res.setStatusCode(200);
        return res;
      //Test
      }

}