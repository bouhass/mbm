Feature: Job list view

  Background:
    Given I open the job list page

  Scenario: new nursing job entry
    When I add "Blood tests" as a NURSE job to JOSH KNIGHT
    Then I should see "Blood tests" as a NURSE job assigned to JOSH KNIGHT as PENDING

  Scenario: new doctor job entry
    When I add "X-Rays" as a DOCTOR job to ANISH LEE
    Then I should see "X-Rays" as a DOCTOR job assigned to ANISH LEE as PENDING

  Scenario: update job status
    Given I add "IV fluids" as a NURSE job to JOSEPH LOVE
    When I click on the status of the "IV fluids" NURSE job assigned to JOSEPH LOVE
    Then I should see "IV fluids" as a NURSE job assigned to JOSEPH LOVE as STARTED
    And I click on the status of the "IV fluids" NURSE job assigned to JOSEPH LOVE
    Then I should see "IV fluids" as a NURSE job assigned to JOSEPH LOVE as COMPLETED
    And I click on the status of the "IV fluids" NURSE job assigned to JOSEPH LOVE
    Then I should see "IV fluids" as a NURSE job assigned to JOSEPH LOVE as PENDING

  Scenario: delete job
    Given I add "ECG" as a DOCTOR job to JOSH KNIGHT
    When I click on delete JOSH KNIGHT "ECG" DOCTOR job
    Then I should not see "ECG" as a DOCTOR job assigned to JOSH KNIGHT
