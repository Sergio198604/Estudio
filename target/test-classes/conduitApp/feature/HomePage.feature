@debug
Feature: Test for the home page

Background: Define URL
    Given url apiUrl

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['eos', 'est']
        And match response.tags !contains 'hola'
        And match response.tags contains any ['fish', 'dog', 'repellat']
        And match response.tags == "#array"
        And match each response.tags == "#string"
   
    Scenario: Get 10 articles from the page
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 264
        And match response.articlesCount != 100
        And match response == {"articles": "#array", "articlesCount": 264}
        And match response.articles[0].createdAt contains '2024'
        And match response.articles[*].favoritesCount contains 0
        And match response.articles..bio contains null
        And match each response..following == false
