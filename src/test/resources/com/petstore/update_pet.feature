Feature: Modificar mascota

  Background:
    * url 'https://petstore.swagger.io'

  Scenario: Modificar una mascota mediante el servicio de modificacion de mascotas
    * def createResult = call read('create_pet.feature')
    * def petId = createResult.petId
    * def petName = 'Rocco'
    * def petStatus = 'sold'
    * print 'Modificando mascota con ID:', petId

    Given path '/v2/pet'
    And request read('data/create_modify_pet_request.json')
    When method put
    Then status 200

    * print 'pet id modificado:', petId
    And match response.id == petId
    And match response.name == petName
    And match response.status == petStatus

    Given path '/v2/pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And match response.id == petId
    And match response.name == petName
    And match response.status == petStatus
