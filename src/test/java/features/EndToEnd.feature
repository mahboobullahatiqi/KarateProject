Feature: End to End Testing of API

  @e2e
  Scenario: end to end
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
    * path "api/accounts/add-primary-account"
    * def generator = Java.type("api.test.DataGenerator")
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def dateOfBirth = generator.getDob()
    * def title = generator.getTitle()
    * def gender = generator.getGender()
    * def job = generator.getJob()
 		#* def maritalStatus = generator.getMaritalStatus()
    * request
      """
       {
      "email":"#(email)",
      "firstName":"#(firstName)",
      "lastName":"#(lastName)",
      "title":"#(title)",
      "gender":"#(gender)",
      #"maritalStatus":"#(maritalStatus)",
      "employmentStatus":"#(job)",
       "dateOfBirth": "#(dateOfBirth)"
      }
      """
    * method post
    * status 201
    * print response.id
    * match response.email == email
    * match response.firstName == firstName
    * match response.lastName == lastName
    * match response.title == title
    * match response.gender == gender
    * match response.employmentStatus == job
    * def dbresult = Java.type("api.test.DatabaseConnectionUtility")
    * def dbemail = dbresult.result("select * from primary_person where id = '" + response.id +"'", "email" )
    * def dbFirstname = dbresult.result("select * from primary_person where id = '" + response.id +"'", "first_name" )
    * def dbLastName = dbresult.result("select * from primary_person where id = '" + response.id +"'", "last_name" )
    * def dbTilte = dbresult.result("select * from primary_person where id = '" + response.id +"'", "title" )
    * def dbGender = dbresult.result("select * from primary_person where id = '" + response.id +"'", "gender" )
    #* def dbMaritalStatus = dbresult.result("select * from primary_person where id = '" + response.id +"'", "marital_status" )
    * def dbEmploymentStatus = dbresult.result("select * from primary_person where id = '" + response.id +"'", "employment_status" )
    * def dbdateOfBirth = dbresult.result("select * from primary_person where id = '" + response.id +"'", "date_of_birth" )
    * match dbemail == email
    * match dbFirstname == firstName
    * match dbLastName == lastName
    * match dbTilte == title
    * match dbGender == gender
    #* match dbMaritalStatus == maritalStatus
    * match dbEmploymentStatus == job
    * match dbdateOfBirth contains dateOfBirth
