# Posterr

This application provides API endpoints to create and retrieve posts, reposts and quoted posts. 
The API docs are available on `localhost:3000/api-docs` once the application is running.

### Getting started

Follow the steps below to get the development environment up and running

Create the database and run the migrations

```
docker-compose run --rm web bundle exec rails db:create db:migrate db:seed
```

### Running
```
docker-compose up
```

## Running the tests
```
docker-compose run --rm -e RAILS_ENV=test web bundle exec rspec
```

## Check test coverage
```
open coverage/index.html
```

## Generating the API documentation
```
docker-compose run --rm bundle exec rails rswag:specs:swaggerize
```

## Debugging

Get the web container id

```
docker ps
```

Attach your terminal to the container

```
docker attach container_id
```

### Critique

#### Improvements

Although the application already has a high test coverage rate (95%), I would still add more unit tests to ensure the quality and reliability of the code.
Additionally, I would look for faster alternatives to the current serializers to optimize the performance of the application.
To increase observability and facilitate problem debugging, I would add logs at key points in the application. This would help me detect and fix issues more efficiently.

#### Scaling

The web server may fail first when the number of requests increases beyond its capacity, as it may become overloaded and unable to handle new requests. However, the database may also become slow or fail if it is unable to perform operations quickly enough. This would happen because both would not be properly sized and optimized to handle a large volume of traffic.

In a real life situation, I would set up a continuous integration (CI) process and add tools for error and performance monitoring to ensure the quality and reliability of the application code.
Additionally, I would invest in a cloud infrastructure that would allow for global availability of the application. To achieve this, I would have multiple instances running behind a load balancer and replicas of the database, including specific databases for read and write.
To optimize data access, I would also add an in-memory database to serve as a cache, avoiding many accesses to the main database.
