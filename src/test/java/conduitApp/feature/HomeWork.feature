@debug
Feature: Articles

Background:
    * url apiUrl
    Given path 'articles'
    Given params {limit:10, offset:0}
     When method get
      And status 200
    * def id = response.articles[0].slug
    * def count = response.articles[0].favoritesCount
    * def title = response.articles[0].title
    * print "Fav Count is " + count
   
Scenario: Increase fav count
    *  def timeValidator = read('classpath:helpers/timeValidator.js')
    Given path 'articles/' + id +'/favorite'
      And request {}
     When method post
      And status 200
      And match response.article.favoritesCount == 1
      And match response  ==
    """
            {
            "article": {
            "author": {
            "image": "#string",
            "following": "#boolean",
            "bio":"##string",
            "username": "#string"
            },
            "description": "#string",
            "title": #(title),
            "body": "#string",
            "authorId": "#number",
            "favoritesCount": "#number",
            "tagList": [
            ],
            "createdAt": "#? timeValidator(_)",
            "favoritedBy": [
            {
                "image": "#string",
                "password": "#string",
                "bio": null,
                "id": "#number",
                "demo": "#boolean",
                "email": "#string",
                "username": "#string"
            }
            ],
            "id": "#number",
            "slug": #(id),
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean"
            }
            }
    """
    Given path 'articles/' + id
     When method get
      And status 200
         * print response
      And match response.article.favoritesCount == count + 1