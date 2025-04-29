public with sharing class uploadtanks {
    @AuraEnabled
    public static String createTanks(List<Map<String, Object>> tanksData) {
        try {
            List<Tipo_de_tanque__c> tanksToInsert = new List<Tipo_de_tanque__c>();

            for (Map<String, Object> tank : tanksData) {
                Tipo_de_tanque__c newTank = new Tipo_de_tanque__c();
                newTank.Name = (String) tank.get('Name');
                newTank.Marca__c = (String) tank.get('Marca__c');
                newTank.Capacidad__c = (Decimal) tank.get('Capacidad__c');
                newTank.Precio_de_lista__c = (Decimal) tank.get('Precio_de_lista__c');

                tanksToInsert.add(newTank);
            }

            insert tanksToInsert;
            return 'Success'; // <-- correcto

        } catch (Exception e) {
            return 'Error al crear los tanques'; // <-- correcto
        }
    }
}