// ----------------------------
// projects/dreamoon/Dreamoon.c++
// Copyright (C) 2015
// CS Hui
// ----------------------------

// --------
// includes
// --------

#include <cassert>  // assert
#include <iostream> // endl, istream, ostream
#include <sstream>  // istringstream
#include <string>   // getline, string
#include <utility>  // make_pair, pair
#include <deque>
#include <functional>
#include <map>
#include <climits>
#include <set>
#include <vector>
#include <math.h>
//#include <gmpxx.h>

//include "Dreamoon.h

using namespace std;
using BNUM = unsigned long long;
	
// -------------
// gcd
// -------------
//template <typename T>
BNUM comb(int n, int r) {
	BNUM rc = 1;
	
	if (r > (n >> 2)) {
		r = n - r; }
	for (int i=1; i<=r; i++) {
		rc = rc * (n-r+i) / i; }
		
	return rc; }
	
// -------------
// dreamoon_solve
// -------------

void dreamoon_solve (istream& r, ostream& w) {
    string  s1, s2;				// inputs: reference and matching
    int n1=0, n2=0, q=0;		// n1, n2 = # of '+' in s1 and s2; q = # of '?'
    float p;					// result: probability
    unsigned int i;				// tmp var
	
	r >> s1 >> s2;

	for	(i=0; i<s1.size(); i++) {
		if (s1[i] == '+') {
			n1++; }}
	for	(i=0; i<s1.size(); i++) {
		if (s2[i] == '+') {
			n2++; }
		else if (s2[i] == '?') {
			q++; }}
			
	if ((n1 < n2) || (n1-n2 > q)) {
		p = 0.0; }
	else {
		if (q == 0) {
			p = 1.0; }
		else {
			p = comb(q, n1-n2) * pow((0.5), q); }}
			
	w.precision(12);
	w << fixed << p << endl; 
//	w << n1 << ' ' << n2 << ' ' << q << ' ' << pow((0.5),q) << endl;

}
	
// ----
// main
// ----

int main () {
    using namespace std;
//    cout << "main" << endl;
    dreamoon_solve(cin, cout);
    return 0;}


