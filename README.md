# odoo

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with odoo](#setup)
    * [What odoo affects](#what-odoo-affects)
    * [Beginning with odoo](#beginning-with-odoo)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Install Odoo Communinty edition in a manner similar to that described in
*[Installing Odoo](https://www.odoo.com/documentation/13.0/setup/install.html)*.

## Setup

### What odoo affects

* Installs the `odoo` package from the Odoo repository.
* Configures `/etc/odoo/odoo.conf`.
* Manipulates the running state of the `odoo` service.
* Optionally configures repositories to enable package installations from
  the Odoo nightly builds.
* Optionally installs the `wkhtmltopdf` package from the Odoo repository.

### Beginning with odoo

```puppet
include ::odoo::repo13
include ::odoo
```

or for Odoo 10:

```puppet
include ::odoo::repo10
include ::odoo
```

Do not have both `::odoo::repo` included as they each attempt to update the repository.

## Usage

The following example will install a basic PostgreSQL database on the
node (using
`[puppetlabs-postgresql](https://forge.puppet.com/puppetlabs/postgresql)`)
it then configures the the Odoo 13 repositories.  It then installs the
`odoo` and `wkhtmltopdf` packages with some settings for the Odoo
server:

```puppet
class { 'postgresql::server':
  before => Class['odoo']
}

class { '::odoo::repo13':
  before => Class['odoo']
}

class { '::odoo':
  install_wkhtmltopdf => true,
  settings            => {
    'options' => {
      'admin_passwd' => 'XXX_TOP_SECRET_XXX',
      'db_host'      => 'False',
      'db_port'      => 'False',
      'db_user'      => 'odoo',
      'db_password'  => 'False',
      'addons_path'  => '/usr/lib/python3.5/dist-packages/odoo/addons',
    }
  },
}
```

## Limitations

This module does not in anyway configure PostgreSQL.

## Development

Contributions will be gratefully accepted. Please go to the project page, fork
the project, make your changes locally and then raise a pull request. Details
on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.
