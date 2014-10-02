require 'yaml'

#
# change opensuse_64_dvd to one of configurations in *.yml in this dir
# use the yml files to configure
#
opensuse_type = :opensuse_64_dvd

#
# do not change bellow
#
opensuse_definition = YAML.load_file("definition.yml")
opensuse_flavor     = YAML.load_file("#{opensuse_type}.yml")

Veewee::Definition.declare(opensuse_definition.merge(opensuse_flavor))
