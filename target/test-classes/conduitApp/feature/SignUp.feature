@debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl
   
    Scenario: New user Sign Up
        Given path 'users'
        And request
        """
            {
                "user": { 
                    "email": #(randomEmail),
                    "password": "clave7890",
                    "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 201
        And match response ==
        """
            {
                "user": {
                    "id": #number,
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image":"#string",
                    "token": "#string"
                }
            }
        """
@parallel=false
Scenario Outline: Validate Sign Up error messages
        Given path 'users'
        And request
        """
            {
                "user": { 
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <erromessages>

        Examples:
            | email             | password  | username          | erromessages                                       |
            | #(randomEmail)    | karate123 | fomekutest0222    | {"errors":{"username":["has already been taken"]}} |
            | test22234@test.cl | karate123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
            |                   | karate123 | fomekutest0222    | {"errors":{"email":["can't be blank"]}}            |
            | #(randomEmail)    |           | #(randomUsername) | {"errors":{"password":["can't be blank"]}}         |
            | #(randomEmail)    | karate123 |                   | {"errors":{"username":["can't be blank"]}}         |
