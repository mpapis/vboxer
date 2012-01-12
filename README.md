# Trying to test RVM with different linuxes.

## For start install gems

    gem install vagrant
    gem install veewee

## Generate vm definition

    vagrant basebox define 'rvm-ubuntu-11.10-i386' 'ubuntu-11.10-server-i386'

Download required iso

    curl -L http://releases.ubuntu.com/11.10/ubuntu-11.10-server-i386.iso -o iso/ubuntu-11.10-server-i386.iso

## Configuration

Edit `definitions/rvm-ubuntu-11.10-i386/definition.rb` - increase ram to 1024

Edit `definitions/rvm-ubuntu-11.10-i386/postinstall.sh` - replace ruby & rubygems code with:

    # Install rvm & ruby
    apt-get -y install curl gcc git-core libyaml-dev libsqlite3-dev libxml2-dev libxslt-dev libc6-dev ncurses-dev subversion
    curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash
    PATH=$PATH:/usr/local/rvm/bin
    echo "gem: --no-ri --no-rdoc" | tee /home/vagrant/.gemrc > /root/.gemrc
    rvm install 1.9.3
    rvm alias create default 1.9.3
    source /usr/local/rvm/environments/default

## Build the image

    vagrant basebox build 'rvm-ubuntu-11.10-i386'

## Validate and export so it could be reused later

    vagrant basebox validate rvm-ubuntu-11.10-i386

## Add the new vagrant package

    vagrant box add 'rvm-ubuntu-11.10-i386' 'rvm-ubuntu-11.10-i386.box'

## Init the image

    vagrant init 'rvm-ubuntu-11.10-i386'

## Start up image

    vagrant up

## Connect to the image

    vagrant ssh

## And finally run some tests

    ruby -rreadline -rzlib -ropenssl -rcurses -ryaml -e 'puts :ok'
