# Data for entities such as programmes, call for proposals, rounds or funded projects

This function take the kind of entity requested and also either accepts
a vector of identifiers or a date since which changes should be returned

## Usage

``` r
vinnova(
  kind = c("programmes", "proposals", "rounds", "projects"),
  from_date,
  id
)
```

## Arguments

- kind:

  the type of entity, Default: c("programmes", "proposals", "rounds",
  "projects")

- from_date:

  the date since when changes should be requested, if not set, since
  three days back

- id:

  identifier (or comma separated identifiers) for specific entities

## Value

table with results

## Examples

``` r
if (FALSE) { # \dontrun{
if(interactive()){
 vinnova("programmes", from_date = Sys.Date())
 }
} # }
```
