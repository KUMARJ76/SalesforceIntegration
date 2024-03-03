@RestResource(urlMapping='/v1/DemoWelcomeMessage')
global with sharing class DemoWelcomeMessage {
    global Final static String Welcome_Message='Welcome to Learn Rest Service in Salesforce';

    @httpGet
    global static String greetingMessage () {
        return Welcome_Message;

    }
}