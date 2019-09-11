# README

Learning about GraphQL from [here](https://www.howtographql.com/graphql-ruby/1-getting-started/)

### Examples:

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
