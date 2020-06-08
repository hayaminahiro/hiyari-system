# -*- encoding: utf-8 -*-
# stub: google-authenticator-rails 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "google-authenticator-rails".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jared McFarland".freeze]
  s.date = "2018-07-02"
  s.description = "Add the ability to use the Google Authenticator with ActiveRecord.".freeze
  s.email = ["jared.online@gmail.com".freeze]
  s.homepage = "http://github.com/jaredonline/google-authenticator".freeze
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Add the ability to use the Google Authenticator with ActiveRecord.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rotp>.freeze, ["= 3.3.0"])
    s.add_runtime_dependency(%q<rails>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<google-qr>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<actionpack>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 2.8.0"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 0.5.1"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rotp>.freeze, ["= 3.3.0"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_dependency(%q<google-qr>.freeze, [">= 0"])
    s.add_dependency(%q<actionpack>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.8.0"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 0.5.1"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
