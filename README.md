# WhereTo?

[![Build Status](https://travis-ci.com/colinwarmstrong/whereto.svg?branch=master)](https://travis-ci.com/colinwarmstrong/whereto) [![Maintainability](https://api.codeclimate.com/v1/badges/30b0762e5329b9052c21/maintainability)](https://codeclimate.com/github/colinwarmstrong/whereto/maintainability)

[WhereTo?](https://colinwarmstrong.github.io/whereto-frontend/index.html) is an application built to help users planning on moving across the country.  It utilizes data from [OpenDataSoft](https://public.opendatasoft.com/explore/dataset/1000-largest-us-cities-by-population-with-geographic-coordinates/table/?sort=-rank) to show information about the 1000 most populated cities in America.  Users can then sort, search, favorite, and reject cities based on their preferences. The backend is a Rails API and the frontend is built using JavaScript, HTML, and CSS.  To see what new features are currently in the works, you can take a look at the the project on [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2222980).

![alt text](https://image.ibb.co/j5TGiV/Screen-Shot-2018-11-06-at-10-51-33-PM.png)

![alt text](https://i.imgur.com/Y122T70.png)

## Getting Started
These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You will need access to a terminal application and a text editor.

### Installing

From your terminal, clone the repository to your local machine:

```
git clone https://github.com/colinwarmstrong/whereto.git
```

Change into the directory:

```
cd whereto
```

Install and update gems:

```
bundle install
bundle update
```

Setup the database:

```
rake db:create,migrate,seed}
```

The repository is now setup on your local machine. To run a local version of the repository, first spin up a local Rails server:

```
rails s
```

Once the server is up and running, visit [http://localhost:3000/api/v1/cities](http://localhost:3000/api/v1/cities) or any of the other endpoints to see the JSON that is returned.


## Running the tests

The test suite is built using RSpec.  After setting up the respository locally, run the following command to run the test suite:
```
bundle exec rspec
```

## Endpoints

All endpoints can be accessed by appending them to the root URL `https://where-to-1.herokuapp.com`


#### City Endpoints

* [`GET /api/v1/cities`](https://where-to-1.herokuapp.com/api/v1/cities) -- Returns information about all cities in the database:
```
[
  {
    "id": 68,
    "name": "New York",
    "state": "New York",
    "rank": 1,
    "growth": 4.8,
    "population": 8405837,
    "latitude": "40.7127837",
    "longitude": "-74.0059413"
  },
  {
    "id": 592,
    "name": "Los Angeles",
    "state": "California",
    "rank": 2,
    "growth": 4.8,
    "population": 3884307,
    "latitude": "34.0522342",
    "longitude": "-118.2436849"
  },
  {
    "id": 603,
    "name": "Chicago",
    "state": "Illinois",
    "rank": 3,
    "growth": -6.1,
    "population": 2718782,
    "latitude": "41.8781136",
    "longitude": "-87.6297982"
  }
]
```

* [`GET /api/v1/cities/:city_id`](https://where-to-1.herokuapp.com/api/v1/cities/22) -- Returns information about a specific city:

```
{
  "id": 22,
  "name": "Carpentersville",
  "state": "Illinois",
  "rank": 965,
  "growth": 22.8,
  "population": 38241,
  "latitude": "42.1211364",
  "longitude": "-88.2578582"
}
```

#### Favorite Endpoints

* [`GET /api/v1/favorites`]() -- Returns all favorited cities for the current user:

```
[
  {
    "id": 56,
    "name": "San Jose",
    "state": "California",
    "rank": 10,
    "growth": 10.5,
    "population": 998537,
    "latitude": "37.3382082",
    "longitude": "-121.8863286"
  },
  {
    "id": 592,
    "name": "Los Angeles",
    "state": "California",
    "rank": 2,
    "growth": 4.8,
    "population": 3884307,
    "latitude": "34.0522342",
    "longitude": "-118.2436849"
  }
]
```

* `POST /api/v1/favorites` -- Creates a new favorited city for a user. Expected parameters:

```
{city_id: <CITY_ID>}
```

#### Rejection Endpoints

* [`GET /api/v1/rejections`]() -- Returns all rejected cities for the current user:

```
[
  {
    "id": 116,
    "name": "Jacksonville",
    "state": "Florida",
    "rank": 13,
    "growth": 14.3,
    "population": 842583,
    "latitude": "30.3321838",
    "longitude": "-81.655651"
  },
  {
    "id": 856,
    "name": "Phoenix",
    "state": "Arizona",
    "rank": 6,
    "growth": 14,
    "population": 1513367,
    "latitude": "33.4483771",
    "longitude": "-112.0740373"
  }
]
```

* `POST /api/v1/rejections` -- Creates a new rejected city for a user. Expected parameters:

```
{city_id: <CITY_ID>}
```

## Deployment

The backend is deployed through [Heroku](https://www.heroku.com/) and hosted at [https://where-to-1.herokuapp.com/](https://where-to-1.herokuapp.com/api/v1/cities).

The frontend is deployed through GitHub pages and can be found here: [WhereTo?](https://colinwarmstrong.github.io/whereto-frontend/index.html)

## Built With

* [Rails 5.2.1](https://rubyonrails.org/) - Ruby based web framework
* [Postgres 1.1.3](https://www.postgresql.org/) - Relational SQL Database

## Author

* **Colin Armstrong**  
 	- [GitHub](https://github.com/colinwarmstrong)
 	- [LinkedIn](https://www.linkedin.com/in/colinwarmstrong/)
 	- [Twitter](https://twitter.com/colinarms93)



## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create your new feature (make sure to test it and run RSpec)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push up your branch (`git push origin my-new-feature`)
6. Create a new pull request

Or email the author at colinwarmstrong@gmail.com with any questions, comments, or concerns.

