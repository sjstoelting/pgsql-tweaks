# [PostgreSQL](https://www.postgresql.org) Views and functions

The functions and views published in this repository are some of those, which I
regularly need in my daily job.

As these procedures are sort of essential, at least to me, I install them in the
public schema. That way they are available for everyone without having to know
a schema name.

All functions and views are covered by tests. The tests are done in simple SQL
statements. Each test does raise division by zero if it fails.

# List of functions

## Functions to check data types

### FUNCTION is_date

The function checks strings for being a date.<br />
You might pass a second parameter to use a format string. Without the format,
the default format of PostgreSQL is used.

#### Examples

```sql
/**
 * Parameter is in PostgreSQL default format
 */
SELECT is_date('2018-01-01');
-- Result is true
SELECT is_date('2018-02-31');
-- Result is false

/**
 * Parameter is in PostgreSQL German format
 */
SELECT is_date('01.01.2018', 'DD.MM.YYYY');
-- Result is true
SELECT is_date('31.02.2018', 'DD.MM.YYYY');
-- Result is false  
```

### FUNCTION is_timestamp
The function checks strings for being a timestamp.<br />
You might pass a second parameter to use a format string. Without the format,
the default format of PostgreSQL is used.

#### Examples

```sql
/**
 * Parameter is in PostgreSQL default format
 */
SELECT is_timestamp('2018-01-01 00:00:00');
-- Result is true
SELECT is_timestamp('2018-01-01 25:00:00');
-- Result is false

/**
 * Parameter is in PostgreSQL German format
 */
SELECT is_timestamp('01.01.2018 00:00:00', 'DD.MM.YYYY HH24.MI.SS');
-- Result is true
SELECT is_timestamp('01.01.2018 25:00:00', 'DD.MM.YYYY HH24.MI.SS');
-- Result is false  
```

### FUNCTION is_numeric

The function checks strings for being numeric.

#### Examples

```sql
SELECT is_numeric('123');
-- Result is true

SELECT is_numeric('1 2');
-- Result is false
```

### FUNCTION is_integer

The function checks strings for being an integer.

#### Examples

```sql
SELECT is_integer('123');
-- Result is true

SELECT is_integer('123.456');
-- Result is false
```


## Functions about encryption

### FUNCTION sha256

Creates a function which returns a SHA256 hash for the given string.<br />
The parameter has to be converted into a binary string of [bytea](https://www.postgresql.org/docs/current/static/datatype-binary.html).</br>
:heavy_exclamation_mark:<span style="color:red">The function needs the [pgcrypto](https://www.postgresql.org/docs/current/static/pgcrypto.html) package</span>:heavy_exclamation_mark:

#### Example

```sql
SELECT sha256('test-string'::bytea);
-- Returns ffe65f1d98fafedea3514adc956c8ada5980c6c5d2552fd61f48401aefd5c00e
```


## Functions and views to get extended system information

### FUNCTION pg_schema_size

The function returns the size for schema given as parameter in bytes.

#### Examples

```sql
-- Returns the size of the schema public in bytes
SELECT pg_schema_size('public');
/*
pg_schema_size
----------------
      348536832
*/

-- Returns the size of the schema public formatted
SELECT pg_size_pretty(pg_schema_size('public'));
/*
pg_schema_size
----------------
      348536832
*/
```


## Functions about encodings

### FUNCTION is_encoding

The function checks if all characters are in included in a given encoding.
That is especially useful, if you have to deal with exports into other
encodings than the database encoding.

The function with two parameters uses UTF-8 as source encoding,<br />
The one with three parameters uses the third parameter as source encoding.

#### Examples

```sql
SELECT is_encoding('Some characters', 'LATIN1');
-- Returns true

SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'LATIN1');
-- Returns false: The Turkish character ğ is not part of latin1

SELECT is_encoding('Some characters', 'LATIN1', 'UTF8');
-- Returns true

SELECT is_encoding('Some characters, ğ is Turkish and not latin1', 'UTF8', 'LATIN1');
-- Returns false: The Turkish character ğ is not part of latin1
```

###FUNCTION is_latin1

The function is a shortcut for is_encoding('Some characters', 'LATIN1'), you
don't have to give the target encoding.

#### Examples

```sql
SELECT is_latin1('Some characters');
-- Returns true

SELECT is_latin1('Some characters, ğ is Turkish and not latin1');
-- Returns false: The Turkish character ğ is not part of latin1
```
