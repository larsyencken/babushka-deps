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
  requires 'julia source checked out', \
      'gfortran' \

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

dep 'gfortran', :template => 'managed' do
end

