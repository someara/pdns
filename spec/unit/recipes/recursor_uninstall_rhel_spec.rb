require 'spec_helper'

describe 'pdns_test::recursor_uninstall' do
  context 'on rhel platform' do
    let(:rhel_runner) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '6.8',
        step_into: ['pdns_recursor_install']) do |node|
        node.automatic['packages']['centos-release']['version'] = '6'
      end
    end

    let(:chef_run) { rhel_runner.converge(described_recipe) }
    let(:version) { '4.0.4-1pdns.el6' }

    it 'removes pdns package with version' do
      expect(chef_run).to remove_yum_package('pdns-recursor')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end