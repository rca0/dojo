from jsonschema import Draft4Validator, ValidationError, validate
from schema.password import SCHEMA


def validate_schema(data):
    validator = Draft4Validator(SCHEMA)
    try:
        validator.validate(data)
    except ValidationError as error:
        raise ValueError(error)

    return validator
