NUM_THREADS = 2
L = 0

setup:
	# export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"
	# export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
	rm -rf $(PWD)/build
	mkdir $(PWD)/build
	cd $(PWD)/build && cmake .. -DCMAKE_OSX_ARCHITECTURES=arm64 && make

compile:
	cd $(PWD)/build/ && make

run:
	make compile
	mkdir -p experiments/level_$L
	cd $(PWD)/experiments/level_$L && $(PWD)/build/mini_aevol_cpu -s 42 -p $L

prof:
	make compile
	mkdir -p experiments/level_$L
	rm -rf experiments/level_$L/Launch_mini_aevol_cpu_* 
	cd $(PWD)/experiments/level_$L && arch -arm64 xctrace record --template 'Time Profiler' --target-stdout - --launch -- $(PWD)/build/mini_aevol_cpu -s 42 -p $L
	open -a Instruments ./experiments/level_$L/Launch_mini_aevol_cpu_*                            

all:
	make run L=0
	make run L=1