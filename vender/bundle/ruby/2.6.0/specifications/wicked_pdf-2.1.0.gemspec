# -*- encoding: utf-8 -*-
# stub: wicked_pdf 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "wicked_pdf".freeze
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/mileszs/wicked_pdf/blob/master/CHANGELOG.md" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Miles Z. Sterrett".freeze, "David Jones".freeze]
  s.date = "2020-06-14"
  s.description = "Wicked PDF uses the shell utility wkhtmltopdf to serve a PDF file to a user from HTML.\nIn other words, rather than dealing with a PDF generation DSL of some sort,\nyou simply write an HTML view as you would normally, and let Wicked take care of the hard stuff.\n".freeze
  s.email = ["miles.sterrett@gmail.com".freeze, "unixmonkey1@gmail.com".freeze]
  s.homepage = "https://github.com/mileszs/wicked_pdf".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.requirements = ["wkhtmltopdf".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "PDF generator (from HTML) gem for Ruby on Rails".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.68.0"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<mocha>.freeze, ["= 1.3"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.68.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<mocha>.freeze, ["= 1.3"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end
