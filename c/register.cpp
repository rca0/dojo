#include <iostream>
#include <cstring>

struct Person {
  char name[30];
  char phone[20];
  char email[30];
};

struct Person date[100];

void showMenu() {
  printf("====== MANAGE USERS =====\n");
  printf("(1) Register\n");
  printf("(2) Update\n");
  printf("(3) List\n");
  printf("(4) Exit\n");
  printf("Option: ");
}

int menu() {
  int op;

  showMenu();
  scanf("%d",&op);

  return(op);
}

void reg(int *q) {
  if (*q >= 99) {
    printf("You can not register, you are already in  limit of 100 users");
  } else {
    printf("Name: ");
    scanf("%s", &date[*q].name);
    printf("Phone: ");
    scanf("%s", &date[*q].phone);
    printf("Email: ");
    scanf("%s", &date[*q].email);
    *q++;
  }
}

void list(int *q) {
  for (int x=0; x < *q; x++) {
    printf("Name: %s", date[*q].name);
    printf("Phone: %s", date[*q].phone);
    printf("Email: %s", date[*q].email);
  }
}

void update(int *q) {
  char new_name[30];
  int aux = -1;

  printf("Name to update: ");
  scanf("%s", &new_name);

  for (int x=0; x < *q; x++) {
    if(strcmp(date[*q].name, new_name) == 0) {
      aux = x;
      break;
    }
    if (aux == -1) {
      printf("Name not found");
    } else {
      printf("==== Updating the user %s ====", date[aux].name);
      printf("Name: ");
      scanf("%s", date[aux].name);
      printf("Phone: ");
      scanf("%s", date[aux].phone);
      printf("Email: ");
      scanf("%s", date[aux].email);
    }
  }
}

int main() {
  int op, amount=0;
  do {
    op = menu();
    switch (op) {
      case 1: reg(&amount); break;
      case 2: update(&amount); break;
      case 3: list(&amount); break;
    }
  } while (op != 4);
}
