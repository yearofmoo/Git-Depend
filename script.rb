#!/usr/bin/env ruby

=begin

description: Git-Depend is a small tool to clone/pull repositories without the need to manage them as submodules

license: MIT License http://www.opensource.org/licenses/mit-license.php

authors:
- Matias Niemelä (matias [at] yearofmoo [dot] com)

home:
- http://www.yearofmoo.com/Git-Depend

requires:
- Git
- Ruby (RubyGems + YAML and MD5 Hashing Support)
- Bash

=end

require 'rubygems'
require 'yaml'
require 'digest/md5'

file = './.gitdepend'
root = Dir.pwd

def open_yaml_file(file)
  begin
    f = YAML.load_file(file)
  rescue; end
  f
end

doc = open_yaml_file(file)
if doc.nil? || doc == {}
  file += '.yml'
  doc = open_yaml_file(file)
  if doc.nil? || doc == {}
    puts "Git-Depend: Concat file has not been set yet..."
    exit
  end
end

files = doc
files.each do |file|
  repo = file['repo']
  path = file['path']
  branch = file['branch'] || 'master'
  reset = file.has_key?('reset') ? file['reset'] == 'true' : true

  if File.directory?(path) && File.directory?(File.join(path,'.git/'))
    Dir.chdir(path)
    if reset 
      `git reset --hard HEAD`
    end
    `git pull origin #{branch}`
    Dir.chdir(root)
  else
    `mkdir -p #{path}`
    `git clone #{repo} #{path}`
    if branch != 'master'
      `git checkout #{branch}`
      `git pull origin #{branch}`
    end
  end

end
