Feature: Schema Validation e
  @schemaValidation
  Scenario: Get Account Test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
    * path "/api/accounts/get-primary-account"
    * param primaryPersonId = 2521
    * method get
    * print response
    * status 200
   * match response == 
   """
   {
      "email": "#(email)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "title": "Mr",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "IT",
      "dateOfBirth": "#(dateOfBrith)"
      }
     """
     * def idValue = response.id
     * match idValue == '#number'
    
