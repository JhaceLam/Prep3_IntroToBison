#ifndef SYMBOLTALBE_H
#define SYMBOLTABLE_H

#include <iostream>
#include <string>
#include <map>
using namespace std;

typedef map<string, double> MAP_STR_DBL;
typedef pair<string, double> STR_DBL;

class SymbolTable {
private:
    MAP_STR_DBL table;

public:
    MAP_STR_DBL::iterator insert(string s, double t);
    MAP_STR_DBL::iterator lookup(string s);
    MAP_STR_DBL::iterator end();
    void print();
};

#endif