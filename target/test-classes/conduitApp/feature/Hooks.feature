@debug
Feature: Hooks

Background: hooks
    * def result = callonce read('classpath:helpers/Dummy.feature')
    * def username = result.username

    #after hokks
    * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }


Scenario: First scenario
    # * print username
    * print 'This is first scenario'

Scenario: Second scenario
    # * print username
    * print 'This is second scenario'