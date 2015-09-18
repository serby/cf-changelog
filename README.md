# cf-changelog

Creates a markdown changelog from git commits.

Merge commits will be omitted as will any that start with `^` or a number.

`[PT #NNNNNNNN]` will be converted to pivotal tracker links and `[FD #NNNN]` will be converted to freshdesk links

## Installation

### For projects

```
npm install --save-dev cf-changelog
```
Then add `"update-changelog": "update-changelog"`  to your `scripts` in `package.json`

### For global usage

```
npm install -g cf-changelog
```

## Credits
[Paul Serby](https://github.com/serby/)

Follow me on twitter [@serby](http://twitter.com/serby)

## License

ISC
