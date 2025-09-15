Feature: Operaciones con mascotas

  Background:
    * url 'https://petstore.swagger.io'

  Scenario: Buscar mascota por Id
    * def result = call read('create_pet.feature')
    * def petId = result.petId
    * print 'Buscando mascota con ID:', petId
    Given path '/v2/pet/', petId
    When method get
    Then status 200
    And match response.id == petId
    And match response.name == result.petName

  Scenario: Buscar mascotas por status

    Given path '/v2/pet/findByStatus'
    And param status = 'sold'
    When method get

    Then status 200
    And match each response[*].status == 'sold'
