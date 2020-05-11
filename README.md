# TAuthProxy

A simple proxy for developing mobile apps against [Teller](https://teller.io).

[TAuth](https://blog.teller.io/2016/04/26/tauth.html) (basically OAuth 2.0 implicit grant + mutual TLS) is mandatory for production deployments, i.e. users authorising your app using **Login with Teller**. We currently only sign certificates for server applications, which right now makes a server component a requirement for Teller apps using TAuth. In the future we will sign certificates for mobile apps and ship SDKs to completely abstract everything away, making this project redundant.

This project is intended as a demonstrative guide or starting point for how to build mobile apps with TAuth and/or how to implement TAuth in your server apps.

## Getting started

- Create a [Teller TAuth Application](https://teller.io/developer/applications/new) and request a certificate
- This project is written in Elixir, so you will need to [install](http://elixir-lang.org/install.html) it if you don't have it already.
- Clone this repo
- Save `certificate.pem` and `private_key.pem` in the `/priv` subdirectory of this project
- Update `config.exs` with your application settings
- Run locally or deploy, e.g. to [Heroku](https://heroku.com)
- Point your application at your deployment

## Endpoints

- `/api/*` - proxies everything to Teller via a TAuth mutally authenticated TLS connection, e.g. `/api/accounts` proxies to `https://api.teller.io/accounts`
