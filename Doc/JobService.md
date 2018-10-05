# Job Service
## Data Struct
| Feild | Type | Nullable |
|-------|------|----------|
|Id|string|N|key
|PeopleId|string|N|
|Title|string|N|
|Description|string|N|
|Standing|Enum|N|
|Payment|bool|N|
|Majors|List\<Major>|N|
|ModifyTime|DateTime|N|
|Attachement|byte[]|Y|

## `GET` `api/Jobs`
```
[
    {
        "id": "7d92a8ec-7681-44a8-a8dd-c183c897e0d0",
        "peopleId": "abc",
        "title": "test",
        "description": "test job update",
        "standing": 0,
        "payment": false,
        "majors": [
            1
        ],
        "modifyTime": "0001-01-01T00:00:00",
        "location": "65201"
    },
    {
        "id": "eb18032c-d150-4c58-a651-474c3d24a0ed",
        "peopleId": "abc",
        "title": "test",
        "description": "test job update",
        "standing": 0,
        "payment": false,
        "majors": [
            1
        ],
        "modifyTime": "2018-10-03T15:13:16.9656733",
        "location": "65201"
    }
]
```

## `GET` `api/Jobs/{id}`
```
{
    "id": "eb18032c-d150-4c58-a651-474c3d24a0ed",
    "peopleId": "abc",
    "title": "test",
    "description": "test job update",
    "standing": 0,
    "payment": false,
    "majors": [
        1
    ],
    "modifyTime": "2018-10-03T15:13:16.9656733",
    "location": "65201"
}
```

## `PUT` `api/Jobs/{id}`

Request Body
```
{
	"Title": "test",
	"PeopleId": "abc",
	"Description": "test job update",
	"Majors":  ["ComputerScience"],
	"Location": 65201
}
```

Response Body
```
{
    "id": "b86eae1e-e050-4c38-b32d-d971e1c69c65",
    "peopleId": "abc",
    "title": "test",
    "description": "test job update",
    "standing": 0,
    "payment": false,
    "majors": [
        1
    ],
    "modifyTime": "2018-10-03T15:30:48.6271134-05:00",
    "location": "65201"
}
```

## `POST` `api/Jobs`

Request Body
```
{
	"Title": "test",
	"PeopleId": "abc",
	"Description": "test job create",
	"Majors":  ["ComputerScience"],
	"Location": 65201
}
```

Response Body
```
{
    "id": "b86eae1e-e050-4c38-b32d-d971e1c69c65",
    "peopleId": "abc",
    "title": "test",
    "description": "test job create",
    "standing": 0,
    "payment": false,
    "majors": [
        1
    ],
    "modifyTime": "2018-10-03T15:29:58.654115-05:00",
    "location": "65201"
}
```

## `DELETE` `api/Jobs/{id}`
```
{
    "id": "eb18032c-d150-4c58-a651-474c3d24a0ed",
    "peopleId": "abc",
    "title": "test",
    "description": "test job update",
    "standing": 0,
    "payment": false,
    "majors": [
        1
    ],
    "modifyTime": "2018-10-03T15:25:27.5427146",
    "location": "65201"
}
```




