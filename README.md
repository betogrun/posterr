# Posterr

This application provides API endpoints to create and retrieve posts, reposts and quoted posts. 
The API docs are available on `localhost:3000/api-docs` once the application is running.

### Getting started

Follow the steps below to get the development environment up and running

Create the database and run the migrations

```
docker-compose run --rm web bundle exec rails db:create
```

### Running
```
docker-compose up
```

## Running the tests
```
docker-compose run --rm -e RAILS_ENV=test web bundle exec rspec
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
