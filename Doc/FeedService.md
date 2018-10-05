# Feed Service
## Data Struct
| Feild | Type | Nullable |
|-------|------|----------|
|Id|string|N|key
|PeopleId|string|N|
|Title|string|N|
|Description|string|N|
|ModifyTime|DateTime|N|
|Attachement|byte[]|Y|

## `GET` `api/Feeds`
```
[
    {
        "id": "ed9b1a6b-9a26-4ac2-a4b1-c8e2e023b1c5",
        "peopleId": "abc",
        "title": "test",
        "description": "test feed api put endpoint 23",
        "modifyTime": "2018-10-02T15:00:06.4343237",
        "attachment": null
    },
    {
        "id": "fc6a81ee-426c-451b-a9bf-e024afa8619f",
        "peopleId": "abc",
        "title": "test",
        "description": "test feed api",
        "modifyTime": "0001-01-01T00:00:00",
        "attachment": null
    }
]
```

## `GET` `api/Feeds/{id}`
```
{
    "id": "eb8993df-eb05-4b41-9591-3f23b335c9e8",
    "peopleId": "abc",
    "title": "test",
    "description": "test feed api",
    "modifyTime": "2012-02-10T12:22:00",
    "attachment": null
}
```

## `PUT` `api/Feeds/{id}`

Request Body
```
{
    "Title": "test",
    "PeopleId": "abc",
    "Description": "Test feed put endpoint"
}
```

Response Body
```
{
    "id": "eb8993df-eb05-4b41-9591-3f23b335c9e8",
    "peopleId": "abc",
    "title": "test",
    "description": "Test feed put endpoint",
    "modifyTime": "2018-10-02T15:26:55.194196-05:00",
    "attachment": null
}
```

## `POST` `api/Feeds`

Request Body
```
{
    "Title": "test",
    "PeopleId": "abc",
    "Description": "test feed create"
}
```

Response Body
```
{
    "id": "18690af5-48de-493e-97d2-8a208e22e250",
    "peopleId": "abc",
    "title": "test",
    "description": "test feed create",
    "modifyTime": "2018-10-02T15:30:58.8420878-05:00",
    "attachment": null
}
```

## `DELETE` `api/Feeds/{id}`
```
{
    "id": "ed9b1a6b-9a26-4ac2-a4b1-c8e2e023b1c5",
    "peopleId": "abc",
    "title": "test",
    "description": "test feed api put endpoint 23",
    "modifyTime": "2018-10-02T15:00:06.4343237",
    "attachment": null
}
```




