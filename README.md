# [Ajaila: Modular DSL for Predictive Analysis](https://github.com/mac-r/ajaila)

# !!Notice!!
    This is a preliminary release for internal review.
    The official release will be announced later.
    Any suggestion for modification is welcome.

## Abstract

The application helps you to work with statistical datasets, normalize the data into a common format and build the required data models. Additionally, you can visualize your data with [Protovis](http://mbostock.github.com/protovis/) / [Highcharts.js](http://www.highcharts.com/) and scale your service with [Hadoop](http://hadoop.apache.org/) ([HDFS](http://hadoop.apache.org/docs/stable/hdfs_user_guide.html)).

During your work the application is provided with usefull [snippets](http://en.wikipedia.org/wiki/Snippet_%28programming%29) and generators. Ajaila can be easily extended with common Machine Learning packages written in Ruby and C. Among supported libraries are [Statsample](http://ruby-statsample.rubyforge.org/), [MadLib](http://madlib.net/) ([EMC corporation](http://en.wikipedia.org/wiki/EMC_Corporation)) and [Vowpal Wabbit](https://github.com/JohnLangford/vowpal_wabbit) ([Yahoo! Research](http://research.yahoo.com/node/1914)), [online learning](http://en.wikipedia.org/wiki/Online_machine_learning) library based on [stochastic gradient discent](http://en.wikipedia.org/wiki/Stochastic_gradient_descent) for [classification problems](http://en.wikipedia.org/wiki/Category:Classification_algorithms) and [regression analysis](http://en.wikipedia.org/wiki/Regression_analysis).

After prototyping you can deploy your application to the web and provide your predictive models with unstructured data from [Hadoop](http://hadoop.apache.org/) via [MapReduce](http://en.wikipedia.org/wiki/MapReduce), which is hidden from you behind classy [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping) ([Massive Record](https://github.com/CompanyBook/massive_record) or [Treasure Data Extensions](https://github.com/treasure-data/td-client-ruby)).

Ajaila helps you build [long-lasting software](http://www.amazon.com/Engineering-Long-Lasting-Software-Computing-ebook/dp/B006WU5G4C) and provides you with environment, which can be easily tested with [RSpec](https://github.com/mac-r/ajaila). The platform itself is tested and can be trusted.

## Introduction

Ajaila is the composition of two words: ajala and agile. According to african mythology, "Ajala" is the god of creation, who lives in heaven and makes human faces from clay and chaos. As far as you most probably know, "agile" describes a flexible approach to software development, which expects you to split the workflow into sustainable pieces. Therefore, it shouldn't be surprising for you why Ajaila is called like that. We are talking about datamining framework, which allows you to follow agile practices.

Why are agile practices so important? Whether you are a software developer or research engineer, there is always someone interested in what you are doing. These people are stakeholders in a project you are working on. Demonstrating results on a regular basis is the crucial point, which allows to succeed. With Ajaila you can conduct R&D, split your datamining project into sustainable parts and show progress within each iteration. 

# Installation 
### Ruby Developer
It's great to solve complex problems in a friendly environment. Are you already familiar with [Bundler](http://gembundler.com/), [RubyGems](https://rubygems.org/) and [RVM](https://rvm.io/)? That's cool! Current Ajaila version supports [Ruby 1.9.3](https://github.com/ruby/ruby). 

Ajaila needs a database to work properly. I decided to use [MongoDB](http://www.mongodb.org/) as a default, because of [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping) ([MongoMapper](http://mongomapper.com/)). [MongoDB](http://www.mongodb.org/) doesn't need [migrations](http://guides.rubyonrails.org/migrations.html) and I find it convenient. Feel free to contribute and make support of other databases.

If you don't have MongoDB install it. 

There is no Ajaila 0.0.2 at RubyGems. Version 0.0.1 is a crap, don't install it. To get an unstable version, which is almost like 0.0.2, you should open the Terminal and clone the repository to your PC (Mac OS / Linux)
```
git clone https://github.com/mac-r/ajaila.git
```

Then build Gem from `ajaila.gemspec`
```
gem build ajaila.gemspec
```

You'll have `ajaila-0.0.2.gem` inside Ajaila folder. This is a newly baked Gem, which can be installed with the Terminal command
```
gem install ajaila-0.0.2.gem
```

After installing all dependencies you'll be able to check if everything went right. After typing `ajaila` in the Terminal you should get
```
Ajaila Datamining Sandbox v. 0.0.2
```

### Not a Ruby Developer
Set up your environment and learn Ruby. I can post a detailed manual on request. Just create a new issue [here](https://github.com/mac-r/ajaila/issues/new).

# Architecture
The platform consists of two blocks. Among them: Datasets and Sandbox. They exist in the context of Ajaila Environment, which provides everything with a library of methods and allows to generate new instances (selectors, miners, tables, presenters). There is also a Dashboard, which aggregates all information about the particular project (dashboard allows to observe the content of all presenters inside the project).

![Ajaila v.0.0.2 Architecture](https://raw.github.com/mac-r/ajaila-media/master/ajaila_002_architecture.png)

## Datasets vs. Sandbox
Datasets and Sandbox are split according to their usage frequency. 

While [creating a new project](https://github.com/mac-r/ajaila/wiki/Starting-Project), we run selectors only once or at least they are built for that. Selectors parse CSV files and turn static pieces of data into dynamic ones.

On the other hand, everything in the Sandbox is changed much more often (miners, presenters, tables and even helpers). 

I found this kind of approach valuable and hope that you'll get used to it and appreciate it as well.

## Datasets Explained
After creating a new project simply put all static files inside `datasets/raw`. For now there is only a CSV format supported within selectors. If you need some other format - just ask me to help by creating a new issue. 

Selectors are the dwellers of Datasets folder. This dudes are very important. Let's look at the Sandbox decomposition: 

`Sandbox` = `Sand` + `Box`

Selectors simply fill an empty box within the data. As soon as `Sandbox` is ready we move to the next step of our workflow. Selectors are left behind and we are making a short bio for each Datasets dweller.

#### Inside Selector
We created a new project called SuperProject. Our mission is to analyze Cool Things, which are stored in the CSV file called `items.csv`. We put this file into `SuperProject/datasets/raw` directory.

Before generating a selector we need to generate some table, which will store the contents of `items.csv`. We open a Terminal window in the SuperProject directory and write the following command.

```
~/DEMOS/SuperProject$ ajaila g table CoolThings item:String produced:Time cost:Float quantity:Integer
```

The command should return a green message as the one below.
```
Ajaila: Generated table CoolThings successfully!
```

Now we have the table `CoolThings` (with columns item, produced, cost, quantity), which will be described in the next paragraph.

After the table is created, we can move further. Our new challenge is to create selector (called `ItemsExtractor`), but it's not a hard nut to crack.

```
~/DEMOS/SuperProject$ ajaila g selector ItemsExtractor file:items.csv table:CoolThings
```

There should be a green message, explaining that everything went fine. Let's look inside ItemsExtractor.

```ruby
# inside SuperProject/datasets/items_extractor.selector.rb
require "ajaila/selectors"
file = import "items.csv"

CSV.foreach file do |row|
  item = row[0]
  produced = row[0]
  cost = row[0]
  quantity = row[0]
  CoolThings.create(item: item, produced: produced, cost: cost, quantity: quantity)
end
```

Ajaila doesn't know how to define columns automatically. But it's not difficult to change indexes or rows manually (`items = row[0]`, `produced = row[1]` and etc). 

This file can be executed through the Terminal window.
```
ajaila run selector ItemsExtractor
```

Now we have `CoolThings`, which are a dynamic representation of `items.csv`.

### Datasets Overview
| Resident Name | Short Bio | Interaction |
| ------------- |:-------------:| -----:|
| CSV Files | Live inside `datasets/raw`. Keep all the data of the project in the static form. | Manually Placed |
| Selectors | Require table and file as an input. They know how to parse CSV files. | Generated and executed via Terminal Command |

## Sandbox Explained
Datasets are easier to understand, because Sandbox consists of more elements. As you can observe at the scheme above, there are Tables, Miners, Helpers and Presenters. Quite self-explanatory names, aren't they?

### Tables
After the selection process, data is stored in the database. The access point for the data is a set of tables stored in the `sandbox/tables` folder. MongoDB gives us freedom not to generate migrations (that saves a lot of time). Additionally, we can change any table or rewrite everything in a new way.

Tables initialize new collections within the Mongomapper. Collections are available through selectors, miners and presenters. Helpers are not linked with Ajaila environment directly, but you can call collections and their methods. Helpers are usually a part of something (new helper gets generated within new miner).

During the work in the Sandbox you are expected to create new tables with rewritable data. It's not recommended to change data and table, which were the output of some Selector. Selectors create the core data storage of a Project. Use such table as an input for miners and presenters, but don't rewrite it.

#### Inside Table
Let's return to our `SuperProject`, where we try to find beauty in `CoolThings`. You should already know that `CoolThings` is a table with columns. This table lives in the `SuperProject/sandbox/tables` directory.

If we open the file `cool_things.table.rb` the we'll see.
```ruby
class CoolThings
  include MongoMapper::Document
  key :item, String
  key :produced, Time
  key :cost, Float
  key :quantity, Integer
end
```

Ajaila generated this file automatically. As you may observe, `CoolThings` is a class of Mongomapper.

### Miners
Write your algorithms inside Helpers and execute them inside Miners. When you generate new Miner you have to specify tables, which will be used as an Input or Output. After you specify I/O tables Ajaila has an opportunity to generate valuable snippets according to the information specified in tables.

Miner is more powerful if it's task oriented and focused. Miner should be readable and have as many functions inside Helper as possible. Miners are difficult to get tested directly, methods inside Helpers are much easier to test.

Split your complex problem into subproblems. One miner per subproblem is a good way of dealing with things.

#### Helpers 
You've already got familiar with Helpers if you read about Miners. Helper is a module, which gets automatically included in the miner. Just imagine that we want to generate miner `Foo`. If everything works properly - there'll be helper called `FooHelper`.

There is also an `ApplicationHelper`. This helper is so global, that it can be used in any Selector, Miner or Presenter.

#### Presenters
Presenters are still work in progress. There is no DSL yet, but I can explain you how to build Charts manually. Just let me know that you need it.

### Sandbox Overview
| Residents | Short Bio | Interaction |
| ------------- |:-------------:| -----:|
| Tables | Store information about Data Structures. Get initialized within Ajaila environment. | Can be generated or listed. |
| Miners | Execute algorithms and use Tables as an I/O. | Can be generated, listed or executed via Terminal. |
| Helpers | Modules, which store methods used by other parts of an Application. | Generated within miners automatically. |
| Presenters | Provide user with a DSL to visualize Data. | Can be created manually (still in development). |

## License

The MIT License

Copyright (c) 2013 Max Makarochkin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


