task :default => [:atc, :garden]

task :atc do
	Dir.chdir('dockerfiles/atc') do
		FileUtils.rm_rf('build.tgz')
		sh('docker build --rm -t taxiway/atc-build -f Dockerfile.build .')
		sh('docker run --rm taxiway/atc-build > build.tgz')
		sh('docker build --rm -t taxiway/atc -f Dockerfile.run .')
	end
end

task :garden do
	Dir.chdir('dockerfiles/garden') do
		FileUtils.rm_rf('build.tgz')
		sh('docker build --rm -t taxiway/garden-build -f Dockerfile.build .')
		sh('docker run --rm taxiway/garden-build > build.tgz')
		sh('docker build --rm -t taxiway/garden -f Dockerfile.run .')
	end
end
