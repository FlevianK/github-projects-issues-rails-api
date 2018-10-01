# GITHUB Project and Issue APIs

This is an app that consumes the github API.

## Installation

- Make sure you have Ruby 2.5.0 and Rails installed on your machine

- Use github username and password as env variables

- Create and run migrations. `rails db:create` and `rails db:migrate`

- Start the application: `rails s`

| EndPoint                       |   Functionality                                                |
| -------------------------------| --------------------------------------------------------------:|
| POST /projects                 | Create a project locally and Sync with GitHub                  |
| PATCH /projects/:id            | Update a project locally and Sync with GitHub                  |
| GET /projects/                 | Fetch ALL projects created locally and their repos from GitHub |
| POST /issues                   | Create an Issue locally and Sync with GitHub                   |
| PATCH /issues/:id              | Update an Issue locally and Sync with GitHub                   |
| GET /projects/:id/issues       | Fetch ALL project issues                                       |


## Limitations

  1. The API only responds with JSON

## Author
  1. Flevian Kanaiza
