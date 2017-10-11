# meta_commit ruby support

This gem adds ruby (version 2.3) support to [meta_commit](https://github.com/usernam3/meta_commit) commands

## Installation

Install gem :

    $ gem install meta_commit_ruby_support

## Usage

To add ruby support to meta_commit runner for specific repository you need to :

-   edit meta_commit.yml file of repo
-   add `ruby_support` to list of extensions

Now meta_commit knows that repository requires ruby support and will load this gem