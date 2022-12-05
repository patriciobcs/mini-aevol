NUM_THREADS = 2
L = 0

setup:
	# export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"
	# export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
	rm -rf $(PWD)/build
	mkdir $(PWD)/build
	cd $(PWD)/build && cmake .. -DCMAKE_OSX_ARCHITECTURES=arm64 && make

setup-x:
	rm -rf $(PWD)/build
	mkdir $(PWD)/build
	cd $(PWD)/build && cmake .. -DCMAKE_OSX_ARCHITECTURES=x86_64 && make

compile:
	cd $(PWD)/build/ && make

run:
	make compile
	mkdir -p experiments/level_$L
	cd $(PWD)/experiments/level_$L && $(PWD)/build/mini_aevol_cpu -s 1892873 -p $L

prof:
	make compile
	mkdir -p experiments/level_$L
	rm -rf experiments/level_$L/L$L.trace
	cd $(PWD)/experiments/level_$L && arch -arm64 xctrace record --output 'L$L.trace' --append-run --template 'Time Profiler' --target-stdout - --launch -- $(PWD)/build/mini_aevol_cpu -s 1892873 -p $L
	open -a Instruments ./experiments/level_$L/L$L.trace                           

traces:
	for i in $$(seq 1 $A); do \
		for t in 2 4 8; do \
			path=$(PWD)/traces/$T/$$i/$$t; \
			mkdir -p $$path && cd $$path && $(PWD)/build/mini_aevol_cpu -s 1892873 -p $L -n $N -t $$t && rm -rf $$path/backup && rm -rf $$path/stats; \
		done; \
	done

all:
	make run L=0
	# make run L=1