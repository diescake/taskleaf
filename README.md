# taskleaf

## Environment

- ruby 2.7.2p137
- Rails 5.2.1
- PostgreSQL 10.15

## Installation

```shell
$ bundle install
```

## Run

1. Launch the database server.

```shell
$ brew services start postgresql@10
```

2. Launch the rails server.

```shell
# $ bundle exec rails s
$ bin/rails -s
```

3. Open `http://localhost:3000` on your browser.

## Stop

```shell
$ brew services stop postgresql@10
```

## Debug

```shell
$ psql postgres
```
