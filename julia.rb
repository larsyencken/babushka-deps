dep 'julia' do
  requires 'julia built'
  setup {
    @bin = '~/.local/bin/julia'
  }
  met? { @bin.p.exists? }
  meet {
    shell 'mkdir -p ~/.local/bin'
    shell 'rm -f ~/.local/bin/julia'
    shell 'ln -s ~/.local/julia/julia ~/.local/bin/julia'
  }
end

dep 'julia built' do
  requires 'julia source checked out',
      'gfortran',
      'm4',
      'ncurses'

  setup {
    @bin = '~/.local/julia/julia'
  }
  met? { @bin.p.exists? }
  meet {
    shell "mkdir -p ~/.local"
    shell "cd ~/.local/julia; make -j 3"
  }
end

dep 'julia source checked out' do
  setup {
    @repo = Babushka::GitRepo.new('~/.local/julia')
  }
  met? { @repo.exists? }
  meet {
    @repo.clone!('git://github.com/JuliaLang/julia')
  }
end

dep 'ncurses' do
  requires {
    on :ubuntu, ['ncurses.managed']
  }
end

dep 'ncurses.managed' do
  installs 'libncurses5', 'libncurses5-dev'
  provides []
end

dep 'local binaries in path' do
  met? {
    shell "fgrep 'export PATH=${HOME}/.local/bin:${PATH}' ~/.bashrc"
  }
  meet {
    shell "echo 'export PATH=${HOME}/.local/bin:${PATH}' >>~/.bashrc"
  }
end
