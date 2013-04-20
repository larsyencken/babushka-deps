dep 'octave.managed' do
  installs {
    via :apt, 'octave3.2'
  }
  provides []
end

