require 'spec_helper'

describe 'vagrant::user' do
  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
    it { should contain_user('vagrant').with_ensure('present') }
    it { should contain_group('vagrant').with_ensure('present') }
    it { should contain_file('/home/vagrant/.ssh').with_ensure('directory') }
    it { should contain_file('/home/vagrant/.ssh/authorized_keys').with_owner('vagrant') }
    it { should contain_file('/etc/sudoers.d/vagrant').with_owner('root') }
  end

  context 'user_name => bogus_user, group_name => bogus_group' do
    let(:user_name) { 'bogus_user' }
    let(:group_name) { 'bogus_user' }
    let(:params) { { :user_name => user_name, :group_name => group_name } }
    it { should compile.with_all_deps }
    it { should contain_user(user_name).with_ensure('present') }
    it { should contain_group(group_name).with_ensure('present') }
  end

  context 'ensure => absent' do
    let(:params) { { :ensure => 'absent' } }
    it { should compile.with_all_deps }
    it { should contain_user('vagrant').with_ensure('absent') }
    it { should contain_group('vagrant').with_ensure('absent') }
    it { should contain_file('/home/vagrant/.ssh').with_ensure('absent') }
    it { should contain_file('/home/vagrant/.ssh/authorized_keys').with_ensure('absent') }
    it { should contain_file('/etc/sudoers.d/vagrant').with_ensure('absent') }
  end

  context 'sudo_ensure => absent' do
    let(:params) { { :sudo_ensure => 'absent' } }
    it { should compile.with_all_deps }
    it { should contain_user('vagrant').with_ensure('present') }
    it { should contain_group('vagrant').with_ensure('present') }
    it { should contain_file('/etc/sudoers.d/vagrant').with_ensure('absent') }
  end
end