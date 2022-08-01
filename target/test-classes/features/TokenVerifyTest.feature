# Generate a valid token and verify it with below requirmenet
# test api endpoint '/api/token/verify' with valid token
# status should be 200 - OK and response is true
Feature: Security test. verify token test

  Scenario: Generate a valid token and verify the token
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request { "username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path '/api/token/verify'
    And param token = generatedToken
    And param username = 'supervisor'
    When method get
    Then status 200
    And print response

  # test api endpoint '/api/token/verify' with invalid token
  # note since its is invalid token it can be any random string. you do not need to generate a new token
  # status should be 400 - bad request and response is Token expired
  Scenario: test api endpoint with invalid token
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token/verify'
    And param token = 'invalid-token-random-string'
    And param username = 'supervisor'
    When method get
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    * def httpStatus = response.httpStatus
    And assert errorMessage == 'Token Expired or Invalid Token'
    And assert httpStatus == 'BAD_REQUEST'

  # test api end point '/api/token/verify' with valid token
  # and invalid user then status should be 400
  # and errormessage = Wrong Username send along with token
  Scenario: test api with valid token and invalid user
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request
      """
      {
       "username": "supervisor",
       "password": "tek_supervisor"
      }

      """
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path '/api/token/verify'
    And param token = generatedToken
    And param username = 'invalid'
    When method get
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == 'Wrong Username send along with Token'

  #Homework
  #Test API endpoint 'api/account/add-primary-account' to add new account
  # then status should be 201 created with response containing id for generated primary person
  Scenario: test api ender point to add new account on account primary account
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request { "username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path '/api/accounts/add-primary-account'
    And request
      """
      {
      "email": "asdfj786@gmail.com",
      "firstName": "Gul",
      "lastName": "Jan",
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
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
