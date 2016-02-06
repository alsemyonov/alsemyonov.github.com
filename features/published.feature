Feature: Unpublished site section
  Scenario: Unpublished site sections show up in the preview server
    Given current application
    And the Server is running in :development environment
    When I go to "/"
    Then I should see "Environment: development"
    When I go to "/about/"
    Then I should not see "File Not Found"
    When I go to "/index.atom"
    Then I should not see "File Not Found"
    Then I should see "http://www.w3.org/2005/Atom"
    When I go to "/index.rss"
    Then I should not see "File Not Found"
    Then I should see "http://www.w3.org/2005/Atom"
    When I go to "/about/webmaster.html"
    Then I should see "Webmaster Tools"

  Scenario: Unpublished site sections are hidden in :production environment by default
    Given current application
    And the Server is running in :production environment
    When I go to "/"
    Then I should not see "Environment: development"
    Then I should see "Environment: production"
    When I go to "/index.atom"
    Then I should not see "File Not Found"
    Then I should see "http://www.w3.org/2005/Atom"
    When I go to "/index.rss"
    Then I should not see "File Not Found"
    Then I should see "http://www.w3.org/2005/Atom"
    When I go to "/about/webmaster.html"
    Then I should not see "Webmaster Tools"
    Then I should see "File Not Found"

  Scenario: Unpublished site sections don't get built in production environment
    Given current application
    And a successfully built in :production environment app
    When I cd to "build"
    Then the file "index.html" should contain "Environment: production"
    Then the following files should not exist:
      | sitemap.html          |
      | about/webmaster.html  |
    Then the following files should exist:
      | index.html            |
      | index.atom            |
      | index.rss             |
      | cv/index.html         |

  Scenario: Unpublished site sections get built in development environment
    Given current application
    And a successfully built in :development environment app
    When I cd to "build"
    Then the file "index.html" should contain "Environment: development"
    Then the following files should exist:
      | index.html            |
      | index.atom            |
      | index.rss             |
      | sitemap.html          |
      | about/webmaster.html  |
      | index.html            |
      | cv/index.html         |
