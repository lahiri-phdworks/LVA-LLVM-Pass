LLVM_CONFIG=llvm-config
CXX=clang++ -std=c++17 -O0
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -g -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

all: llvm_lva_pass.so bitcode_generation allpasses 

llvm_lva_pass.so: llvm_lva_pass.o 
	$(CXX) $(CXXFLAGS) -shared build/live_variable_analysis_main_pass.o -o build/live_variable_analysis_main_pass.so $(LDFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/functionpass.o -o build/functionpass.so $(LDFLAGS)

llvm_lva_pass.o: live_variable_analysis_main_pass.cpp
	$(CXX) -c live_variable_analysis_main_pass.cpp -o build/live_variable_analysis_main_pass.o $(CXXFLAGS)
	$(CXX) -c functionpass.cpp -o build/functionpass.o $(CXXFLAGS)

llvmir_generation: 
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test_case_5.cpp -o bin/test_case_5.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test_case_5.cpp -o bin/test_case_5.ll

bitcode_generation: llvmir_generation
	opt -instnamer -mem2reg -enable-new-pm=0 bin/test_case_5.bc -S -o bin/bitcodes/test_case_5_mem2reg.bc

allpasses: 
	opt -disable-output -enable-new-pm=0 -load build/live_variable_analysis_main_pass.so -liveness < bin/bitcodes/test_case_5_mem2reg.bc -f 2> output/vars.log
	opt -disable-output -load-pass-plugin=build/functionpass.so -passes="firstpass" < bin/bitcodes/test_case_5_mem2reg.bc -f 2> output/firstpass.log

clean: 
	rm -rf output/* build/*  bin/* && cd bin && mkdir bitcodes
