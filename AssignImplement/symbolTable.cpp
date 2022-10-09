#include "symbolTable.h"

MAP_STR_DBL::iterator SymbolTable::insert(string s, double t) {
    pair<MAP_STR_DBL::iterator, bool> ret = table.insert(STR_DBL(s, t));
    if (ret.second) {
        // cout << "Insert identifier \"" << s << "\" with value: " << t << endl; 
    } else {
        table[s] = t;
        // cout << "Update identifier \"" << s << "\" with value: " << t << endl; 
    }
    return ret.first;
}

MAP_STR_DBL::iterator SymbolTable::lookup(string s) {
    return table.find(s);
}

MAP_STR_DBL::iterator SymbolTable::end() {
    return table.end();
}

void SymbolTable::print() {
    for (MAP_STR_DBL::iterator it = table.begin(); it != table.end(); it++) {
        cout << it->first << " = " << it->second << endl;
    }
}