public with sharing class TanqueController {
    @AuraEnabled(cacheable=true)
    public static List<Tipo_de_tanque__c> getTanks() {
        return [SELECT Id, Name, Marca__c, Capacidad__c, Precio_de_lista__c FROM Tipo_de_tanque__c];
    }
}