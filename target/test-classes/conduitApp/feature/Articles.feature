Feature: Articles
Background: Define URL
    Given url apiUrl

Scenario: Create a new article
    Given path 'articles'
    And request {"article": {"title": "bye11234","description": "agwqsa","body": "wqrtegds","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'bye11234'

Scenario: Create and delete article
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

    Given path 'articles',articleId
    When method Delete
    Then status 204
    #And match response.article[0].title != 'Delete Article 4'
    
    