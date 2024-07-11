
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl
    @debug
    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()  
    
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
                    "id": '41175',
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image":" https://api.realworld.io/images/smiley-cyrus.jpeg",
                    "token": "#string"
                }
            }
        """