# User Service
## Data Struct
| Feild | Type | Nullable |
|-------|------|----------|
|Id|string|N|key
|Email|string|N|
|Password|string|N|
|FirstName|string|N|
|LastName|string|N|
|Standing|Enum|N|
|Role|Enum|N|
|Majors|List\<Major>|N|
|Description|string|Y|
|Location|string|Y|
|Image|byte[]|Y|
|Resume|byte[]|Y|

## Signup `Post` `api/Account`
Request Body
```
{
	"Email": "test@researchtree.com",
	"Password": "Cs@4970",
	"FirstName": "firstname",
	"LastName": "lastname",
	"Majors": [0, 1],
	"Role": 0,
	"Location": 65201
}
```

Response Body
```
{
    "id": "b8291613-a98a-4cd1-b10e-8e97f371f5b5",
    "email": "test@researchtree.com",
    "password": null,
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6WyJiODI5MTYxMy1hOThhLTRjZDEtYjEwZS04ZTk3ZjM3MWY1YjUiLCJmaXJzdG5hbWVsYXN0bmFtZSJdLCJlbWFpbCI6InRlc3RAcmVzZWFyY2h0cmVlLmNvIiwiZ2l2ZW5fbmFtZSI6ImZpcnN0bmFtZSIsIm5iZiI6MTU0MTgwMzg2NCwiZXhwIjoxNTQyNDA4NjY0LCJpYXQiOjE1NDE4MDM4NjR9.cgtqYH1lSodwpitoe1XKcvBzO8PIz5orIYZ6SL5BgE4",
    "firstName": "firstname",
    "lastname": "lastname",
    "majors": [
        0,
        1
    ],
    "image": null,
    "role": 0,
    "standing": 0,
    "location": "65201",
    "description": null,
    "resume": null
}
```

## Login `Post` `api/Account`
Request Body
```
{
	"Email": "test@researchtree.co",
	"Password": "Cs@4970"
}
```

Response Body
```
{
    "id": "b8291613-a98a-4cd1-b10e-8e97f371f5b5",
    "email": "test@researchtree.com",
    "password": null,
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6WyJiODI5MTYxMy1hOThhLTRjZDEtYjEwZS04ZTk3ZjM3MWY1YjUiLCJmaXJzdG5hbWVsYXN0bmFtZSJdLCJlbWFpbCI6InRlc3RAcmVzZWFyY2h0cmVlLmNvIiwiZ2l2ZW5fbmFtZSI6ImZpcnN0bmFtZSIsIm5iZiI6MTU0MTgwMzg2NCwiZXhwIjoxNTQyNDA4NjY0LCJpYXQiOjE1NDE4MDM4NjR9.cgtqYH1lSodwpitoe1XKcvBzO8PIz5orIYZ6SL5BgE4",
    "firstName": "firstname",
    "lastname": "lastname",
    "majors": [
        0,
        1
    ],
    "image": null,
    "role": 0,
    "standing": 0,
    "location": "65201",
    "description": null,
    "resume": null
}
```

## `GET` `api/Users`
```
[
    {
        "id": "e303ef69-d904-4295-9d7a-f524e765c5b2",
        "email": "asdf1",
        "password": null,
        "token": null,
        "firstName": "test",
        "lastname": "Smith",
        "majors": [
            0,
            1
        ],
        "image": null,
        "role": 0,
        "standing": 0,
        "location": "65201",
        "description": null,
        "resume": null
    },
    {
        "id": "f3d67e94-fbdb-457e-a3c2-738a16668ddf",
        "email": "test@researchtree.com",
        "password": null,
        "token": null,
        "firstName": "firstname",
        "lastname": "lastname",
        "majors": [
            0,
            1
        ],
        "image": null,
        "role": 0,
        "standing": 0,
        "location": "65201",
        "description": null,
        "resume": null
    }
]
```

## `GET` `api/Users/{id}`
```
{
    "id": "f3d67e94-fbdb-457e-a3c2-738a16668ddf",
    "email": "test@researchtree.com",
    "password": null,
    "token": null,
    "firstName": "firstname",
    "lastname": "lastname",
    "majors": [
        0,
        1
    ],
    "image": null,
    "role": 0,
    "standing": 0,
    "location": "65201",
    "description": null,
    "resume": null
}
```