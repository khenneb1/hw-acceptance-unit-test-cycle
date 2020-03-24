Feature: User can manually delete movie

Scenario: Delete a movie  
  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  And I am on the RottenPotatoes home page
  Then I should see "Aladdin" 
  When I go to the details page for "Aladdin"
  And I press "Delete"
  Then I should be on the RottenPotatoes home page
  And I should see "Movie 'Aladdin' deleted."