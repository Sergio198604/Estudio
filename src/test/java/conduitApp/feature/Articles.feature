
Feature: Articles

Background: Define URL
    Given url 'https://api.realworld.io/api/'

Scenario: Create a new article
    Given path 'users/login'
    And request  {"user": {"email": "testkarate1@test.cl","password": "clave123456"}}   
    When method Post
    Then status 200
    * def token = response.user.token

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"title": "test0.1","description": "agwqsa","body": "wqrtegds","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'test0.1'