require 'spec_helper_acceptance'

describe 'odoo module' do

  install_odoo10_pp = <<-EOS
    class { 'postgresql::server':
      before => Class['odoo']
    }

    class { '::odoo::repo10':
      before => Class['odoo']
    }

    class { '::odoo':
      install_wkhtmltopdf => true,
      settings            => {
        'options' => {
          'admin_passwd' => 'XXX_TOP_SECRET_XXX_10',
          'db_host'      => 'False',
          'db_port'      => 'False',
          'db_user'      => 'odoo',
          'db_password'  => 'False',
          'addons_path'  => '/usr/lib/python2.7/dist-packages/odoo/addons',
        }
      },
      version             => present,
    }
  EOS

  describe 'Odoo 10 installation.' do
    it 'should work with no errors' do
      apply_manifest(install_odoo10_pp, catch_failures: true)
    end

    it 'should be idempotent' do
      expect(apply_manifest(install_odoo10_pp,
                            catch_failures: true).exit_code).to be_zero
    end
  end

  describe package('odoo') do
    it { is_expected.to be_installed }
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end

  install_odoo13_pp = <<-EOS
    class { 'postgresql::server':
      before => Class['odoo']
    }

    class { '::odoo::repo10':
      before => Class['odoo']
    }

    class { '::odoo':
      install_wkhtmltopdf => true,
      settings            => {
        'options' => {
          'admin_passwd' => 'XXX_TOP_SECRET_XXX_10',
          'db_host'      => 'False',
          'db_port'      => 'False',
          'db_user'      => 'odoo',
          'db_password'  => 'False',
          'addons_path'  => '/usr/lib/python3/dist-packages/odoo/addons',
        }
      },
      version             => present,
    }
  EOS

  describe 'Odoo 13 installation.' do
    it 'should work with no errors' do
      apply_manifest(install_odoo13_pp, catch_failures: true)
    end

    it 'should be idempotent' do
      expect(apply_manifest(install_odoo13_pp,
                            catch_failures: true).exit_code).to be_zero
    end
  end

  describe package('odoo') do
    it { is_expected.to be_installed }
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
