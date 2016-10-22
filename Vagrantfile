Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provider 'virtualbox' do |config|
    config.memory = '2048'
  end

  PACKAGES = %w(
      git-core

      sqlite3
      libsqlite3-dev

      build-essential
      pkg-config

      g++-4.8-multilib
      gfortran-4.8

      python2.7-dev

      gettext
      libncurses5-dev
      libcurl4-openssl-dev

      lib32z1-dev
      libboost-dev
      libbz2-dev
      libc6-dev-i386
  )
  config.vm.provision 'shell', inline: <<-SHELL
    apt-get update
    apt-get install -y #{PACKAGES.join(' ')}
  SHELL

  SOFTWARE_ROOT = '~/software'
  GIT_URL = 'https://github.com/git/git.git'
  VIM_URL = 'https://github.com/vim/vim.git'
  REDIS_VERSION = '3.2.4'
  REDIS_URL = "http://download.redis.io/releases/redis-#{REDIS_VERSION}.tar.gz"
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    mkdir -p #{SOFTWARE_ROOT}

    git clone #{GIT_URL} #{SOFTWARE_ROOT}/git
    cd #{SOFTWARE_ROOT}/git
    make prefix=/usr/local
    sudo make prefix=/usr/local install
    git clone https://github.com/IvanUkhov/.develop.git ~/.develop
    make -C ~/.develop

    git clone #{VIM_URL} #{SOFTWARE_ROOT}/vim
    cd #{SOFTWARE_ROOT}/vim
    ./configure --prefix=/usr/local install
    sudo make install
    git clone https://github.com/IvanUkhov/.vim.git ~/.vim --recursive
    make -C ~/.vim

    cd #{SOFTWARE_ROOT}
    curl -LO #{REDIS_URL}
    tar -xzf redis-#{REDIS_VERSION}.tar.gz
    cd redis-#{REDIS_VERSION}
    make
    sudo make PREFIX=/usr/local install
  SHELL

  SIMULATION_ROOT = '~/simulation'
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    echo 'export PIN_HOME=#{SIMULATION_ROOT}/pin' >> ~/.bash_profile
    echo 'export SNIPER_ROOT=#{SIMULATION_ROOT}/sniper' >> ~/.bash_profile
    echo 'export BENCHMARKS_ROOT=#{SIMULATION_ROOT}/benchmarks' >> ~/.bash_profile
  SHELL

  PIN_BASENAME = 'pin-2.14-71313-gcc.4.4.7-linux'
  PIN_URL = "http://software.intel.com/sites/landingpage/pintool/downloads/#{PIN_BASENAME}.tar.gz"
  SNIPER_URL = 'http://snipersim.org/download/b8df51129affee69/git/sniper.git'
  SNIPER_COMMIT = 'dbeda5af99d444fe2198dab4c5efa60dd0275b16'
  BENCHMARKS_URL = 'http://snipersim.org/git/benchmarks.git'
  BENCHMARKS_EXCLUDE = %w(cpu2006 npb splash2)
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    mkdir -p #{SIMULATION_ROOT}

    cd #{SIMULATION_ROOT}
    curl -LO #{PIN_URL}
    tar -xzf #{PIN_BASENAME}.tar.gz
    mv #{PIN_BASENAME} pin

    git clone #{SNIPER_URL} #{SIMULATION_ROOT}/sniper
    cd #{SIMULATION_ROOT}/sniper
    git reset --hard #{SNIPER_COMMIT}
    make

    git clone #{BENCHMARKS_URL} #{SIMULATION_ROOT}/benchmarks
    cd #{SIMULATION_ROOT}/benchmarks
    sed -i.bak '/\(#{BENCHMARKS_EXCLUDE.join('\|')}\)/d' Makefile
    make
  SHELL

  CODE_ROOT = '~/code/github.com/learning-on-chip'
  config.vm.provision 'shell', inline: <<-SHELL
    curl -sSf https://static.rust-lang.org/rustup.sh | sh
  SHELL
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    mkdir -p #{CODE_ROOT}

    git clone https://github.com/learning-on-chip/studio.git #{CODE_ROOT}/studio
    make -C #{CODE_ROOT}/studio install
  SHELL
end
# vim: ft=ruby
