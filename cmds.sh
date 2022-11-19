
reset() {
	rm -rf build
	mkdir build
	cd build
	cmake ..
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
}

run() {
	compile
	exp $1
}

