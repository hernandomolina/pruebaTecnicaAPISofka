Feature: Crear mascota

  Background:
    * url 'https://petstore.swagger.io'

  Scenario Outline: crear una mascota mediante el servicio de creacion de mascotas
    * def petId = Math.floor(Math.random() * 100000) + 100000
    * def petName = '<petName>'
    * def petStatus = '<petStatus>'
    * def requestBody = read('data/create_modify_pet_request.json')

    Given path '/v2/pet'
    And request requestBody
    When method post
    Then status 200
    And match response.id == petId
    And match response.name == petName
    And match response.status == petStatus

    * def createdPetId = response.id
    * print 'pet id creado:', createdPetId

    Given path '/v2/pet/', createdPetId
    When method get
    Then status 200
    And match response.id == createdPetId
    
    * def result = { petId: createdPetId, petName: petName, petStatus: petStatus }

    Examples:

      | petName   | petStatus   |
      | Firulais  | available   |

