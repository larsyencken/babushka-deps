dep 'python for computer vision' do
  requires 'simplecv',
    'ipython'
end

#---------------------------------------------------------------------------#

dep 'openmdao' do
  requires 'numpy',
    'scipy',
    'matplotlib',
    'gfortran'

  setup {
    @bin = '~/.local/openmdao/bin/openmdao'
  }

  met? {
    @bin.p.exists?
  }

  meet {
    shell 'mkdir -p ~/.local'
    shell 'curl -o /tmp/go-openmdao.py http://openmdao.org/releases/0.5.5/go-openmdao.py'
    shell "python /tmp/go-openmdao.py ~/.local/openmdao"
  }
end

dep 'simplecv' do
  requires 'numpy',
    'scipy',
    'opencv',
    '__simplecv checked out',
    '__simplecv source at master',
    '__simplecv installed'
end

dep '__simplecv checked out' do
  setup {
    @repo = Babushka::GitRepo.new("~/.local/simplecv")
  }
  met? {
    @repo.exists?
  }
  meet {
    shell "mkdir -p ~/.local"
    @repo.clone!('git://github.com/sightmachine/SimpleCV')
  }
end

dep '__simplecv source at master' do
  setup {
    @repo = Babushka::GitRepo.new("~/.local/simplecv")
    @repo.repo_shell "git fetch"
  }

  met? {
    @repo.repo_shell("git log origin/master -n 1 --pretty='%h'") == @repo.repo_shell("git log -n 1 --pretty='%h'")
  }

  meet {
    @repo.checkout! 'master'
  }
end

dep '__simplecv installed' do
  requires 'pygame',
    'pip'
  met? {
    shell "pip freeze | fgrep -q 'egg=SimpleCV-dev'"
  }

  meet {
    shell "python setup.py develop", :sudo => (! File.writable? "/usr/local/lib"), :cd => '~/.local/simplecv'
  }
end

dep 'opencv', :template => 'managed' do
  installs {
    on :osx, 'opencv'
    on :ubuntu, 'python-opencv'
  }
  provides []
end

dep '__pygame on ubuntu', :template => 'managed' do
  installs 'python-pygame'
  provides []
end

dep '__pygame on osx', :template => 'managed' do
  requires 'samueljohn homebrew tap',
    'smpeg on osx',
    'nose.pip'
  installs 'pygame'
  provides []
end

dep 'sdl', :template => 'managed' do
  installs {
    on :osx, 'sdl'
    on :ubuntu, 'libsdl1.2-dev'
  }
  provides []
end

dep 'pygame' do
  requires {
    on :osx, '__pygame on osx'
    on :ubuntu, '__pygame on ubuntu'
  }
end

dep 'pygame', :template => 'pip' do
  provides []
  meet {
    shell "pip install pygame", :sudo => (! File.writable? "/usr/local/lib")
  }
end

dep 'sdl', :template => 'managed' do
  provides []
end

dep 'sdl_image', :template => 'managed' do
  provides []
end

dep 'sdl_mixer', :template => 'managed' do
  provides []
end

dep 'sdl_ttf', :template => 'managed' do
  provides []
end

dep 'portmidi', :template => 'managed' do
  provides []
end

dep '__pygame checked out' do
  requires 'mercurial'
  setup {
    @repo = '~/.local/pygame'
  }
  met? {
    @repo.p.exists?
  }
  meet {
    shell "mkdir -p ~/.local && hg clone http://bitbucket.org/pygame/pygame #{@repo}"
  }
end

dep '__pygame source at master' do
  setup {
    @repo = '~/.local/pygame'
    shell "cd #{@repo} && hg pull"
  }

  met? {
    @repo.repo_shell("git log origin/master -n 1 --pretty='%h'") == @repo.repo_shell("git log -n 1 --pretty='%h'")
  }

  meet {
    @repo.checkout! 'master'
  }
end

dep '__pygame installed' do
  requires 'pygame'
  met? {
    shell "pip freeze | fgrep -q 'egg=pygame-dev'"
  }

  meet {
    shell "cd ~/.local/pygame && python setup.py develop"
  }
end

dep 'samueljohn homebrew tap' do
  setup { @path = "/usr/local/Library/Taps/samueljohn-python" }
  met? { @path.p.exists? }
  meet {
    shell "brew tap samueljohn/python"
  }
end

dep 'smpeg on osx', :template => 'managed' do
  requires 'homebrew head tap',
    'glib'
  installs 'smpeg'

  meet {
    shell "brew install --HEAD smpeg"
  }

  provides []
end

dep 'homebrew head tap' do
  setup { @path = "/usr/local/Library/Taps/homebrew-headonly" }
  met? { @path.p.exists? }
  meet {
    shell "brew tap homebrew/headonly"
  }
end

dep 'glib', :template => 'managed' do
  provides []
end

dep 'nose.pip' do
  provides ['nosetests']
end

dep 'zbar.managed' do
  provides []
end

dep 'zbar', :template => 'pip' do
  requires 'zbar.managed'
  provides []
end

dep 'ffmpeg', :template => 'managed'
