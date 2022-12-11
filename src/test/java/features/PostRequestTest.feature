Feature: Post Request Tests

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
    * path "/api/accounts/add-primary-account"

  @postRequest
  Scenario: Verify Post Request Method
    * request
      """
      {
      
      "email": "pjr123456343276@pjr.com",
      "firstName": "PJRTEK",
      "lastName": "PJRPANTHER",
      "title": "MR",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "IT",
      "dateOfBirth": "2022-11-30"
      }
      """
    * method post
    * status 201
    * print response
    
    
    @postCall
  Scenario: post Request with Faker data
    #first we need to define a varialbe o read the java class
    #second we need to define a variable to call each static method from that class
    * def generator = Java.type("api.test.DataGenerator")
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def dateOfBrith = generator.getDob()
    * def titleOfPerson = generator.getTitle()
    * request
      """
      {
      
      "email": "#(email)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "title": "#(titleOfPerson)",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "IT",
      "dateOfBirth": "#(dateOfBrith)"
      }
      """
      * method post
    * status 201
    * print response
    * match response.email == email
    * match response.firstName == firstName
    * match response.lastName == "#(lastName)"
    * match response.lastName != firstName
    * print response
