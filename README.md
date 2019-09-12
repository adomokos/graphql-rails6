## Learning about GraphQL with Rails 6

Learning about GraphQL from [here](https://www.howtographql.com/graphql-ruby/1-getting-started/).

### Examples:

To create a link (after a signed in user):

```
mutation {
  createLink(
    url: "http://localhost:3000/graphql",
    description: "Your testing playground",
  ) {
    id
    url
    description
    postedBy {
      id
      name
    }
  }
}
```

To create a user:

```
mutation {
  createUser(
    name: "Test User",
    authProvider:{
      email:{
        email: "test@example.com",
        password: "123456"
      }
    }
  ) {
    id
    email
    name
  }
}
```

To sign in a user:

```
mutation {
  signinUser(
    email: {
      email:"test@example.com",
      password:"123456"
    }
  ) {
    token
    user {
      id
    }
  }
}
```

Create a Vote:

```
mutation {
  createVote(linkId:"1") {
    link {
      description
    }
    user {
      name
    }
  }
}
```

Get all votes:

```
query {
  allLinks {
    votes {
      id
    }
  }
}
```

Same with more info:

```
query {
  allLinks {
    id
    postedBy {
      createdAt
      name
      votes {
        link {
          description
        }
      }
    }
  }
}
```
