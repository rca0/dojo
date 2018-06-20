# passGenerator

This tool can help in create random passwords.

Made to run with command line or API.

## Parameters

Properties | Type    | Description
---        | ---     | ---
size       | integer | Number of characters in the password.
uppercase  | boolean | Enables/Disable uppercase when the password is created.
lowercase  | boolean | Enables/Disable lowercase when the password is created.
numbers    | boolean | Enables/Disable numbers when the password is created.
chars      | string  | Value 'all' or others characters (@;,#$).

Propertie `size` is required.

## Installation

Requirements:
- [x] Python programming Language, version 3.5.2
- [x] Tool curl

```bash
pyenv install 3.5.2
pyenv rehash
pyenv shell 3.5.2
pip install -r requirements.txt
```

## Executing
# Command line:

Show help:
```bash
python gen.py --help
```

Example:
```bash
python gen.py --size=20 --uppercase --chars @;
returns: ('CLI> ', {'password': 'YRPEBNGKFGHEOZVIV@YNXUGHKBNUDT'})

python gen.py --size=40 --lowercase --chars all --numbers
returns: ('CLI> ', {'password': '{{s*[`q_l+=a|^?)5*6%h{>y9,j=8o~_'>^])*\n'})

python gen.py -s 22 -u -l -c @
returns: ('CLI> ', {'password': 'PR@qYCOGJKHOqZuIwRNzMc'})
```

# API

API - Only method POST it's available

Run:
```bash
python run.py
```

Exemple with Curl:
```
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"size": 10, "uppercase": true, "number": true, "chars": "all"}' \
     http://127.0.0.1:8000/api/v1/passgen

curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"size": 20, "lowercase": true, "chars": "@$,;"}' \
     http://127.0.0.1:8000/api/v1/passgen
```

## Logs

- Configuration file `conf/config.ini`
