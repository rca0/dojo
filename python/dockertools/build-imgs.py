# -*- coding: utf-8 -*-
import shutil
import sys
from os import path
from subprocess import Popen, call


def main(argv):
    i = 1
    if i < len(sys.argv):
        if sys.argv[i] == 'build':
            docker_build(sys.argv[2], sys.argv[3])
        if sys.argv[i] == 'publish':
            docker_publish(sys.argv[2:])
    else:
        print('Build Docker images:')
        print('build <name:version> <path_dockerfile>\n')
        print('Maps local path with container and execute the service:')
        print('publish <name> <port> <src_file> <dst_file> <image> <cmd>')


def docker_build(name, path):
    if not ':' in name:
         name = name + ":latest"

    tmp_dir = make_tmp_dir(name)
    copy_dir(path, tmp_dir)
    Popen([
        'docker',
        'build',
        '-t',
        name,
        tmp_dir
    ])


def docker_publish(*args):
    for arg in args:
        name = arg[0]
        port = arg[1]
        src_file = arg[2]
        dst_file = arg[3]
        image = arg[4]
        cmd = ' '.join(arg[5:])
    map_file = src_file + ':' + dst_file

    call(
        'docker run -dit --name %s -p %s -v %s %s %s' % (name, port, map_file, image, cmd), shell=True
    )


def make_tmp_dir(name=''):
    tmp_dir = '/tmp/{0}'.format(name)
    Popen(['rm', '-rf', tmp_dir])
    if not path.exists(tmp_dir):
        Popen(['mkdir', '-p', tmp_dir])

    return tmp_dir


def copy_dir(src_path, dest_path):
    shutil.copytree(src_path, dest_path)


if __name__ == '__main__':
    main(sys.argv[1:])
