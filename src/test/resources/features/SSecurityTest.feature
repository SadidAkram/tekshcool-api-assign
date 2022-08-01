@Smoke
Feature: Security test

  @Smoke
  Scenario: token gernation with valid user and password
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  # test api endpoint '/api/token' with invalid username and valid password
  # status cod should be 404 not found response with error.
  # and response errorMessage is "USER_NOT_FOUND"
  @Smoke @Regression
  Scenario: token genreation with invalid user and valid password
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "invalid", "password": "tek_supervisor"}
    When method post
    Then status 404
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == 'USER_NOT_FOUND'

  # Test API end point '/api/token' with valid user and invalid password
  # status code should be 400
  # response message should be 'errorMessage: "password not matched".
  @Smoke
  Scenario: generate token with valid user and invalid password
    Given url 'https://tek-insurance-api.azurewebsites.net'
    And path '/api/token'
    And request {"username": "supervisor", "password": "invalid"}
    When method post
    Then status 400
    * def errorMessage = response.errorMessage
    And assert errorMessage == 'Password Not Matched'
