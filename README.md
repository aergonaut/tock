# Tock

![Tock](https://s3.amazonaws.com/that-old-black-magic/tollbooth.jpg)

Tock helps you keep count of things.

Tock can count just about anything. Just tell him what number to start at, and he'll happily count up for you for as long as you want.

## Usage

### Show the current number

```
GET /current
Accept: application/json
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "current": "42",
  "note": "yolo"
}
```

### Increment the current number

```
POST /increment
Accept: application/json
Authorization: Token token="..."

{
  "note": "Adding new permission for invoicing"
}
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "current": 43,
  "note": "Adding new permission for invoicing"
}
```

## License

MIT
