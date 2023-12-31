![Static Badge](https://img.shields.io/badge/Latest%20Version-V0.0.0-7289da?style=for-the-badge)
![Static Badge](https://img.shields.io/badge/Ruby%20Version-3.2.2-lightcoral?style=for-the-badge&logo=ruby)

# LiveNUS Server

API Backend for LiveNUS forum. The api is designed to implement the required features of the JSON-API specification.
Data returned from each of the API’s endpoint will be in JSON-API format. You can find additional information about
the specification [here](https://jsonapi.org/).

## System dependencies
- MySQL Database

## Setup and installation

### Development
To get the Rails server running locally:

1. Clone this repo
2. `bin/setup` to install all required dependencies and setup the database
3. `rails s` to start the local server

The api server will be started on port 3000 by default. Use `-p [port number]` to specify a different port.

### Deployment
TBA

## Overview

### Dependencies
- [mysql2](https://github.com/brianmario/mysql2) - To use mysql as database for Active Record
- [devise](https://github.com/heartcombo/devise) - For implementing authentication
- [devise-api](https://github.com/nejdetkadir/devise-api) - For generating and validating access and refresh tokens
for authentication.
- [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) - For rendering JSON output in [JSON:API](https://jsonapi.org/) specification

### Dev Dependencies
- [faker](https://github.com/faker-ruby/faker) - For seeding the database with fake data

### Authorization
In order for the API to accept a request, you will need to send an Access Token via the Authorization header.
The authorization string will look like this, where $access-token is the user's personal temporary token:
```"Authorization: Bearer $access-token"```

To obtain an access token, make a POST request to the `sign_in` endpoint. For example:
```curl
curl --location --request POST 'http://127.0.0.1:3000/api/v1/tokens/sign_in' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@testuser.com",
    "password": "123456"
}'
```
An access token and refresh token will be generated and returned to you. It is suggested to store the access token in
memory and the refresh token in storage.
An access token will be valid for **1 hour** and the refresh token **1 week**.

Upon expiration of the access token, a request can be made via the `refresh` endpoint with the refresh token. For example:
```curl
curl --location --request POST 'http://127.0.0.1:3000/api/v1/tokens/refresh' \
--header 'Authorization: Bearer <refresh_token>'
```

### Endpoints

| Prefix              | Verb      | URI Pattern               | Detail                                  |
|---------------------|-----------|---------------------------|-----------------------------------------|
| revoke_user_tokens  | POST      | /api/v1/tokens/revoke     | Revoke a user token                     |
| refresh_user_tokens | POST      | /api/v1/tokens/refresh    | Obtain a new user access token          |
| sign_up_user_tokens | POST      | /api/v1/tokens/sign_up    | Create a new user (no auth)             |
| sign_in_user_tokens | POST      | /api/v1/tokens/sign_in    | Obtain a user access and refresh token  |
| info_user_tokens    | GET       | /api/v1/tokens/info       | Get user into of the access token       |
| get_categories      | GET       | /api/v1/categories        | Fetch all categories                    |
| get_category        | GET       | /api/v1/categories/:id    | Fetch a specific category and its posts |
| get_posts           | GET       | /api/v1/posts             | Fetch all posts (no auth)               |
| create_post         | POST      | /api/v1/posts             | Create a new post                       |
| get_post            | GET       | /api/v1/posts/:id         | Fetch a specific post and its comments  |
| update_post         | PATCH/PUT | /api/v1/posts/:id         | Update a specific post                  |
| delete_post         | DELETE    | /api/v1/posts/:id         | Delete a specific post                  |
| like_post           | POST      | /api/v1/posts/:id/like    | Like a specific post                    |
| vote_post           | POST      | /api/v1/posts/:id/vote    | Vote on a specific post                 |
| create_comment      | POST      | /api/v1/comments          | Create a new comment                    |
| get_comment         | GET       | /api/v1/comments/:id      | Fetch a specific comment                |
| update_comment      | PATCH/PUT | /api/v1/comments/:id      | Update a specific comment               |
| delete_comment      | DELETE    | /api/v1/comments/:id      | Delete a specific comment               |
| like_comment        | POST      | /api/v1/comments/:id/like | Like a specific comment                 |
| vote_comment        | POST      | /api/v1/comments/:id/vote | Vote on a specific comment              |

You can look up the [example requests](#example-api-requests).

### Example API requests

#### Sign up
```curl
curl --location --request POST 'http://127.0.0.1:3000/api/v1/tokens/sign_up' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@testuser.com",
    "password": "123456"
}'
```

#### Get all posts
```curl
curl --location --request GET 'http://127.0.0.1:3000/api/v1/posts'
```

#### Create a post
```curl
curl --location --request POST 'http://127.0.0.1:3000/api/v1/posts' \
--header 'Authorization: Bearer <access_token>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "title": "Hello world!",
    "body": "Hello! This is my post body!",
    "category_id": 1
}'
```

#### Like a comment
```curl
curl --location --request POST 'http://127.0.0.1:3000/api/v1/comments/123/like' \
--header 'Authorization: Bearer <access_token>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "like": 1
}'
```

## Issues
If you run into any issues, please open a new issue on the github repository
