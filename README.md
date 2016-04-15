# Rexdit Observer (Reddit meets Elixir)

### Summary

Rexdit is a small hobby project developed in elixir. It observes  subreddits
waiting for new posts. Then, it shows a notification to the user.

### Why you developed this?

Just for fun, and practice. Any improvement or suggestion is welcome :)

### Supported O.S.

Currently, only Mac is supported, because the notification system uses
applescript. If you want to implement support for other os, you are the
welcome ;)

### How to run

To set the subreddits to observe, set an enviroment variable called `REXDIT`
with the subreddit names, divided by pipes.
If the variable is not set, as default it observes `elixir`.

Example: `export REXDIT="elixir|golang|swift"`

You can start the application with:

* `iex -S mix`

* `Rexdit.run`

### Extending & Supporting

If you have a proposal for extending the current behaviours, just open an
issue :)
