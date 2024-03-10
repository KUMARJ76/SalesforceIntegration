public with sharing class WeatherApiCallout {
    public static void getWeather(String city) {
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        //callout:namedCredential
        //https://api.weatherapi.com/v1/current.json?key=5f219b24ee4149119f1185858240903&q=pune
        request.setEndpoint('callout:weatherApi/v1/current.json?q='+city);
        request.setMethod('GET');
        HttpResponse response=http.send(request);
        Integer statusCode=response.getStatusCode();
        if(statusCode==200){
        System.debug(response.getBody());
        }
        else{
            System.debug('Error'+response.getBody());
        }

    }
}