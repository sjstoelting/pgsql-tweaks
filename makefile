#EXTENSION    = pgsql_tweaks
EXTENSION    = $(shell grep -m 1 '"name":' META.json | \
               sed -e 's/[[:space:]]*"name":[[:space:]]*"\([^"]*\)",/\1/')
EXTVERSION   = $(shell grep -m 1 '"version":' META.json | \
               sed -e 's/[[:space:]]*"version":[[:space:]]*"\([^"]*\)",/\1/')

NUMVERSION   = $(shell echo $(EXTVERSION) | sed -e 's/\([[:digit:]]*[.][[:digit:]]*\).*/\1/')
DATA         = sql/$(EXTENSION)--$(EXTVERSION).sql
TESTS        = test/sql/$(EXTENSION)_test--$(EXTVERSION).sql
REGRESS	     = test/sql/$(EXTENSION)_test--$(EXTVERSION).out
DOCS         = README.md

PG_CONFIG    = pg_config

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
