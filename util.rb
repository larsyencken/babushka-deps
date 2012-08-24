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
    provides []
end

dep 'mercurial.managed' do
    installs {
        via :apt, 'mercurial'
    }
end
