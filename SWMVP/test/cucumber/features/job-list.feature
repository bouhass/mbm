Feature: Job list

  Background:
    Given I open the job list page

  Scenario: new nursing job entry
    When I add "Blood tests" as a NURSE job to JOSH KNIGHT
    Then I should see "Blood tests" as a NURSE job assigned to JOSH KNIGHT

  Scenario: new doctor job entry
    When I add "X-Rays" as a DOCTOR job to ANISH LEE
    Then I should see "X-Rays" as a DOCTOR job assigned to ANISH LEE
