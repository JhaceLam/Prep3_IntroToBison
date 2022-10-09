#include <iostream>
#include <string>
#include <any>
#include <cstring>
using namespace std;

int main() {
    char *str = (char *) malloc(50 * sizeof(char));
    strcpy(str, "adadwd");
    cout << string(str) << endl;
}