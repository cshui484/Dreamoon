CXX        := g++-4.8
#CXX        := gcc
CXXFLAGS   := -pedantic -std=c++11 -Wall
LDFLAGS    := -lgtest -lgtest_main -pthread
GCOV       := gcov-4.8
GCOVFLAGS  := -fprofile-arcs -ftest-coverage
GPROF      := gprof
GPROFFLAGS := -pg
VALGRIND   := valgrind

clean:
	rm -f *.gcda
	rm -f *.gcno
	rm -f *.gcov
	rm -f RunDreamoon
	rm -f RunDreamoon.tmp
	rm -f TestDreamoon
	rm -f TestDreamoon.tmp
	rm -f solution
	rm -f *~

config:
	git config -l

scrub:
	make  clean
	rm -f  Dreamoon.log
	rm -rf dreamoon-tests
	rm -rf html
	rm -rf latex

status:
	make clean
	@echo
	git branch
	git remote -v
	git status

test: RunDreamoon.tmp TestDreamoon.tmp

solution: solution.cpp
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) solution.cpp -o solution

shi: shi.cpp
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) shi.cpp -o shi

#RunDreamoon: Dreamoon.h Dreamoon.c++ RunDreamoon.c++
#	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) Dreamoon.c++ RunDreamoon.c++ -o RunDreamoon
RunDreamoon: Dreamoon.c++
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) Dreamoon.c++ -o RunDreamoon

RunDreamoon.tmp: RunDreamoon
	./RunDreamoon < RunDreamoon.in > RunDreamoon.tmp
	diff -w RunDreamoon.tmp RunDreamoon.out

#TestDreamoon: Dreamoon.h Dreamoon.c++ TestDreamoon.c++
TestDreamoon: TestDreamoon.c++
	$(CXX) $(CXXFLAGS) $(GCOVFLAGS) TestDreamoon.c++ -o TestDreamoon $(LDFLAGS)

TestDreamoon.tmp: TestDreamoon
	$(VALGRIND) ./TestDreamoon                                       >  TestDreamoon.tmp 2>&1
	$(GCOV) -b Dreamoon.c++     | grep -A 5 "File 'Dreamoon.c++'"     >> TestDreamoon.tmp
	$(GCOV) -b TestDreamoon.c++ | grep -A 5 "File 'TestDreamoon.c++'" >> TestDreamoon.tmp
	cat TestDreamoon.tmp
