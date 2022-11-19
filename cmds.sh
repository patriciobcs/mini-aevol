
reset() {
	rm -rf build
	mkdir build
	cd build
	cmake .. -DCMAKE_OSX_ARCHITECTURES=arm64
	make
	cd ..
}

compile() {
	cd build
	make
	cd ..
}

exp() {
	mkdir -p experiments/$1
	cd experiments/$1
	../../build/mini_aevol_cpu -s 42
	cd ../..
}

run() {
	compile
	exp $1
}

