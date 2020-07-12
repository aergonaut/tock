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
  "note_log": ["yolo", "i did this!"]
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

The MIT License (MIT)

Copyright (c) 2014 Chris Fung

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

