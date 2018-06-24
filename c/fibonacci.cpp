#include <iostream>

int Fib(int n1, int n2, int imp, int limit) {
  printf("%d", n2);

  if (imp == limit)
    return(0);
    else
    Fib(n2,(n1+n2), imp++, limit);
}

int main () {
  int num;

  printf("Type position: ");
  scanf("%d", &num);

  Fib(0, 1, 1, num);
  return 0;
}
