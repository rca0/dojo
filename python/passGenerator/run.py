import logging
import sys
from os import path

from api.app import app
from conf.config import DIR_GEN

sys.path.insert(0, path.abspath(
    path.dirname(path.dirname(__file__)),
))


def main():
    arch = path.join(DIR_GEN, 'message.log')
    logging.basicConfig(filename=arch, level=logging.INFO)
    logging.info("Started")
    app.run(debug=True, port=8000)
    logging.info("Finished")


if __name__ == '__main__':
    main()
