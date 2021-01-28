# taskleaf

Toy todo tools to learn Rails. My textbook is [現場で使える Ruby on Rails 5速習実践ガイド](https://www.amazon.co.jp/dp/4839962227) a.k.a. `現場 Rails`.

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
$ psql taskleaf_development
```
