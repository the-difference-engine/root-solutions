# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Setup:

brew install imagemagick
gem install rmagick
rake db:create
rake db:migrate
brew update
brew cask install java
brew install elasticsearch

to run, type 'elasticsearch' into bash
then start rails server

Search:

Users can search simply by keyword or using a filter system.
Users can do a filtered search by the following tag dropdowns: Environmental Issues, Behavioral Building Block, Cognitive Bias, World Region, and Resource Type.
Search results will be returned in one of four formats, depending on the resource type: Definition, Case Studies, Academic Articles, Popular Articles.
Definition is a paragraph.
Case Studies is a paragraph, followed by citation and a link to the resource, as well as metadata tied to the resource.
Academic Articles have a title, an abstract and a summary. *note: since publishing rights are required for academic articles, you will be provided with where to access the article.
Popular articles are links, author, publishing date and publication.
