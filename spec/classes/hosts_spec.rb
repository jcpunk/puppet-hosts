# frozen_string_literal: true

require 'spec_helper'

describe 'hosts' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/etc/hosts')
            .with_owner('root')
            .with_group('root')
            .with_mode('0644')
        }
      end
      context 'with params' do
        let(:params) do
          {
            'add_entries' => {
              'myhostname.example.com' => {
                'ipv4'                 => '127.0.0.1',
                'ipv6'                 => '::1',
                'aliases'              => ['myhostname', 'myname'],
                'comment'              => 'some string goes here'
              },
           'AAAAAAAAAA.example.com' => {
             'ipv4'                 => '127.0.0.1',
           },
           'BBBBBBBBBB.example.com' => {
             'ipv6'                 => '::1',
           }
            }
          }
        end

        it { is_expected.to compile }
        it {
          is_expected.to contain_file('/etc/hosts').with_content(%r{127.0.0.1\s+AAAAAAAAAA.example.com})
          is_expected.to contain_file('/etc/hosts').with_content(%r{::1\s+BBBBBBBBBB.example.com})
          is_expected.to contain_file('/etc/hosts').with_content(%r{127.0.0.1\s+myhostname.example.com myhostname myname # some string goes here})
          is_expected.to contain_file('/etc/hosts').with_content(%r{::1\s+myhostname.example.com myhostname myname # some string goes here})
        }
      end
    end
  end
end
