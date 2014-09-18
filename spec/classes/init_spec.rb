require 'spec_helper'
describe 'puppetboard' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetboard') }
  end
end
