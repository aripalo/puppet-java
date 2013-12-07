require 'spec_helper'

describe "java" do
  let(:facts) { default_test_facts }

  it do
    should include_class('boxen::config')

    should contain_package('jre7u45.dmg').with({
      :ensure   => 'installed',
      :alias    => 'java-jre',
      :provider => 'pkgdmg',
      :source   => '/test/boxen/repo/.tmp/jre7u45.dmg',
      :require  => 'Exec[download-jre]',
    })

    should contain_package('jdk7u45.dmg').with({
      :ensure   => 'installed',
      :alias    => 'java',
      :provider => 'pkgdmg',
      :source   => '/test/boxen/repo/.tmp/jdk7u45.dmg',
      :require  => 'Exec[download-jdk]',
    })

    should contain_file('/test/boxen/bin/java').with({
      :source  => 'puppet:///modules/java/java.sh',
      :mode    => '0755',
      :require => 'Package[java]'
    })
  end
end
