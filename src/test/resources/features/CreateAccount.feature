Feature: Create account wiht data Generator

  Background: 
   Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request { "username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token


  Scenario: Create new Account ussing data generator
    * def generator = Java.type ('tiger.api.test.fake.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    And print email
    And print firstName
    And print lastName
    Given path '/api/accounts/add-primary-account'
    And request
      """
      {
      "email": "#(email)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "title": "Mrs.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "tekSchoolStudent",
      "dateOfBirth": "2000-12-23"
      }
      """
    And header Authorization = 'Bearer ' + generatedToken
    When method post
    Then status 201
    And print response
    And assert response.email == email
    
