# Prism
A URL shortener for your Urbit. 

-----

## Usage

Boot it up, open the web UI at /apps/prism. Interactions are all documented
there.

Use `direct` to create a redirect.
```
dojo> :prism|direct ~.dev 'https://developers.urbit.org/'
```

Use `divert` to create a redirect from a random path (drawn from the set
of stars, eg `/apps/prism/ronfeb`).
```
dojo> :prism|divert 'https://newgrounds.com/'
```

Use `defect` to disable an existing redirect.
```
dojo> :prism|defect ~.dev
```

Use `renege` to re-enable a previously disabled redirect.
```
dojo> :prism|renege ~.dev
```

Use `delete` to delete a redirect.
```
dojo> :prism|delete ~.dev
```

-----

## Development

This is very much a work in progress. I don't have any special insight
into who's using the app, what they're using it for, or what could be
improved to make it better for users. So if you have a suggestion,
please do create an issue for it. 

I'm working on a way to provide feedback directly from within the web
UI, but that's still a little ways off.
