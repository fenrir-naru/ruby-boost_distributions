# boost_distribution (Ruby gem)

boost_distribution is a Ruby gem to calculate various statistical properties of distributions supported by [boost::math::distributions](https://www.boost.org/doc/libs/release/libs/math/doc/html/dist.html).

## Installation

### Install boost headers

Before `gem install`, boost headers are required. For well-known platforms, try appropriate one of the followings:

#### Windows Ruby
(Assumption: Most of users may use [Ruby installer](https://rubyinstaller.org/).) Please check whether your Ruby has been installed with devkit. If not, please re-install Ruby [with devkit, which is found at the top of the page](https://rubyinstaller.org/downloads/). Then, run `Start Command Prompt with Ruby` from the start menu to launch the command line interface, and type following commands (each line requires hitting enter after inputs, and hit Y key when you are asked something like "install OK?"):
```cmd
ridk enable
pacman -Syy
pacman -S mingw-w64-ucrt-x86_64-boost
```
![image](https://github.com/fenrir-naru/ruby-boost_distributions/assets/4583735/3d558841-349d-41c3-a3b6-61956b199fbd)
#### Cygwin
By using `setup-x86_64.exe` [Cygwin](https://www.cygwin.com/) GUI installer, select libboost-devel unless the headers have been installed.
![image](https://github.com/fenrir-naru/ruby-boost_distributions/assets/4583735/fdeec3c4-495f-4346-b23a-a91ad6087ba5)
#### UNIX
    $ apt-get install libboost-dev

### Install gem

After installation of boost headers, install the gem as:

    $ gem install boost_distributions

Or if you want to include it into your application, add this line to Gemfile:

```ruby
gem 'boost_distributions'
```

and execute:

    $ bundle install

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bundle install` to install dependencies. To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

There are some useful commands in developement life-cycle.

| Command | Description |
| ---- | ---- |
|  `bundle exec rake swig`  |  Re-generate [wrapper C code](https://github.com/fenrir-naru/ruby_boost_distributions/blob/master/ext/boost_distributions/BoostDistributions) |
|  `bundle exec rake compile`  |  compile shared library  |
|  `bundle exec rake spec`  |  run tests  |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fenrir-naru/ruby-boost_distributions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/fenrir-naru/ruby-boost_distributions/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the BoostDistributions project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fenrir-naru/ruby_boost_distributions/blob/master/CODE_OF_CONDUCT.md).
