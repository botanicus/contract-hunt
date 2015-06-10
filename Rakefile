NAME = File.basename(Dir.pwd)
PATH = "/apps/#{NAME}"

desc "Build and run the container."
task default: ['docker:build', 'docker:run']

namespace :docker do
  desc "Build the image."
  task :build do
    sh "docker build -t #{NAME} ."
  end

  desc "Run the container."
  task :run do
    sh "docker run -d -p 80:80 -v #{Dir.pwd}:#{PATH}:ro #{NAME}"
  end

  desc "SSH into a running container."
  task :ssh do
    id = %x{docker ps | grep #{NAME}:latest | awk '{ print $1 }'}.chomp
    sh "docker exec -it #{id} /bin/sh"
  end
end
