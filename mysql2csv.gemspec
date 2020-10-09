require_relative 'lib/mysql2csv/version'

Gem::Specification.new do |s|
  s.name          = "mysql2csv"
  s.version       = Mysql2CSV::VERSION
  s.licenses    = ['MIT']
  s.summary = "Runs a series of mySQL queries, dumping each to a CSV file"
  s.description = "Given a job lot of SQL queries to run, will run each of them in turn. The results from each will be output to a CSV file, and when they're all done, those CSV files will be zipped up."
  s.authors = ["Rob Miller", "dirk lüsebrink"]
  s.email = ["rob@bigfish.co.uk", "dirk.luesebrink@gmail.com"]
  s.homepage = "https://github.com/crux/mysql2csv"

  s.add_dependency 'main'
  s.add_dependency 'mysql2'
  s.add_dependency 'escape'
  s.add_dependency 'net-ssh'
  s.add_dependency 'net-ssh-gateway'
  s.add_dependency 'caxlsx'

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "letters"
  s.add_development_dependency "byebug", "~> 11.1"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.metadata    = { "source_code_uri" => "https://github.com/crux/mysql2csv" }
end

__END__

Gem::Specification.new do |spec|
  spec.name          = "mysql2csv"
  spec.version       = Mysql2CSV::VERSION
  spec.authors       = ["dirk lüsebrink"]
  spec.email         = ["dirk.luesebrink@gmail.com"]

  spec.summary = "Runs a series of mySQL queries, dumping each to a CSV file"
  spec.description = "Given a job lot of SQL queries to run, will run each of them in turn. The results from each will be output to a CSV file, and when they're all done, those CSV files will be zipped up."
  spec.homepage = "http://github.com/robmiller/mysql2csv"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")


  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end

__END__
require_relative 'lib/mysql2csv/version'

Gem::Specification.new do |spec|
  spec.name           = "mysql2csv"
  spec.version        = "0.1"
  spec.authors = ["Rob Miller", "dirk lüsebrink"]
  spec.email = ["rob@bigfish.co.uk", "dirk.luesebrink@gmail.com"]
  spec.homepage = "https://github.com/crux/mysql2csv"

  spec.summary = "Runs a series of mySQL queries, dumping each to a CSV file"
  spec.description = "Given a job lot of SQL queries to run, will run each of them in turn. The results from each will be output to a CSV file, and when they're all done, those CSV files will be zipped up."
  spec.required_ruby_version  = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  spec.add_dependency 'main'
  spec.add_dependency 'mysql2'
  spec.add_dependency 'escape'
  spec.add_dependency 'net-ssh'
  spec.add_dependency 'net-ssh-gateway'
  spec.add_dependency 'caxlsx'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "letters"
  spec.add_development_dependency "byebug", "~> 11.1"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
