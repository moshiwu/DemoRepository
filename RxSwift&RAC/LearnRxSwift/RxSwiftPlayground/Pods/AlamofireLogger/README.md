# AlamofireLogger

Tiny Alamofire plugin that logs requests and responses.

### Examples

✓ Real, real simple, just prints the HTTP method/status code alongside the URL

```swift

Alamofire.request("http://myapi.com/users").log().responseJSON { response in
    print(response)
}

// GET http://myapi.com/users
// 200 http://myapi.com/users

```

✓ Print response bodies, too

```swift

Alamofire.request("http://myapi.com/users").log(.verbose).responseJSON { response in
    print(response)
}

// GET http://myapi.com/users
// 200 http://myapi.com/users: "[{"id": "1", "name": "Ricky"}]"

```

✓ Different logging levels for requests and responses (e.g. you might only want to print the body of your requests)

```swift

Alamofire.request(.put, "http://myapi.com/user/1", parameters: ["name": "Julian"])
    .logRequest(.verbose)
    .logResponse(.simple)
    .responseJSON { response in
        print(response)
}

// PUT http://myapi.com/user/1: "{"name":"Julian"}"
// 200 http://myapi.com/user/1

```

### Wishlist

- Additional verbosity levels, formatting options
- Pretty-printed JSON
