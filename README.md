# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:
* Docker
  please use: docker-compose up

* OAUTH2
   Standard OAUTH2 client_credentials flow

   POST   /oauth/token
   params:
   {
    "client_id": "example",
    "client_secret": "example",
    "grant_type": "client_credentials",
    "scopes": ""
   }

   Check client id and secet afterr seeding data in Doorkeeper::Application

   Retruns OAUT2 token with default expiration time

   Resource Auth
   Include header:
   Authorization: Bearer example_token

* Database initialization

  rake verbose seeds:data

