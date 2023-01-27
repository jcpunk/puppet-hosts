# hosts

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with hosts](#setup)
    * [What hosts affects](#what-hosts-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with hosts](#beginning-with-hosts)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Manage `/etc/hosts` with a clear way to associate dual stack systems with their multiple IP addresses.

## Setup

### Beginning with hosts

```puppet
   class { 'hosts':
     add_entries                => {
       'myhostname.example.com' => {
         'ipv4'                 => '127.0.0.1',
         'ipv6'                 => '::1',
         'aliases'              => ['myhostname', 'myname'],
         'comment'              => 'some string goes here'
       }
     }
   }
```


## Usage

Add whatever entries you need.  They will be sorted by the FQDN (top level key).

## Limitations

Sorting is not optional.  Sorting makes things consistent.

## Development

See the github repo.
