#include <stdbool.h>
#include <stdio.h>

bool is_prime(int n) {
    int ld = n % 10; // last digit

    if (ld == 2 || ld == 4 || ld == 5 || ld == 6 || ld == 8 || ld == 0) {
        return(false);
    }

    int n2 = n / 2;
    while (n2 > 1) {
        if (n % n2 == 0) {
            return false;
        }
        n2--;
    }
    return true;
}

int main() {

    printf("%c", is_prime(14) ? 'Y' : 'N');
    return 1;
}
