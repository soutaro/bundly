# Bundly - Bundle gems from YAML file

I really like that Bundler is using Ruby as its configuration file syntax.
We don't have to learn new syntax.
We love the syntax.

However, it also involves a difficulty that it is not very easy to maintain dependency list via programs.
So, let's use a YAML file instead!

## Installation

Install Bundly using `gem`.

```
$ gem install bundly
```

Run setup command in your repository.

```
$ bundly setup
```

It will generate a initializer file in `lib/bundly.rb`.
I recommend checking in the file in your repository so that your teammate can continue working without Bundly.

Put some dependencies in `gems.yaml` file.

```yaml
- name: super_private
  git: git@github.com:acme_corp/super_private_gem.git
  tag: 0.2.3
```

And then install.

```
$ bundle install
```

## Updating Gems in YAML

Bundly provides command to update YAML file.

```
$ bundly gem super_private tag=0.2.3
$ bundle install
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/soutaro/bundly.

