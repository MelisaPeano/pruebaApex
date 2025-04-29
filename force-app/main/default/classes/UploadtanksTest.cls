@isTest
private class UploadtanksTest { 

    @isTest
    static void testCreateTanks() {
        // Preparamos datos de prueba
        List<Map<String, Object>> fakeTanks = new List<Map<String, Object>>();
        
        Map<String, Object> tank1 = new Map<String, Object>{
            'Name' => 'TestTank1',
            'Marca__c' => 'TestMarca',
            'Capacidad__c' => 500,
            'Precio_de_lista__c' => 1000
        };
        fakeTanks.add(tank1);
        uploadtanks.createTanks(fakeTanks);
        
        // Llamamos al método que queremos testear
        Test.startTest();
        String result = uploadtanks.createTanks(fakeTanks);
        Test.stopTest();
        
        // Verificamos que devolvió 'Success'
        System.assertEquals('Success', result);
    }
}
