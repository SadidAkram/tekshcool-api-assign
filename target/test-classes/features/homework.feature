# Test API end point '/api/accounts/add-primary-account' to add new account with existing email address
# then status code should be 400 - bad request validate response
Feature: test api endpoint with existing email address to add new account

  Background: 
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request { "username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token

  Scenario: Api test to add new account with existing email
    Given path '/api/accounts/add-primary-account'
    And request
      """
      {
      "email": "asdfj786@gmail.com",
      "firstName": "Karimi",
      "lastName": "Karimi",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "1998-12-23"
      }
      """
    And header Authorization = 'Bearer ' + generatedToken
    When method post
    Then status 400
    * def errorMessage = response.errorMessage
    * def httpStatus = response.httpStatus
    And assert errorMessage == 'Account with Email asdfj786@gmail.com is exist'
    And assert httpStatus == 'BAD_REQUEST'

  #2 Test API endpoint 'api/accounts/add-account-car' to add car to existing account
  # Then status code should be 201 created and validate response
  Scenario: test api to add car into an existing account
    Given path '/api/accounts/add-account-car'
    And param primaryPersonId  = '1860'
    And request
      """
      {
      "make": "Toyota",
      "model": "Corolla",
      "year": "2015",
      "licensePlate": "231MS"
      }
      """
    And header Authorization = 'Bearer ' + generatedToken
    When method post
    Then status 201
    And print response

  #2 Test API endpoint 'api/accounts/add-account-phone' to add phone to existing account
  # Then status code should be 201 created and validate response
  Scenario: add phone to existing accounting
    Given path '/api/accounts/add-account-phone'
    And param primaryPersonId = '1859'
    And request
      """
      {
      
      "phoneNumber": "12344321",
      "phoneExtension": "N/A",
      "phoneTime": "Any Time",
      "phoneType": "Mobile"
      }
      """
    And header Authorization = 'Bearer ' + generatedToken
    When method post
    Then status 201
    And print response
