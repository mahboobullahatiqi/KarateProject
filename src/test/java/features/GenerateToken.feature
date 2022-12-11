Feature: Token Generator for Insurance API
	
  Scenario: Generate a toekn for CSR portal
    Given url "https://tek-insurance-api.azurewebsites.net"
    When path "/api/token"
    * request {"username":"supervisor", "password":"tek_supervisor"}
    * method post
    * print response.token
    * print response.fullName
    * status 200
    
