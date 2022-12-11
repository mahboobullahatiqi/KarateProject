Feature: Add Address

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue

  @addAddress
  Scenario: Add address to the account
    * path "api/accounts/add-account-address"
    * def postRequest = call read("PostRequestTest.feature")
    * def idValue = postRequest.response.id
    * param primaryPersonId = idValue
    * request
      """
      {
        "id": 0,
        "addressType": "Home",
        "addressLine1": "9190 Tuolumne Dr",
        "city": "Sacramento",
        "state": "CA",
        "postalCode": "95826",
        "countryCode": "001",
        "current": true
      }
      """
    * method post
    * match response.addressType == "Home"
    * match response.city == "Sacramento"
    * match response.state == "CA"
    * print response
