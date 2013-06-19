#MCollective Ohai Fact Source

##Overview

The Ohai plugin enables mcollective to use [OpsCode Ohai](http://wiki.opscode.com/display/chef/Ohai) as a source for facts about your system.

##Installation

 * Follow the [basic plugin install guide](http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/InstalingPlugins)

##Configuration

Sample configuration:

```
factsource = facter
fact_cache_time = 3000
```

###Usage

You should now be able to use all your ohai facts in discovery and fact reporting

```
% mco rpc rpcutil get_fact fact=osfamily
Discovering hosts using the mc method for 2 second(s) .... 2

 * [ ============================================================> ] 2 / 2

node1.example.com

    Fact: platform_family
   Value: rhel

node2.example.com

    Fact: platform_family
   Value: debian


Summary of Value:

   rhel = 1
   debian = 1


Finished processing 2 / 2 hosts in 3105.79 ms
```

```
% mco rpc rpcutil ping -F platform_family=rhel
Discovering hosts using the mc method for 2 second(s) .... 1

 * [ ============================================================> ] 1 / 1


node2.example.com
   Timestamp: 1360696771



Finished processing 1 / 1 hosts in 46.86 ms
```


```
% mco inventory node1.example.com
Inventory for node1.example.com:

   ...
   ...

   Facts:
      ...
      ...
      languages.erlang.version => 5.8.5
      languages.lua.version => 5.1.4
      languages.perl.archname => x86_64-linux-thread-multi
      languages.perl.version => 5.10.1
      languages.php.builddate => Jul 3 2012
      languages.php.version => 5.3.3
      languages.python.builddate => Dec 7 2011, 20:48:22
      languages.python.version => 2.6.6
      languages.ruby.bin_dir => /usr/bin
      languages.ruby.gem_bin => /usr/bin/gem
      languages.ruby.gems_dir => /usr/lib/ruby/gems/1.8
      languages.ruby.host => x86_64-redhat-linux-gnu
      languages.ruby.host_cpu => x86_64
      ...
      ...
```
