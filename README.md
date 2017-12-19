# liveuniq

Ever had a webserver logfile that had IPs in it and you wanted to know the top talker?
Ever received a continuous stream of repetitive lines and wanted to know which one was occurring
most often?

That is usually a job for `uniq -c`, the problem with that is that you can't `tail -f` a file or
receive an infinite stream of data.

We've solved that problem by just printing out the output of a `uniq -c` every 0.1 seconds.

[![asciicast](https://asciinema.org/a/153477.png)](https://asciinema.org/a/153477)

# Try it out!

Wanna see it yourself?

Just clone this repository and install [*stack*](https://haskell-lang.org/get-started).
And follow those steps:

```bash
# build liveuniq
stack build

# get random two character strings and send them to liveuniq
base64 /dev/urandom -w 2 | stack exec liveuniq

# optionally install into your PATH (probably ~/.local/bin)
stack install
```

# More Examples

The [GitHub Repository](https://github.com/benaryorg/liveuniq/) has a
[Wiki](https://github.com/benaryorg/liveuniq/wiki), which in turn has an [Example
Page](https://github.com/benaryorg/liveuniq/wiki/Examples).
I hope we can fill that one with examples soon.

# License

ISC.
There's a catch though, the library this code depends on is GPL.
This seems to be fine, as long as you take care when redistributing binaries.

My personal comment on this is: stick to more free licenses than GPL.
It saves so much trouble on these kinds of things.

