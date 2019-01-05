import os


OPTIONS = [
    'Addition',
    'Subtraction',
    'Multiplication',
    'Division',
]

FUNCTION = {
    1: lambda a, b: a+b,
    2: lambda a, b: a-b,
    3: lambda a, b: a*b,
    4: lambda a, b: a/b,
}


def msg_error(msg, err=""):
    print(msg, err)


class Calculator(object):

    def __init__(self):
        self.run()

    def run(self):

        while True:
            options = OPTIONS
            print("Calculator CLI")
            for i in range(len(options)):
                print(i+1, "-", options[i])

            try:
                choice = int(input("Choice any option: "))
            except ValueError:
                msg_error("[ERROR] Invalid Value")

            if choice < 0 or choice > len(options):
                msg_error("[ERROR] Invalid option")

            self.choice_option(choice)

    def choice_option(self, x):
        os.system("clear")
        options = OPTIONS

        try:
            func = FUNCTION[x]
        except KeyError as error:
            msg_error("[ERROR] Invalid option -", error)

        if x in FUNCTION:
            print("Selected Option - ", options[x-1])
            print(func(*self.value_number()))

    def value_number(self):
        try:
            a = float(input("Type first number: "))
            b = float(input("Type second number: "))
        except (ValueError, IndexError, KeyError) as error:
            msg_error("[ERROR]", error)

        return a, b


if __name__ == '__main__':
    calc = Calculator()
