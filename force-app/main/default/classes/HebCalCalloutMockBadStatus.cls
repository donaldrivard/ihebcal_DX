global class HebCalCalloutMockBadStatus implements HttpCalloutMock {


     global HttpResponse respond(HttpRequest req) {
        // Create a fake response

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"Message": ERROR}');
        res.setStatusCode(500);
        return res; 
      
      }

}