@ignore 
Feature: Sign up new user

    Background: Preconditions
        Given url apiUrl
    @debug
    Scenario: New user Sign up
        Given def userData = {"email":"testkarate0.1@test.cl","password": "clave7890","username":"fomekutest0.1"}}
    
        Given path 'users'
        And request
        """
            {
                "user": { 
                "email": #(userData.email),
                "password": "clave7890",
                "username": #(userData.username)
                }
            }
        """
        When method Post
        Then status 201