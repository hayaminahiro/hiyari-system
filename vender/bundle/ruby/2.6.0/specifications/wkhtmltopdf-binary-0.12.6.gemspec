# -*- encoding: utf-8 -*-
# stub: wkhtmltopdf-binary 0.12.6 ruby .

Gem::Specification.new do |s|
  s.name = "wkhtmltopdf-binary".freeze
  s.version = "0.12.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = [".".freeze]
  s.authors = ["Zakir Durumeric".freeze]
  s.date = "2020-06-15"
  s.email = "zakird@gmail.com".freeze
  s.executables = ["wkhtmltopdf".freeze]
  s.files = ["bin/wkhtmltopdf".freeze]
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Provides binaries for WKHTMLTOPDF project in an easily accessible package.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
  else
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
  end
end
