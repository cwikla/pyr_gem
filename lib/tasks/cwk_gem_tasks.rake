require 'geminabox'

class GemRelease
  CWK_GEM_SERVER = "http://cwkgems:c3po42@gems.cwikla.com"

  def version_file
    vfiles = Dir["lib/cwk/**/version.rb"]

    raise ArgumentError, "Too many version files!" if vfiles.length > 1

    #puts "Version file #{vfiles[0]}"
    return vfiles[0]
  end

  def initialize
    File.open(version_file) do |f|
      @full_content = f.read
      matches = /VERSION\s*=\s*\"(\d+\.\d+\.\d+)\"/.match(@full_content)[1]
      @version = matches.split(".").map { |x| x.to_i }
    end

    @gem_spec = Dir["*.gemspec"][0] # if it ain't there, let it fail
  end

  def save
    File.open(version_file, "w") do |f|
      new_version = @version.join(".")
      new_content = @full_content.gsub(/VERSION\s*=\s*\"(\d+\.\d+\.\d+)\"/, "VERSION = \"#{new_version}\"")
      f.write(new_content)
    end
  end

  def to_s
    "#{@version[0]}.#{@version[1]}.#{@version[2]}"
  end

  def inc_major
    @version = @version[0]+1, 0, 0
  end

  def inc_minor
    @version = @version[0], @version[1]+1, 0
  end

  def inc_point
    @version = @version[0], @version[1], @version[2]+1
  end

  def push(dest)
    branch = self.to_s
    puts "Synching branches"
    system "git fetch"
    system "git pull"
    system "git checkout #{branch}" #

    #puts "Pushing branch #{branch} to #{dest}"
    system "gem build #{@gem_spec}"
    gem_file = Dir["*.gem"][0]

    system "gem inabox -g #{dest} #{gem_file}"

    File.delete(gem_file)
    system "git checkout master"
  end

  def git_branch
    system "git checkout master"
    puts "git commit #{version_file} -m 'Branch'"
    system "git commit #{version_file} -m 'Branch'"
    system "git branch #{self.to_s}"
    system "git push -u origin #{self.to_s}"
    system "git push origin master"
  end

end

namespace :gem do
  desc "Show Gem Version"
  task :version do # => :environment do
    gr = GemRelease.new
    puts gr.to_s
  end

  desc "Make a new point git branch from master"
  task :point do # => :environment do
    system "git checkout master"
    gr = GemRelease.new
    gr.inc_point
    gr.save
    gr.git_branch
    puts "Release now at #{gr.to_s}"
  end

  desc "Make a new minor git branch from master"
  task :minor do #=> :environment do
    system "git checkout master"
    gr = GemRelease.new
    gr.inc_minor
    gr.save
    gr.git_branch
    puts "Release now at #{gr.to_s}"
  end

  desc "Make a new major git branch from master"
  task :major do # => :environment do
    system "git checkout master"
    gr = GemRelease.new
    gr.inc_major
    gr.save
    gr.git_branch
    puts "Release now at #{gr.to_s}"
  end

  desc "Push a new gem version"
  task :push do # => :environment do
    gr = GemRelease.new
    gr.to_s
    gr.push(GemRelease::CWK_GEM_SERVER)
  end
end
