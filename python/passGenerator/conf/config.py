from os import path
from configparser import SafeConfigParser


def get_config(config_path='conf/config.ini'):
    if not path.isfile(config_path):
        return {
            'PATH': 'no_dir'
        }

    config = SafeConfigParser()
    config.read(config_path)

    dir_gen = config.get('passgenerator', 'PATH')
    return {
        'PATH': dir_gen
    }

CONFIG = get_config()
DIR_GEN = CONFIG['PATH']
