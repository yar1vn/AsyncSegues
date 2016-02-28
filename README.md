# AsyncSegues
An example to perform segues combined with async data loading

Use `func performSegueWithIdentifier(segueIdentifier:, sender:, prepareBlock:)` after the data loading process is complete. In `prepareBlock` you should put the same code you would in `prepareForSegue:` without the need to check the identity of the segue.

##Example

```swift
self.performSegueWithIdentifier(.ShowLogo, sender: indexPath) { segue, sender in
    if let vc = segue.destinationViewController as? ImageContainer {
        vc.image = image
    }
}
```

Using this method with the closure prevents the need to do something like this, normally resulting in instantiation of disparate view controllers in a single lengthy function:

```swift
func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "foo" {
      if let vc = segue.destinationViewController as? ViewControllerFoo {
          vc.foo = self.foo
      }
    } else if segue.identifier == "bar" {
      if let vc = segue.destinationViewController as? ViewControllerBar {
          vc.bar = self.bar
      }
    } else if segue.identifier == "baz" {
      if let vc = segue.destinationViewController as? ViewControllerBaz {
          vc.baz = self.baz
      }
    }
}

```

This block will also trap local variables, including the recently loaded data model object so there's no need to keep a reference outside of this scope.

__Pull requests and comments are appreciated__
