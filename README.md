##Deployment instructions

###Setup:

1. `brew install imagemagick` 
2. `gem install rmagick` 
3. `rake db:create`
4. `rake db:migrate`
5. `brew update` 
6. `brew cask install java` 
7. `brew install elasticsearch`

**note: to run search function, type 'elasticsearch' into bash then start rails server**

###Search Capabilities:

1. Users can search by keyword or using a filter system.
2. Users can do a filtered search by the following tag dropdowns: Environmental Issues, Behavioral Building Block, Cognitive Bias, World Region, and Resource Type.
3. Search results will be returned in one of four formats, depending on the resource type: Definition, Case Studies, Academic Articles, Popular Articles.
4. Definitions are returned in paragraph form.
5. Case Studies are in paragraph form, followed by citation and a link to the resource, as well as metadata tied to the resource. 
6. Academic Articles have a title and a summary. 

**note: since publishing rights are required for academic articles, you will be provided with where to access the article. Popular articles have links with information regarding author, publishing date, and publication.**


###GUI New Resource Readme:

1. Once logged in to website, select the resources tab
2. Scroll to the bottom of the resources page and select the 'Add New' button.
3. Fill in all the requested information and select 'Create'.
