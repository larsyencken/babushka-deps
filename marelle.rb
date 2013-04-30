# -*- coding: utf-8 -*-
#
#  marelle.rb
#  deps
#
#  Babushka deps for the Marelle project
#  https://bitbucket.org/larsyencken/marelle/overview
#

dep 'marelle' do
  requires '__marelle checked out', \
    '__marelle updated to master', \
    'swi-prolog',
    '__marelle executable set up'
end

dep 'swi-prolog', :template => 'managed' do
  provides ['swipl']
end

dep '__marelle checked out' do
  setup {
    @repo = Babushka::GitRepo.new("~/.local/marelle")
  }
  met? {
    @repo.exists?
  }
  meet {
    shell "mkdir -p ~/.local"
    @repo.clone!('https://bitbucket.org/larsyencken/marelle')
  }
end

dep '__marelle updated to master' do
  setup {
    @repo = Babushka::GitRepo.new("~/.local/marelle")
    @repo.repo_shell "git fetch"
  }

  met? {
    @repo.repo_shell("git log origin/master -n 1 --pretty='%h'") == @repo.repo_shell("git log -n 1 --pretty='%h'")
  }

  meet {
    @repo.checkout! 'master'
  }
end

dep '__marelle executable set up' do
  setup {
    @bin = "~/.local/bin/marelle"
  }
  met? { @bin.p.exists? }
  meet {
    shell "echo '#!/bin/bash' >#{@bin}"
    shell "echo 'exec swipl -q -t main -s ~/.local/marelle/marelle.pl \"\$@\"' >>#{@bin}"
    shell "chmod a+x #{@bin}"
  }
end
