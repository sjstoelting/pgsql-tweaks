# [PostgreSQL](https://www.postgresql.org) Views and Functions

The functions and views published in this repository are some of those, which I
regularly need in my daily job.

As these procedures are sort of essential, at least to me, I install them in the
public schema. That way they are available for everyone without having to know
a schema name.

All functions and views are covered by tests. The tests are done in simple SQL
statements. Each test does raise division by zero if it fails.

The tests have been done with PostgreSQL 9.6 and 10. There have been some
changes in the behaviour in PostgreSQL 10, Timestamp and Date functions and
conversions have become more strict.

All examples have been done with PostgreSQL 10, differences in the behaviour of
previous versions are noted.


# Building the extension

All functions and tests are located in single files.

The files for the extension are build by the shell script "create-sql.sh".
To be able to run the script, you need to have a configuration with the
connection information. Please copy "build.cfg.example" to "build.cfg" and
change the configuration to fit your environment.<br />
The script assumes, that you have a
[.pgpass](https://www.postgresql.org/docs/current/static/libpq-pgpass.html)
file with login information matching the configuration.


# Installation

You may either, install all functions as a package, or install single functions
of your choice.

## Install the package from source

Get the source by either, download the code as ZIP file, or by git clone.

```bash
cd pgsql_tweaks
make install
```
Afterwards you are able to create the extension in a database:

```sql
CREATE EXTENSION pgsql_tweaks;
```

## Install the package with PGXN

pgsql_tweaks is now available over the PostgreSQL extension management, [PGXN](https://pgxn.org/dist/pgsql_tweaks/).

The installation is done with the PGXN installer.

```bash
pgxn install pgsql_tweaks
```

Afterwards you are able to create the extension in a database:

# Table of content

1 [List of functions](#list-of-functions)

1.1 [Functions to check data types](#functions-to-check-data-types)<br />
1.1.1 [FUNCTION is_date](#function-is_date)<br />
1.1.2 [FUNCTION is_time](#function-is_time)<br />
1.1.3 [FUNCTION is_timestamp](#function-is_timestamp)<br />
1.1.4 [FUNCTION is_real](#function-is_real)<br />
1.1.5 [FUNCTION is_double_precision](#function-is_double_precision)<br />
1.1.6 [FUNCTION is_numeric](#function-is_numeric)<br />
1.1.7 [FUNCTION is_bigint](#function-is_bigint)<br />
1.1.8 [FUNCTION is_integer](#function-is_integer)<br />
1.1.9 [FUNCTION is_smallint](#function-is_smallint)<br />
1.1.10 [FUNCTION is_boolean](#function-is_boolean)<br />
1.1.11 [FUNCTION is_json](#function-is_json)<br />
1.1.12 [FUNCTION is_jsonb](#function-is_jsonb)<br />
1.1.13 [FUNCTION is_empty](#function-is_empty)

1.2 [Functions about encryption](#functions-about-encryption)<br />
1.2.1 [FUNCTION sha256](#function-sha256)

1.3 [Functions and views to get extended system information](#functions-and-views-to-get-extended-system-information)<br />
1.3.1 [FUNCTION pg_schema_size](#function-pg_schema_size)<br />
1.3.2 [VIEW pg_db_views](#view-pg_db_views)<br />
1.3.3 [VIEW pg_foreign_keys](#view-pg_foreign_keys)<br />
1.3.4 [VIEW pg_functions](#view-pg_functions)<br />
1.3.4 [VIEW pg_active_locks](#view-pg_active_locks)<br />
1.3.5 [VIEW pg_table_matview_infos](#view-pg_table_matview_infos)

1.4 [Functions about encodings](#functions-about-encodings)<br />
1.4.1 [FUNCTION is_encoding](#function-is_encoding)<br />
1.4.2 [FUNCTION is_latin1](#function-is_latin1)<br />
1.4.3 [FUNCTION return_not_part_of_latin1](#function-return_not_part_of_latin1)<br />
1.4.4 [FUNCTION replace_latin1](#function-replace_latin1)<br />
1.4.4.1 [replace_latin1\(s VARCHAR\)](#replace_latin1-s-varchar-)<br />
1.4.4.2 [replace_latin1\(s VARCHAR, replacement VARCHAR\)](#replace_latin1-s-varchar-replacement-varchar-)<br />
1.4.4.3 [replace_latin1\(s VARCHAR, s_search VARCHAR\[\], s_replace VARCHAR\[\]\)](#replace_latin1-s-varchar-s_search-varchar-s_replace-varchar-)<br />
1.4.5 [FUNCTION return_not_part_of_encoding](#function-return_not_part_of_encoding)<br />
1.4.6 [FUNCTION replace_encoding](#function-replace_encoding)<br />
1.4.6.1 [replace_encoding\(s VARCHAR, e VARCHAR\)](#replace_encoding-s-varchar-e-varchar-)<br />
1.4.6.2 [replace_encoding\(s VARCHAR, e VARCHAR, replacement VARCHAR\)](#replace_encoding-s-varchar-e-varchar-replacement-varchar-)<br />
1.4.6.3 [replace_encoding\(s VARCHAR, s_search VARCHAR\[\], s_replace VARCHAR\[\]\)](#replace_encoding-s-varchar-s_search-varchar-s_replace-varchar-)

1.5 [User defined aggregates](#user-defined-aggregates)<br />
1.5.1 [AGGREGATE gap_fill](#aggregate-gap_fill)<br />
1.5.2 [AGGREGATE array_min](#aggregate-array_min)<br />
1.5.3 [AGGREGATE array_max](#aggregate-array_max)<br />
1.5.4 [AGGREGATE array_avg](#aggregate-array_avg)<br />
1.5.5 [AGGREGATE array_sum](#aggregate-array_sum)

1.6 [Format functions](#format-functions)<br />
1.6.1 [FUNCTION date_de](#function-date_de)<br />
1.6.2 [FUNCTION datetime_de](#function-datetime_de)

1.7 [Conversion functions](#conversion-functions)<br />
1.7.1 [FUNCTION to_unix_timestamp](#function-to_unix_timestamp)

1.8 [Other functions](#other-functions)<br />
1.8.1 [FUNCTION array_trim](#function-array_trim)

# List of functions

## Functions to check data types

### FUNCTION is_date

The function checks strings for being a date.<br />
You might pass a second parameter to use a format string. Without the format,
the default format of PostgreSQL is used.

There has been a behaviour change in PostgreSQL 10. A conversion is now handled
strict, as in previous versions the conversion tried to calculate dates.

#### Example PostgreSQL < 10

```sql
SELECT is_date('31.02.2018', 'DD.MM.YYYY') AS res;
-- Result is true because the conversion would return a valid result for
SELECT to_date('31.02.2018', 'DD.MM.YYYY');
```

Result PostgreSQL 9.6 and previous versions:

| to_date    |
| ---------- |
| 2018-03-03 |

#### Examples

```sql
/**
 * Parameter is in PostgreSQL default format
 */
SELECT is_date('2018-01-01') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_date('2018-02-31') AS res;
```

Result:

| res |
|:---:|
| f   |

```sql
/**
 * Parameter is in PostgreSQL German format
 */
SELECT is_date('01.01.2018', 'DD.MM.YYYY') AS res;
```

Result:

| res |
|:---:|
| t   |


```sql
SELECT is_date('31.02.2018', 'DD.MM.YYYY') AS res;
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_time

The function checks strings for being a time.<br />
You might pass a second parameter to use a format string. Without the format,
the default format of PostgreSQL is used.

There has been a behaviour change in PostgreSQL 10. A conversion is now handled
strict, as in previous versions the conversion tried to calculate time.

#### Example PostgreSQL < 10

```sql
SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS res;
-- Result is true because the conversion would return a valid result for
SELECT to_timestamp('25.33.55,456574', 'HH24.MI.SS,US')::TIME;
```

Result PostgreSQL 9.6 and previous versions:

| to_timestamp    |
| --------------- |
| 01:33:55.456574 |

#### Examples

```sql
/**
 * Parameter is in PostgreSQL default format
 */
SELECT is_time('14:33:55.456574') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_time('25:33:55.456574') AS res;
```

Result:

| res |
|:---:|
| f   |

```sql
/**
 * Parameter is some time format
 */
SELECT is_time('14.33.55,456574', 'HH24.MI.SS,US') AS res;
```

Result:

| res |
|:---:|
| t   |


```sql
SELECT is_time('25.33.55,456574', 'HH24.MI.SS,US') AS res;
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_timestamp
The function checks strings for being a timestamp.<br />
You might pass a second parameter to use a format string. Without the format,
the default format of PostgreSQL is used.

There has been a behaviour change in PostgreSQL 10. A conversion is now handled
strict, as in previous versions the conversion tried to calculate a date.

#### Example PostgreSQL < 10

```sql
SELECT is_timestamp('2018-01-01 25:00:00') AS res;
-- Result is true because the conversion would return a valid result for
SELECT to_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS')::TIMESTAMP;
```

Result PostgreSQL 9.6 and previous versions:

| to_timestamp        |
| ------------------- |
| 2018-01-02 01:00:00 |

#### Examples

```sql
/**
 * Parameter is in PostgreSQL default format
 */
SELECT is_timestamp('2018-01-01 00:00:00') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_timestamp('2018-01-01 25:00:00') AS res;
-- Result is false in PostgreSQL >= 10
```

Result:

| res |
|:---:|
| f   |

```sql
/**
 * Parameter is in PostgreSQL German format
 */
SELECT is_timestamp('01.01.2018 00:00:00', 'DD.MM.YYYY HH24.MI.SS') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS') AS res;
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_real

The function checks strings for being of data type REAL.

#### Examples

```sql
SELECT is_real('123.456') AS res;
```
Result:

| res |
|:---:|
| t   |

```sql
SELECT is_real('123,456') AS res;
-- Result is false
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_double_precision

The function checks strings for being of data type DOUBLE PRECISION.

#### Examples

```sql
SELECT is_double_precision('123.456') AS res;
```
Result:

| res |
|:---:|
| t   |

```sql
SELECT is_double_precision('123,456') AS res;
-- Result is false
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_numeric

The function checks strings for being of data type NUMERIC.

#### Examples

```sql
SELECT is_numeric('123') AS res;
```
Result:

| res |
|:---:|
| t   |

```sql
SELECT is_numeric('1 2') AS res;
-- Result is false
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_bigint

The function checks strings for being of data type BIGINT.

#### Examples

```sql
SELECT is_bigint('3243546343') AS res;
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_bigint('123.456') AS res;
-- Result is false
```

### FUNCTION is_integer

The function checks strings for being of data type INTEGER.

#### Examples

```sql
SELECT is_integer('123') AS res;
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_integer('123.456') AS res;
-- Result is false
```

### FUNCTION is_smallint

The function checks strings for being of data type SMALLINT.

#### Examples

```sql
SELECT is_smallint('123') AS res;
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_smallint('123.456') AS res;
-- Result is false
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_boolean

The function checks a string variable for containing valid BOOLEAN values.

| boolean strings |
| --------------- |
| t |
| f |
| T |
| F |
| y |
| n |
| Y |
| N |
| true |
| false |
| TRUE |
| FALSE |
| yes |
| no |
| YES |
| NO |
| 0 |
| 1 |

#### Examples

```sql
SELECT is_boolean('t');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_boolean('F');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_boolean('True');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_boolean('False');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_boolean('0');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_boolean('1');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_boolean('-1');
-- Result is false
```

Result:

| res |
|:---:|
| f   |


### FUNCTION is_json

The function checks a string variable for containing a valid JSON.

#### Examples

```sql
SELECT is_json('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_json('Not a JSON') AS
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_jsonb

The function checks a string variable for containing a valid JSONB.

#### Example

```sql
SELECT is_jsonb('{"review": {"date": "1970-12-30", "votes": 10, "rating": 5, "helpful_votes": 0}, "product": {"id": "1551803542", "group": "Book", "title": "Start and Run a Coffee Bar (Start & Run a)", "category": "Business & Investing", "sales_rank": 11611, "similar_ids": ["0471136174", "0910627312", "047112138X", "0786883561", "0201570483"], "subcategory": "General"}, "customer_id": "AE22YDHSBFYIP"}') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_jsonb('Not a JSONB') AS
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_empty

The function checks a string variable for being either, NULL or ''.

#### Examples

```sql
SELECT is_empty('abc');
-- Result is false
```

Result:

| res |
|:---:|
| f   |

```sql
SELECT is_empty('');
-- Result is true
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_empty(NULL);
-- Result is true
```

Result:

| res |
|:---:|
| t   |


## Functions about encryption

### FUNCTION sha256

Creates a function which returns a SHA256 hash for the given string.<br />
The parameter has to be converted into a binary string of [bytea](https://www.postgresql.org/docs/current/static/datatype-binary.html).</br>
:heavy_exclamation_mark:<span style="color:red">The function needs the [pgcrypto](https://www.postgresql.org/docs/current/static/pgcrypto.html) package</span>:heavy_exclamation_mark:

:heavy_exclamation_mark:This function is not part of the package because of the external dependencies.:heavy_exclamation_mark:

#### Example

```sql
SELECT sha256('test-string'::bytea) AS res;
```

Result:

| res |
|:---:|
| ffe65f1d98fafedea3514adc956c8ada5980c6c5d2552fd61f48401aefd5c00e |


## Functions and views to get extended system information

### FUNCTION pg_schema_size

The function returns the size for schema given as parameter in bytes.

#### Examples

```sql
-- Returns the size of the schema public in bytes
SELECT pg_schema_size('public');
```

Result:

| pg_schema_size |
| --------------:|
|      348536832 |

```sql
-- Returns the size of the schema public formatted
SELECT pg_size_pretty(pg_schema_size('public'));
```

Result:

| pg_schema_size |
| --------------:|
|         332 MB |

### VIEW pg_db_views

Creates a view to get all views of the current database but excluding system views and all views which do start with "pg" or "\_pg".

```sql
SELECT * FROM pg_db_views;
```

| view_catalog | view_schema | view_name               |  view_definition |
| ------------ | ----------- | ----------------------- | ----------------------- |
| chinook      | public      | v_json_artist_data      | WITH tracks AS ( |
|              |             |                         |         SELECT "Track"."AlbumId" AS album_id, |
|              |             |                         |             "Track"."TrackId" AS track_id, |
|              |             |                         |             "Track"."Name" AS track_name, |
|              |             |                         |             "Track"."MediaTypeId" AS media_type_id, |
|              |             |                         |             "Track"."Milliseconds" AS milliseconds, |
|              |             |                         |             "Track"."UnitPrice" AS unit_price |
|              |             |                         |            FROM "Track" |
|              |             |                         |         ), json_tracks AS ( |
|              |             |                         |          SELECT row_to_json(tracks.*) AS tracks |
|              |             |                         |            FROM tracks |
|              |             |                         |         ), albums AS ( |
|              |             |                         |          SELECT a."ArtistId" AS artist_id, |
|              |             |                         |             a."AlbumId" AS album_id, |
|              |             |                         |             a."Title" AS album_title, |
|              |             |                         |             array_agg(t.tracks) AS album_tracks |
|              |             |                         |            FROM ("Album" a |
|              |             |                         |              JOIN json_tracks t ON ((a."AlbumId" = ((t.tracks ->> 'album_id'::text))::integer))) |
|              |             |                         |           GROUP BY a."ArtistId", a."AlbumId", a."Title" |
|              |             |                         |         ), json_albums AS ( |
|              |             |                         |          SELECT albums.artist_id, |
|              |             |                         |             array_agg(row_to_json(albums.*)) AS album |
|              |             |                         |            FROM albums |
|              |             |                         |           GROUP BY albums.artist_id |
|              |             |                         |         ), artists AS ( |
|              |             |                         |          SELECT a."ArtistId" AS artist_id, |
|              |             |                         |             a."Name" AS artist, |
|              |             |                         |             jsa.album AS albums |
|              |             |                         |            FROM ("Artist" a |
|              |             |                         |              JOIN json_albums jsa ON ((a."ArtistId" = jsa.artist_id))) |
|              |             |                         |         ) |
|              |             |                         |  SELECT (row_to_json(artists.*))::jsonb AS artist_data |
|              |             |                         |    FROM artists; |



### VIEW pg_foreign_keys

Creates a view to get all views of the current database but excluding system views and all views which do start with "pg" or "\_pg".

```sql
SELECT * FROM pg_foreign_keys;
```

| table_catalog | table_schema |  table_name   | column_name  | foreign_table_name | foreign_column_name |
| ------------- | ------------ | ------------- | ------------ | ------------------ | ------------------- |
|chinook        | public       | Album         | ArtistId     | Artist             | ArtistId            |
|chinook        | public       | Customer      | SupportRepId | Employee           | EmployeeId          |
|chinook        | public       | Employee      | ReportsTo    | Employee           | EmployeeId          |
|chinook        | public       | Invoice       | CustomerId   | Customer           | CustomerId          |
|chinook        | public       | InvoiceLine   | InvoiceId    | Invoice            | InvoiceId           |
|chinook        | public       | InvoiceLine   | TrackId      | Track              | TrackId             |
|chinook        | public       | PlaylistTrack | PlaylistId   | Playlist           | PlaylistId          |
|chinook        | public       | PlaylistTrack | TrackId      | Track              | TrackId             |
|chinook        | public       | Track         | AlbumId      | Album              | AlbumId             |
|chinook        | public       | Track         | GenreId      | Genre              | GenreId             |
|chinook        | public       | Track         | MediaTypeId  | MediaType          | MediaTypeId         |


### VIEW pg_functions

Creates a view to get all functions of the current database, excluding those in the schema pg_catalog and information_schema.

```sql
SELECT * FROM pg_functions;
```

| schema_name | function_name | returning_data_type | parameters                    | function_type | function_comment                                                      |
| ----------- | ------------- | ------------------- | ----------------------------- | ------------- | --------------------------------------------------------------------- |
| public      | date_de       | character varying   | d date                        | function      | Creates a function which returns the given date in German format      |
| public      | datetime_de   | character varying   | t timestamp without time zone | function      | Creates a function which returns the given timestamp in German format |


### VIEW pg_active_locks

Creates a view to view all live locks with all necessary information about the connections and the query.<br />
<span style="color:red">The view needs PostgreSQL 9.2 as minimum version. The column application_name was added in 9.2.</span>

```sql
SELECT * FROM pg_active_locks;
```

Result:

| pid  | state  | datname | usename  | application_name | client_addr |          query_start          | wait_event_type | wait_event |  locktype  |      mode       |             query              |
| ----:| ------ |-------- |--------- | ---------------- | ----------- | ----------------------------- | --------------- | ---------- | ---------- | --------------- | ------------------------------ |
| 8872 | active | chinook | stefanie | psql             | 127.0.0.1   | 2018-02-18 14:45:53.943047+01 |                 |            | relation   | AccessShareLock | SELECT * FROM pg_active_locks; |
| 8872 | active | chinook | stefanie | psql             | 127.0.0.1   | 2018-02-18 14:45:53.943047+01 |                 |            | virtualxid | ExclusiveLock   | SELECT * FROM pg_active_locks; |

### VIEW pg_table_matview_infos

Creates a view with information about the size of the table/materialized view and sizes of indexes on that table/materialized view.
It does also list all indexes on that table in an array.

```sql
SELECT * FROM pg_table_matview_infos;
```

Result:

| type | schemaname | tablename | tableowner | tablespace | indexes | table_size | indexes_size | total_relation_size | table_size_pretty | indexes_size_pretty | total_relation_size_pretty |
| ---- | ---------- | --------- | ---------- | ---------- | ------- | ----------:| ------------:| -------------------:| -----------------:| -------------------:| --------------------------:|
| table | public | MediaType | stefanie | [NULL] | {PK_MediaType} | 8192 | 16384 | 24576 | 8192 bytes | 16 kB | 24 kB |
| table | public | Playlist | stefanie | [NULL] | {PK_Playlist} | 8192 | 16384 | 24576 | 8192 bytes | 16 kB | 24 kB |

## Functions about encodings

### FUNCTION is_encoding

The function checks if all characters are in included in a given encoding.
That is especially useful, if you have to deal with exports into other
encodings than the database encoding.

The function with two parameters uses UTF-8 as source encoding,<br />
The one with three parameters uses the third parameter as source encoding.

#### Examples

```sql
SELECT is_encoding('Some characters', 'LATIN1') AS res;
```

Result:

| res |
|:---:|
| f   |

```sql
SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1') AS res;
-- Returns false: The Turkish character ğ is not part of latin1
```

Result:

| res |
|:---:|
| f   |

```sql
SELECT is_encoding('Some characters', 'LATIN1', 'UTF8') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'UTF8', 'LATIN1') AS res;
-- Returns false: The Turkish character ğ is not part of latin1
```

Result:

| res |
|:---:|
| f   |

### FUNCTION is_latin1

The function is a shortcut for is_encoding('Some characters', 'LATIN1'), you
don't have to give the target encoding.

#### Examples

```sql
SELECT is_latin1('Some characters') AS res;
```

Result:

| res |
|:---:|
| t   |

```sql
SELECT is_latin1('Some characters, ğ is Turkish and not latin1') AS res;
-- Returns false: The Turkish character ğ is not part of latin1
```

Result:

| res |
|:---:|
| f   |


### FUNCTION return_not_part_of_latin1

The function returns a distinct array containing all characters, which are not defined in latin1.<br />
The function <span style="color:red">depends on is_latin1</span> which is part of this repository.

#### Example

```sql
-- Returns an array containing the characters ğ and Ƶ each one time
SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res;
```

Result:

| res   |
| ----- |
| {ğ,Ƶ} |

### FUNCTION replace_latin1

The function has three implementations. All implementations <span style="color:red">depend on the function is_latin1</span>, the function is included in this repository.

#### replace_latin1(s VARCHAR)

The function takes one parameter with characters to be checked and replaced with
an empty string, if they are not part of latin1.

##### Example

```sql
SELECT replace_latin1('Some characters, ğ is Turkish and not latin1') AS res;
```

Result:

| res                                         |
| ------------------------------------------- |
| Some characters,  is Turkish and not latin1 |

#### replace_latin1(s VARCHAR, replacement VARCHAR)
The function takes a second parameter which is used to replace _all_ characters,
which are not part of latin1.

##### Example

```sql
SELECT replace_latin1(
  'Some characters, ğ is Turkish and not latin1 and replaced with a g',
  'g'
) AS res;
```

Result:

| res                                                                |
| ------------------------------------------------------------------ |
| Some characters, g is Turkish and not latin1 and replaced with a g |

#### replace_latin1(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[])

The function takes as first parameter a string which may or may not have none
latin1 characters. The second parameter is an arrays containing all characters,
that should be replaced. The third parameter is an array, too. The characters
defined in s_search are replaced with the characters in s_replace, it takes the
position in the array to identify which character should be replaced by which
one.

##### Example

```sql
-- First identify the characters which should be replaced, which are {ğ,Ƶ}
SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res;

-- The ğ will be replaced whit a g and the Ƶ with a Z}
SELECT 'ağbƵcğeƵ' AS original
  , replace_latin1(
      'ağbƵcğeƵ',
      string_to_array('ğ,Ƶ', ','),
      string_to_array('g,Z', ',')
    ) AS res;
```
Result:

| original | res      |
| -------- | -------- |
| ağbƵcğeƵ | agbZcgeZ |

### FUNCTION return_not_part_of_encoding

The function returns a distinct array containing all characters, which are not defined in the second parameter as encoding.<br />
The function <span style="color:red">depends on is_encoding</span> which is part of this repository.

#### Example

```sql
-- Returns an array containing the characters ğ and Ƶ each one time
SELECT return_not_part_of_encoding('ağbƵcğeƵ', 'latin1') AS res;
```

Result:

| res   |
| ----- |
| {ğ,Ƶ} |


### FUNCTION replace_encoding

The function has three implementations. All implementations <span style="color:red">depend on the function is_encoding</span>, the function is included in this repository.

#### replace_encoding(s VARCHAR, e VARCHAR)

The function takes one parameter with characters to be checked and replaced with
an empty string, if they are not part of the encoding given in the second
parameter.

##### Example

```sql
SELECT replace_encoding(
  'Some characters, ğ is Turkish and not latin1',
  'latin1'
) AS res;
```

Result:

| res                                         |
| ------------------------------------------- |
| Some characters,  is Turkish and not latin1 |

#### replace_encoding(s VARCHAR, e VARCHAR, replacement VARCHAR)
The function takes a third parameter which is used to replace _all_ characters
which are not part of the encoding given in parameter 2.

##### Example

```sql
SELECT replace_encoding(
  'Some characters, ğ is Turkish and not latin1 and replaced with a g',
  'latin1',
  'g'
) AS res;
```

Result:

| res                                                                |
| ------------------------------------------------------------------ |
| Some characters, g is Turkish and not latin1 and replaced with a g |

#### replace_encoding(s VARCHAR, s_search VARCHAR[], s_replace VARCHAR[])

The function takes as first parameter a string which may or may not have none
latin1 characters. The second parameter is an arrays containing all characters,
that should be replaced. The third parameter is an array, too. The characters
defined in s_search are replaced with the characters in s_replace, it takes the
position in the array to identify which character should be replaced by which
one.

##### Example

```sql
-- First identify the characters which should be replaced, which are {ğ,Ƶ}
SELECT return_not_part_of_latin1('ağbƵcğeƵ') AS res;

-- The ğ will be replaced whit a g and the Ƶ with a Z}
SELECT 'ağbƵcğeƵ' AS original
  , replace_encoding(
      'ağbƵcğeƵ',
      string_to_array('ğ,Ƶ', ','),
      string_to_array('g,Z', ',')
  ) AS res;
```
Result:

| original | res      |
| -------- | -------- |
| ağbƵcğeƵ | agbZcgeZ |


## User defined aggregates

### AGGREGATE gap_fill

The aggregate is used in [Window Functions](https://www.postgresql.org/docs/current/static/tutorial-window.html)
to show the last value in case the current value is null.

#### Example
```sql
BEGIN;

CREATE TABLE test_gap_fill(id INTEGER, some_value VARCHAR);

INSERT INTO test_gap_fill(id, some_value) VALUES
  (1, 'value 1'),
  (1, NULL),
  (2, 'value 2'),
  (2, NULL),
  (2, NULL),
  (3, 'value 3')
;

SELECT id
  , some_value
FROM test_gap_fill
;

ROLLBACK;
```

Result:

| id | some_value |
| --:| ---------- |
|  1 | value 1    |
|  1 |            |
|  2 | value 2    |
|  2 |            |
|  2 |            |
|  3 | value 3    |


```sql
BEGIN;

CREATE TABLE test_gap_fill(id INTEGER, some_value VARCHAR);

INSERT INTO test_gap_fill(id, some_value) VALUES
  (1, 'value 1'),
  (1, NULL),
  (2, 'value 2'),
  (2, NULL),
  (2, NULL),
  (3, 'value 3')
;

-- Fill the empty rows with values
SELECT id
  , gap_fill(some_value) OVER (ORDER BY id) AS some_value
FROM test_gap_fill
;

ROLLBACK;
```

Result:

| id | some_value |
| --:| ---------- |
|  1 | value 1    |
|  1 | value 1    |
|  2 | value 2    |
|  2 | value 2    |
|  2 | value 2    |
|  3 | value 3    |


### AGGREGATE array_min

Calculate minimum values from arrays.

Supported data types are SMALLINT, INTEGER, BIGINT, REAL, DOUBLE PRECISION, NUMERIC, and TEXT;

#### Examples
```sql
SELECT array_min(ARRAY[45, 60, 43, 99]::SMALLINT[]);
```
Result:

| array_min |
| ---------:|
|        43 |

```sql
SELECT array_min(ARRAY[45, 60, 43, 99]::INTEGER[]);
```
Result:

| array_min |
| ---------:|
|        43 |

```sql
SELECT array_min(ARRAY[45, 60, 43, 99]::BIGINT[]);
```
Result:

| array_min |
| ---------:|
|        43 |

```sql
SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::REAL[]);
```
Result:

| array_min |
| ---------:|
|      43.7 |

```sql
SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::DOUBLE PRECISION[]);
```
Result:

| array_min |
| ---------:|
|      43.7 |

```sql
SELECT array_min(ARRAY[45.6, 60.8, 43.7, 99.3]::NUMERIC[]);
```
Result:

| array_min |
| ---------:|
|      43.7 |

```sql
SELECT array_min(ARRAY['def', 'abc', 'ghi']::TEXT[]);
```
Result:

| array_min |
| --------- |
| abc       |


### AGGREGATE array_max

Calculate minimum values from arrays.

Supported data types are SMALLINT, INTEGER, BIGINT, REAL, DOUBLE PRECISION, NUMERIC, and TEXT;

#### Examples
```sql
SELECT array_max(ARRAY[45, 60, 43, 99]::SMALLINT[]);
```
Result:

| array_max |
| ---------:|
|        99 |

```sql
SELECT array_max(ARRAY[45, 60, 43, 99]::INTEGER[]);
```
Result:

| array_max |
| ---------:|
|        99 |

```sql
SELECT array_max(ARRAY[45, 60, 43, 99]::BIGINT[]);
```
Result:

| array_max |
| ---------:|
|        99 |

```sql
SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]);
```
Result:

| array_max |
| ---------:|
|      99.3 |

```sql
SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]);
```
Result:

| array_max |
| ---------:|
|      99.3 |

```sql
SELECT array_max(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]);
```
Result:

| array_max |
| ---------:|
|      99.3 |

```sql
SELECT array_max(ARRAY['def', 'abc', 'ghi']::TEXT[]);
```
Result:

| array_max |
| --------- |
| ghi       |


### AGGREGATE array_avg

Calculate average values from arrays.

Supported data types are SMALLINT, INTEGER, BIGINT, REAL, DOUBLE PRECISION, and NUMERIC;

#### Examples
```sql
SELECT array_avg(ARRAY[45, 60, 43, 99]::SMALLINT[]);
```
Result:

| array_avg |
| ---------:|
|        62 |

```sql
SELECT array_avg(ARRAY[45, 60, 43, 99]::INTEGER[]);
```
Result:

| array_avg |
| ---------:|
|        62 |

```sql
SELECT array_avg(ARRAY[45, 60, 43, 99]::BIGINT[]);
```
Result:

| array_avg |
| ---------:|
|        62 |

```sql
SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::REAL[]);
```
Result:

| array_avg        |
| ----------------:|
| 62.1750001907349 |

```sql
SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::DOUBLE PRECISION[]);
```
Result:

| array_avg |
| ---------:|
|    62.175 |

```sql
SELECT array_avg(ARRAY[45.6, 60.8, 43, 99.3]::NUMERIC[]);
```
Result:

| array_avg           |
| -------------------:|
| 62.1750000000000000 |


### AGGREGATE array_sum

Calculate sum of values from arrays.

Supported data types are SMALLINT, INTEGER, BIGINT, REAL, DOUBLE PRECISION, and, NUMERIC;

#### Examples
```sql
SELECT array_sum(ARRAY[45, 60, 43, 99]::SMALLINT[]);
```
Result:

| array_sum |
| ---------:|
|       247 |

```sql
SELECT array_sum(ARRAY[45, 60, 43, 99]::INTEGER[]);
```
Result:

| array_sum |
| ---------:|
|       247 |

```sql
SELECT array_sum(ARRAY[45, 60, 43, 99]::BIGINT[]);
```
Result:

| array_sum |
| ---------:|
|       247 |

```sql
SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::REAL[]);
```
Result:

| array_sum |
| ---------:|
|     249.4 |

```sql
SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::DOUBLE PRECISION[]);
```
Result:

| array_sum |
| ---------:|
|     249.4 |

```sql
SELECT array_sum(ARRAY[45.6, 60.8, 43.7, 99.3]::NUMERIC[]);
```
Result:

| array_sum |
| ---------:|
|     249.4 |


## Format functions

Several countries use different formats for numbers, dates, and timestamps.
Therefore I needed some functions, which is easy to remember than the format
codes which differ in different programming languages.

### German formats

#### FUNCTION date_de

Creates a function which returns the given date in German format.

##### Example

```sql
SELECT date_de('2018-01-01') AS d_de;
```

Result:

| d_de       |
|:----------:|
| 01.01.2018 |

#### FUNCTION datetime_de

Creates a function which returns the given timestamp in German format.

##### Example

```sql
SELECT datetime_de('2018-01-01 13:30:30 GMT') AS ts_de;
```

Result:

| ts_de               |
|:-------------------:|
| 01.01.2018 14:30:30 |

## Conversion functions

### FUNCTION to_unix_timestamp

Creates two functions which returns unix timestamp for the a given timestamp or
a given timestamp with time zone.

#### Examples

```sql
-- Timestamp without time zone, server uses German / Berlin time zone
SELECT to_unix_timestamp('2018-01-01 00:00:00') AS unix_timestamp;
```

Result:

| unix_timestamp |
| --------------:|
|     1514761200 |

```sql
-- Timestamp with time zone
SELECT to_unix_timestamp('2018-01-01 00:00:00+01') AS unix_timestamp;
```

Result:

| unix_timestamp |
| --------------:|
|     1514761200 |

## Other functions

### FUNCTION array_trim

Removes empty strings and null entries from a given array. In addition the
function can remove duplicate entries. The function supports strings, numbers,
dates, and timestamps with or without time zone.

#### Examples

```sql
-- Untrimmed timestamp array with time zone with duplicates
SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[]) AS trimmed_array;
```

Result:

| untrimmed_array                                        |
| ------------------------------------------------------ |
| {'2018-11-11 11:00:00.000',,'2018-11-11 11:00:00.000'} |

```sql
-- Timestamp array with time zone with duplicates
SELECT ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[] AS untrimmed_array;
```

Result:

| trimmed_array                                         |
| ----------------------------------------------------- |
| {'2018-11-11 11:00:00.000','2018-11-11 11:00:00.000'} |

```sql
-- Timestamp array with time zone without duplicates
SELECT array_trim(ARRAY['2018-11-11 11:00:00 MEZ',NULL,'2018-11-11 11:00:00 MEZ']::TIMESTAMP WITH TIME ZONE[], TRUE) AS trimmed_array_distinct;
```

Result:

| trimmed_array_distinct      |
| --------------------------- |
| {'2018-11-11 11:00:00.000'} |
