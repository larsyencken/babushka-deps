dep 'trash.managed' do
  installs {
    via :apt, 'trash-cli'
  }
  provides []
end

dep 'synergy.managed' do
  installs {
    via :apt, 'synergy'
    via :macports, 'synergy'
  }
  provides []
end

dep 'mercurial', :template => 'pip' do
  provides ['hg']
end

dep 'mercurial.managed' do
  installs {
    via :apt, 'mercurial'
  }
  provides ['hg']
end

dep 'anytop', :template => 'pip'
