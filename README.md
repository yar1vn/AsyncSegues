# AsyncSegues
An example to perform segues combined with async data loading

Use `func performSegueWithIdentifier(segueIdentifier:, sender:, prepareBlock:)` after the data loading process is complete. 
In `prepareBlock` you should put the same code you would in `prepareForSegue:` but not need to check which segue that is. 
This block will also trap local variables, including the recetly loaded data model object so there's no need to keep a refenrece outside of this scope.
