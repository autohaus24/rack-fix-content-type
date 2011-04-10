Gem::Specification.new do |s|
  s.name = "rack-fix-content-type"
  s.summary = "fix the content type of form uploads by using the file-utility."
  s.description = "fix the content type of form uploads by using the file-utility. A lot of browsers screw up the content type so we don't trust the given value in the header."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "1.0"
  s.authors = ["Gregor Melhorn", "Michael Raidel"]
  s.email = ["g.melhorn@autohaus24.de", "raidel@induktiv.at"]
  s.homepage = ""
end
