ADD MISSING INDEXES TO TABLES
====================================
Create a migration to add missing indexes (detected with Rails Indexes Analyzer script)

		class AddMissingIndexesToTables < ActiveRecord::Migration
  			def self.up 
    			add_index :creditcards, :address_id
    			add_index :orders, :bill_address_id
    			add_index :orders, :ship_address_id
    			add_index :orders, :user_id 
  			end
    	
  			def self.down 
    			remove_index :creditcards, :address_id
    			remove_index :orders, :bill_address_id
    			remove_index :orders, :ship_address_id
    			remove_index :orders, :user_id 
  			end
		end

ADDITIONAL FIELD SUPPORT ENHANCEMENT
====================================

Add support for several Rails forms helpers, when you create an additional field you can now choose the type of HTML field to use.

The default helper is still `text_field` so this enhancement should work without breaking any existing code. 

Here is the list of all available helpers:

		text_field (default)
		text_area
		password_field
		file_field
		hidden_field
		check_box
		radio_button
		select

The new parameters for the config hash are:

- **:use** - The name of the helper.
- **:value** - A lambda that will be called to populate the field. This field is mandatory with `radio_button` and `select` helpers, unused  with `check_box` and optional with the others (it'll receive the controller and field as arguments just in case you need it).
- **:options** - An optional hash that can be used to pass different options ([see RailsFormsHelpers API](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html)).
- **:html_options** - An optional hash that can be used to pass options when using `select`.
- **:checked_value** - Used to set the checked value when using `check_box`, if not set the default value is 1.
- **:unchecked_value** - Used to set the unchecked value when using `check_box`, if not set the default value is 0.

Examples:
--------

This code goes in your extension class.

 - Use a check box, with default values

	 `Variant.additional_fields += [ :name => 'Display In Configurator', :only => [:product], :use => 'check_box' ]`

 - Use radio buttons, with values 'yes' and 'no'
	
	 `Variant.additional_fields += [ :name => 'Display In Configurator', :only => [:product], :use => 'radio_button', :value => lambda { |controller, field| ['yes', 'no'] } ]`

- Use a select box, filled with a list of authors fetched from the database
   
	`Variant.additional_fields += [ :name => 'Author Id', :only => [:product], :use => 'select', :value => lambda { |controller, field| Author.all.collect {|a| [a.fullname, a.id ]} } ]`
	
- Use a text_area, with css class 'fullwidth'

	`Variant.additional_fields += [ :name => 'Additional Description', :only => [:product], :use => 'text_area', :options => { :class => 'fullwidth'} ]`


SUMMARY
=======

Spree is a complete open source commerce solution for Ruby on Rails.
It was developed by Sean Schofield under the original name of Rails
Cart before changing its name to Spree.

QUICK START
===========

Running from sources (latest and greatest features)
---------------------------------------------------

1. Clone the git repo

        git clone git://github.com/schof/spree.git spree

2. Create the necessary config/database.yml file
        
3. Install the gem dependencies

        rake gems:install
        
4. Bootstrap the database (run the migrations, create admin account, optionally load sample data.)

        rake db:bootstrap

5. Start the server

        script/server

Running the Gem
---------------

1. Install spree Gem

        sudo gem install spree

    **NOTE:** This may take a while. The gem currently includes a frozen version of Rails 2.0.2

2. Create Spree Application

        spree <app_name>

3. Create your database and edit the _config/database.yml_ to taste.

        rake db:create

    You can skip this step if using sqlite3 as your database.

4. Bootstrap

        cd <app-name>
        rake db:bootstrap

5. Launch Application

        script/server

Browse Store
------------

http://localhost:xxxx/store

Browse Admin Interface
----------------------

http://localhost:xxxx/admin

Deploying
=========

Deploy spree as a normal rails application. If you use apache+cgi/fastcgi take a look at the example .htaccess located in 

    public/.htaccess.example

i18n/l10n Support
=================

**Basic** localization and internationalization **support** is now
added using the [Globalite Plugin][1] from Matt Aimonetti. 

Working features:

- Rails Localization
- UI Localization

In the near future:

- Content Localization

Please read [this][2], [this][3] and [this][4] to understand how the
plugin works.

Please, please, please ask Sean how you can help, lot of work is still
to be done.

[1]: http://www.railsontherun.com/globalite
[2]: http://code.google.com/p/globalite/wiki/RailsLocalization
[3]: http://code.google.com/p/globalite/wiki/UI_Localization
[4]: http://code.google.com/p/globalite/wiki/PluralizationSupport

**UPDATE:** Take a look at [i18n page on Spree wiki](http://support.spreehq.org/wiki/1/I18n)
