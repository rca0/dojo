SCHEMA = {
    "title": "v1/genpass SCHEMA",
    "type": "object",
    "properties": {
        "uppercase": {
            "type": { "boolean" },
        },
        "lowercase": {
            "type": { "boolean" },
        },
        "numbers": {
            "type": { "boolean" },
        },
        "size": {
            "type": { "number" },
        },
        "chars": {
            "type": { "string" },
        },
    },
    "required": ["size"]
}
