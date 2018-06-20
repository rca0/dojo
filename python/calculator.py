#!/usr/bin/env python
#-*- coding: UTF-8 -*-

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

class Calculator(object):

    def __init__(self):
        self.run()

    def run(self):
        self.options()

    def options(self):

        while True:
            options = OPTIONS
            print "Calculator Cli"
            for i in range(len(options)):
                print i+1, "-", options[i]

            try:
                choice = int(raw_input("Choice any option: "))
            except ValueError as e:
                print 'ERROR Invalid Value - %s' % (e)

            if choice < 0 or choice > len(options):
                print "Invalid Option"
            else:
                self.choice_option(choice)

    def choice_option(self, x):
        options = OPTIONS
        func = FUNCTION[x]
        if FUNCTION.has_key(x):
            print "Selected Option - ", options[x-1]
            print func(*self.value_number())

    def value_number(self):
        try:
            a = float(raw_input("Type first number: "))
            b = float(raw_input("Type secunde number: "))
        except IndexError as e:
            print 'ERROR Invalid Value - %s' % (e)

        return a, b

def main():
    calc = Calculator()

if __name__ == '__main__':
    main()
