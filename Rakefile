NAME = File.basename(Dir.pwd)
PATH = "/apps/#{NAME}"

desc "Build and run the container."
task default: ['docker:build', :test]

desc "Test if everything's OK."
task :test do
  File.unlink('tmp/contract-hunt.yml') if File.exist?('tmp/contract-hunt.yml')
  sh "docker run -it -v #{Dir.pwd}:/apps/#{NAME}:ro -v #{Dir.pwd}/tmp:/data -e 'DBG=true' #{NAME} bundle exec bin/contract-hunt.rb /data"
end

namespace :docker do
  desc "Build the image."
  task :build do
    sh "docker build -t #{NAME} ."
  end

  desc "Run the container."
  task :run do
    sh "docker run -v #{Dir.pwd}:#{PATH}:ro -v #{Dir.pwd}/tmp:/data #{NAME}"
  end

  desc "SSH into a running container."
  task :ssh do
    id = %x{docker ps | grep #{NAME}:latest | head -1 | awk '{ print $1 }'}.chomp
    sh "docker exec -it #{id} /bin/sh"
  end
end
