<img src="https://raw.github.com/mac-r/Ajaila-Skeleton/master/ajaila_github.png" alt="Ajaila Logo">
## Ajaila Datamining Sandbox

### Warning!
Ajaila is currently in the development mode. Please don't follow the instruction below.

## Installing 

First of all install the gem:
```
gem install ajaila
```	

Now you can create a new Ajaila application:
```
ajaila new app_name_here
```

The operation above generates a set of files at the current directory. Now check weather you have everything you need in the `Gemfile`.

If everything is fine, then install all necessary dependancies from the application root:
```
app_name_here$ bundle install
```

## Working 

Put raw files in the raw directory located in the datasets.

Write selectors. To create new tables in the DB filled with the necessary data.

Go to the sandbox. You'll see three core directories:
* tables (your table, which you've created with selectors)
* miners (where you conduct your core datamining activities)
* presenters (visualize your data or build your own RESTful API)

## Useful Commands

When you import some raw file (ex. Raw_File.csv) create selector with the following command:
```
ajaila generate selector Some_Selector using Raw_File.csv
```
(defines the type of the file and attaches necessary parsers)

Create tables:
```
ajaila generate table Some_Table for Some_Selector with name:String date:Date
```

Create new miners:
```
ajaila generate miner Some_Miner using Some_Table
```

Create new presenters:
```
ajaila generate presenter Some_Presenter using Some_Table
```

### Experimental

If you want to use data from open APIs of Twitter, Facebook and etc. just create a special raw file in the raw file directory. To do this type the command:
```
ajaila generate raw Some_Raw from Twitter
```

Then you'll be able to configure parameters and get the necessary information.
