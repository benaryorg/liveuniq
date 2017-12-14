# liveuniq

Ever had a webserver logfile that had IPs in it and you wanted to know the top talker?
Ever received a continuous stream of repetitive lines and wanted to know which one was occurring
most often?

That is usually a job for `uniq -c`, the problem with that is that you can't `tail -f` a file or
receive an infinite stream of data.

We've solved that problem by just printing out the output of a `uniq -c` every 0.1 seconds.

# Try it out!

Wanna see it yourself?

Just clone this repository and install [*stack*](https://haskell-lang.org/get-started).
And follow those steps:

```bash
# build liveuniq
stack build
# get random two character strings and send them to liveuniq
base64 /dev/urandom -w 2 | stack exec liveuniq
```

