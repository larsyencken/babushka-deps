dep 'drake' do
  requires 'drake checked out', \
    'drake updated to master', \
    'leiningen', \
    'drake built', \
    'drake executables set up'
end

dep 'drake executables set up' do
  setup {
    @bin = "~/.local/bin/drake"
    @jar = "~/.local/drake/target/drake.jar"
  }
  met? { @bin.p.exists? and @jar.p.exists? }
  meet {
    shell "mkdir -p $(dirname #{@bin})"
    shell "echo '#!/bin/bash' >#{@bin}"
    shell "echo 'exec java -jar #{@jar} \"\$@\"' >>#{@bin}"
    shell "chmod a+x #{@bin}"
  }
end

dep 'drake built' do
  setup {
    @jar = "~/.local/drake/target/drake.jar"
  }
  met? { @jar.p.exists? }
  meet {
    shell "cd ~/.local/drake; lein uberjar"
  }
end

dep 'drake updated to master' do
  setup {
    @repo = Babushka::GitRepo.new("~/.local/drake")
    @repo.repo_shell "git fetch"
  }

  met? {
    @repo.repo_shell("git log origin/master -n 1 --pretty='%h'") == @repo.repo_shell("git log -n 1 --pretty='%h'")
  }

  meet {
    @repo.checkout! 'master'
  }
end

dep 'drake checked out' do
  setup {
    @repo = Babushka::GitRepo.new("~/.local/drake")
  }
  met? {
    @repo.exists?
  }
  meet {
    shell "mkdir -p ~/.local"
    @repo.clone!('git://github.com/Factual/drake')
  }
end

dep 'leiningen' do
  setup {
    @bin = '~/.local/bin/lein'
  }
  met? { @bin.p.exists? }
  meet {
    shell "mkdir -p ~/.local/bin"
    shell "curl -o #{@bin} https://raw.github.com/technomancy/leiningen/stable/bin/lein"
    shell "chmod a+x #{@bin}"
  }
end
