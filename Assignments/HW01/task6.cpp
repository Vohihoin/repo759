#include <iostream>
#include <cstdlib>
#include <cstdio>

int main(int argc, char* argv[]){
    if (argc < 2){ // one for the program name, one for the first CLA
        exit(0);
    }

    int N = atoi(argv[1]);

    // Print out 0 - N using printf
    for (int i = 0; i <= N; i++){
        printf("%d%s", i, ((i == N) ? "\n" : " "));
    }

    // Print out N - 0 using std::cout
    for (int i = N; i >= 0; i--){
        std::cout << i << ((i == 0) ? "\n" : " ");
    }
    
}