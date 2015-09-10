task :default => [:atc, :garden]

task :atc do
	Dir.chdir('dockerfiles/atc') do
		FileUtils.rm_rf('build')
		sh('docker build -t taxiway/atc-build -f Dockerfile.build .')
		sh('docker run --rm taxiway/atc-build | tar xvf -')
		sh('docker build -t taxiway/atc -f Dockerfile.run .')
	end
end
