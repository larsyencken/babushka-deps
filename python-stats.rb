dep 'python for statistics' do
  requires 'python',
    'numpy',
    'scipy',
    'ipython',
    'matplotlib',
    'pandas',
    'networkx'
end

#---------------------------------------------------------------------------#

dep 'ipython', :template => 'pip' do
  provides ['ipython']
end

dep 'ipython.managed' do
  installs 'ipython'
  provides ['ipython']
end

dep 'matplotlib' do
  requires {
    on :osx, 'python', 'matplotlib.pip'
    on :ubuntu, 'python', 'matplotlib.managed'
  }
end

dep 'matplotlib.managed' do
  installs 'python-matplotlib'
  provides []
end

dep 'matplotlib.pip' do
  provides []
end

dep 'networkx', :template => 'pip' do
  requires 'pyparsing'  # not picked up in pip dependencies
  provides []
end

dep 'numpy' do
  requires {
    on :ubuntu, 'numpy.managed'
    on :osx, 'numpy.pip'
  }
end

dep 'numpy.managed' do
  installs 'python-numpy'
  provides []
end

dep 'numpy.pip' do
  provides []
end

dep 'pandas', :template => 'pip' do
  provides []
end

dep 'pandas.managed' do
  installs 'python-pandas'
  provides []
end

dep 'pyparsing', :template => 'pip' do
  provides []
end

dep 'python', :template => 'managed' do
  installs {
    via :apt, 'python-dev'
    via :brew, 'python'
  }
  provides ['python']
end

dep 'python-dev.managed' do
  provides []
end

dep 'scipy' do
  requires {
    on :osx, 'python', 'scipy.pip'
    on :ubuntu, 'python', 'scipy.managed'
  }
end

dep 'scipy.managed' do
  installs 'python-scipy'
  provides []
end

dep 'scipy.pip' do
  provides []
end
