Feature: Articles

Background: Define URL
    Given url 'https://api.realworld.io/api/'
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email": "testkarate1@test.cl","password": "clave123456"}
    * def token = tokenResponse.authToken

Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"title": "hola","description": "agwqsa","body": "wqrtegds","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'hola'
@debug
Scenario: Create and delete article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"title": "Delete article 5","description": "agwqsa","body": "wqrtegds","tagList": []}}
    When method Post
    Then status 201
    * def articleId = response.article.slug
 
    #Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    #And match response.article[0].title == 'Delete Article 3'

    Given header Authorization = 'Token ' + token
    Given path 'articles',articleId
    When method Delete
    Then status 204
    #And match response.article[0].title != 'Delete Article 4'
    
    