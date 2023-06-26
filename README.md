# boost_distribution (Ruby gem)

boost_distribution is a Ruby gem to calculate various statistical properties of distributions supported by [boost::math::distributions](https://www.boost.org/doc/libs/release/libs/math/doc/html/dist.html).

[![Gem Version](https://badge.fury.io/rb/boost_distributions.svg)](https://badge.fury.io/rb/boost_distributions)
[![Ruby](https://github.com/fenrir-naru/ruby-boost_distributions/actions/workflows/main.yml/badge.svg)](https://github.com/fenrir-naru/ruby-boost_distributions/actions/workflows/main.yml)

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

Note that if your boost headers are not in the standard path, the following alternative is helpful for each method.

    $ gem install boost_distributions -- --with-boost-include=/path/to/parent_directory_of_boost_header

----

Or if you want to include it into your application, add this line to Gemfile:

```ruby
gem 'boost_distributions'
```
and execute:

    $ bundle install

following

    $ bundle config build.boost_distributions --with-boost-include=/path/to/parent_directory_of_boost_header

if your boost headers are in the non-standared path.

## Usage

Example usage is as the followings:

```ruby
require 'boost_distributions'

# Generate normal (Gaussian) distribution instance with mu = 0, sigma = 1
normal = BoostDistributions::Normal::new(0, 1)
normal.mean # => 0
normal.standard_deviation # => 1.0

normal.pdf(0) # => 0.399, Probability density function
normal.cdf(0) # => 0.5, Cumulative distribution function
normal.quantile(0.5) # => 0
```

[List of supported distributions](boost_version_comparison.md) are:

| Distributions | Required minimum boost version |
| ---- | ---- |
|[Arcsine Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/arcsine_dist.html)|1.58.0|
|[Bernoulli Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/bernoulli_dist.html)|1.35.0|
|[Beta Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/beta_dist.html)|1.35.0|
|[Binomial Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/binomial_dist.html)|1.35.0|
|[Cauchy-Lorentz Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/cauchy_dist.html)|1.35.0|
|[Chi Squared Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/chi_squared_dist.html)|1.35.0|
|[Exponential Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/exp_dist.html)|1.35.0|
|[Extreme Value Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/extreme_dist.html)|1.35.0|
|[F Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/f_dist.html)|1.35.0|
|[Gamma (and Erlang) Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/gamma_dist.html)|1.35.0|
|[Geometric Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/geometric_dist.html)|1.46.0|
|[Hyperexponential Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/hyperexponential_dist.html)|1.57.0|
|[Hypergeometric Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/hypergeometric_dist.html)|1.40.0|
|[Inverse Chi Squared Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/inverse_chi_squared_dist.html)|1.45.0|
|[Inverse Gamma Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/inverse_gamma_dist.html)|1.45.0|
|[Inverse Gaussian (or Inverse Normal) Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/inverse_gaussian_dist.html)|1.46.0|
|[Kolmogorov-Smirnov Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/kolmogorov_smirnov_dist.html)|1.75.0|
|[Laplace Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/laplace_dist.html)|1.40.0|
|[Logistic Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/logistic_dist.html)|1.40.0|
|[Log Normal Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/lognormal_dist.html)|1.35.0|
|[Negative Binomial Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/negative_binomial_dist.html)|1.35.0|
|[Noncentral Beta Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/nc_beta_dist.html)|1.36.0|
|[Noncentral Chi-Squared Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/nc_chi_Squared_dist.html)|1.36.0|
|[Noncentral F Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/nc_f_dist.html)|1.36.0|
|[Noncentral T Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/nc_t_dist.html)|1.36.0|
|[Normal (Gaussian) Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/normal_dist.html)|1.35.0|
|[Pareto Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/pareto_dist.html)|1.35.0|
|[Poisson Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/poisson_dist.html)|1.35.0|
|[Rayleigh Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/rayleigh.html)|1.35.0|
|[Skew Normal Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/skew_normal_dist.html)|1.50.0|
|[Students t Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/students_t_dist.html)|1.35.0|
|[Triangular Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/triangular_dist.html)|1.35.0|
|[Uniform Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/uniform_dist.html)|1.35.0|
|[Weibull Distribution](https://www.boost.org/doc/libs/release/libs/math/doc/html/math_toolkit/dist_ref/dists/weibull_dist.html)|1.35.0|

[See documentation in rubyrdoc.info](https://rubydoc.info/gems/boost_distributions/)

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
