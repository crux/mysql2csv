require_relative 'lib/mysql2csv/version'

Gem::Specification.new do |s|
  s.authors               = ["Rob Miller", "dirk lüsebrink"]
  s.description           = "Given a job lot of SQL queries to run, will run each of them in turn. The results from each will be output to a CSV file, and when they're all done, those CSV files will be zipped up."
  s.email                 = ["rob@bigfish.co.uk", "dirk.luesebrink@gmail.com"]
  s.homepage              = "https://github.com/crux/mysql2csv"
  s.licenses              = ['MIT']
  s.name                  = "mysql2csv"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  s.summary               = "Runs a series of mySQL queries, dumping each to a CSV file"
  s.version               = Mysql2CSV::VERSION


  s.add_dependency 'main', "~> 6.2"
  s.add_dependency 'mysql2', "~> 0.5.3"
  s.add_dependency 'escape', "~> 0.0.4"
  s.add_dependency 'net-ssh', "~> 6.1"
  s.add_dependency 'net-ssh-gateway',  "~> 2.0.0"
  s.add_dependency 'caxlsx', "~> 3.0.2"

  s.add_development_dependency "bundler", "~> 2"
  s.add_development_dependency "rake", "~> 12"
  s.add_development_dependency "letters", "~> 0.4"
  s.add_development_dependency "byebug", "~> 11.1"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.metadata    = { "source_code_uri" => "https://github.com/crux/mysql2csv" }
end
