# Elixir

* 1st step: Install Elixir and Phoenix Framework
- Elixir (https://elixir-lang.org/install.html)
- Phoenix (https://hexdocs.pm/phoenix/installation.html)

## Run Api

```bash
mix ecto.create && \
mix ecto.migrate && \
mix phoenix.server
```

## Creating a model to store

- Easy way:

```bash
mix phoenix.gen.json \
  User users \
  name:string \
  email:string \
  password_hash:string
```

Notice: The first param `User` is the name of the model while the second is the name of the table

Before follow that instructions we need to do some important updates in the migration file. Open up the file: `priv/repo/migrations/<timestamp>_create_user.exs`

- Insert table in the database

```bash
mix ecto.migrate
```
