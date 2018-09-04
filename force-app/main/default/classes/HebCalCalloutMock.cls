@isTest
global class HebCalCalloutMock implements HttpCalloutMock {


     global HttpResponse respond(HttpRequest req) {
        // Create a fake response

        System.debug('HebCalCalloutMock req '+ req);
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"gy": 2011,"gm": 6,"gd": 2,"hy": 5771,"hm": "Cheshvan","hd": 25,"hebrew": "כ״ה בְּחֶשְׁוָן תשכ״ג","events": ["Parashat Chayei Sara"]}}');
        res.setStatusCode(200);
        return res; 
      
      }

      }