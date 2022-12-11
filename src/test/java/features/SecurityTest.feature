Feature: Verify TEK Insurance Token 
 
 
 Background: 
  Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * path "/api/token/verify"
    
 Scenario: Verify Valid Token

    * param token = tokenValue
    * param username = "supervisor"
    * method get
    * status 200
		* print response == "true"
		
 @tokenValidation
 Scenario: Verify invalid username
 * param token = tokenValue
 * param username = "teacher"
 * method get
 * print response
 * status 400
   