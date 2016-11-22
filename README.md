# README

This is simple social networking site, it is similar to teamtreehouse treebook application
However the original tutorial was built using an earlier ruby and rails version. I have tried to create the application using Ruby 2.3.0 and rails 5.0.0.1.
The application has the functionality of CRUD status' adding and removing friends. I have also included devise-confirmable in production

Things you may want to cover:

* Ruby version -2.3.0

* Rails version - 5.0.0.1

* Additional gems used - Bootstrap-sass, Devise, Devise-bootstrapped, simple_form, state-machine-activerecord

* Database development - sqlite

* Database production - pg

* While I was trying this old tutorial there has been compatibility issues with draper gem and js-routes (in heroku) with Rails 5.0.0.1. 

* Deployment instructions - git clone bundle install --without production, db:migrate and run server.

* Deployment instructions Production - I have used my gmail account for using devise confirmable it would be easier to use sendgrid addon in heroku. To use gmail smtp, you will have to add config Var directly into Heroku or you can use a figaro gem
