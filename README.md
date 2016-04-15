# Rexdit Observer (Reddit meets Elixir)

![Image of a Rexdit notification](notification.png)

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


# License

The MIT License (MIT)

Copyright (c) 2015 Gabriel Gatu

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
