Feature: Add a car request

  @addCar
  Scenario: Add car to the account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
    * def postRequest = call read("PostRequestTest.feature")
    * def idValue = postRequest.response.id
    * param primaryPersonId = idValue
    * path "api/accounts/add-account-car"
    * request
      """
      {
      "id": 0,
      "make": "Toyota",
      "model": "Corolla",
      "year": "2023",
      "licensePlate": "PJR-123"
      }
      """
    * method post
    * match 
    * print response
