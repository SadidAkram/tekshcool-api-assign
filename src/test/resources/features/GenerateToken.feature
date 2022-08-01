Feature: Token Generator

Background: prepare for test. generate token.
  Scenario: Generate valid token wtih CSR supervisor user
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request { "username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
