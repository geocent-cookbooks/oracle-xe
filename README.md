Description
===========

Installs Oracle XE database server.

Requirements
============

Platform
--------

* Windows 

Attributes
==========

See `attributes/default.rb` for default values.

* `node['oracle']['installer']['remote_loc']` - Remote location to download the OracleXEUniv.exe
* `node['oracle']['installer']['response_file']` - Location of response file

Recipes
=======

default
-------

Include the default recipe in a run list to get `oracle-xe`.

Usage
=====

Simply include the `oracle-xe` recipe wherever you would like Oracle XE
installed.

