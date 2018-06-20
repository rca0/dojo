import argparse
import random
import string
from sys import argv

from validator import validate_schema


class Gen(object):
    def __init__(self, *args, **kwargs):
        self.parser = None
        self.numbers = False
        self.lowercase = False
        self.uppercase = False
        self.chars = ''
        self._create_parser()

    def _create_parser(self):
        self.parser = argparse  .ArgumentParser(
            description='Password Generator',
        )
        self.parser.add_argument(
            '-s', '--size',
            help='Number of characters in the password',
            dest='size',
        )
        self.parser.add_argument(
            '-n', '--numbers',
            help='Enables/Disable numbers when the password is created',
            action='store_true',
            default=False,
            dest="numbers",
        )
        self.parser.add_argument(
            '-u', '--uppercase',
            help='Enables/Disable uppercase when the password is created',
            action='store_true',
            default=False,
            dest="uppercase",
        )
        self.parser.add_argument(
            '-l', '--lowercase',
            help='Enables/Disable lowercase when the password is created',
            action='store_true',
            default=False,
            dest="lowercase",
        )
        self.parser.add_argument(
            '-c', '--chars',
            help='Value of characters in the password, accept all or others characters',
            dest="chars",
        )

    def make_passwd(self, payload):
        chars = []
        gen = payload
        validate_schema(gen)

        if 'numbers' in gen and gen['numbers']:
            chars.append(string.digits)
        if 'uppercase' in gen and gen['uppercase']:
            chars.append(string.ascii_uppercase)
        if 'lowercase' in gen and gen['lowercase']:
            chars.append(string.ascii_lowercase)
        if 'all' in gen['chars']:
            chars.append(string.punctuation)
        else:
            chars.append(gen['chars'])

        password = ''.join(
            random.choice(''.join(chars)) for i in range(int(gen['size']))
        )
        return {'password': password}

    def make_msg(self, args):
        if args.size is None:
            self.size = input("Enter size: ")
        else:
            self.size = args.size

        if args.numbers:
            self.numbers = args.numbers
        if args.lowercase:
            self.lowercase = args.lowercase
        if args.uppercase:
            self.uppercase = args.uppercase
        if args.chars:
            self.chars = args.chars
        else:
            self.chars = ''

        args = {
            'size': int(self.size),
            'numbers': self.numbers,
            'uppercase': self.uppercase,
            'lowercase': self.lowercase,
            'chars': self.chars,
        }

        return args

    def cli(self, *args, **kwargs):
        args = self.parser.parse_args()
        data = self.make_msg(args)

        try:
            password = self.make_passwd(data)
            print('CLI> ', password)
        except Exception as e:
            print(str(e))


def main():
    if 1 < len(argv):
        gen = Gen()
        return gen.cli(argv[1:])
    else:
        exit(2)


if __name__ == '__main__':
    main()
