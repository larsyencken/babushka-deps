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

dep 'vim.managed' do
    installs {
        via :apt, 'vim-nox'
    }
    requires 'ctags.managed'
end

dep 'ctags.managed' do
    installs {
        via :apt, 'exuberant-ctags'
    }
end

dep 'mercurial.managed' do
    installs {
        via :apt, 'mercurial'
    }
    provides ['hg']
end

dep 'mercurial.pip' do
    provides ['hg']
end

dep 'anytop.pip' do
    provides ['anytop']
end
