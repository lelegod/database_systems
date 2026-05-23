# Week 3 – Introductory SQL: DQL (Theory)

## Query Structure

A basic SQL query always follows: **SELECT → FROM → WHERE**

The relational algebra equivalent of `SELECT A1,...,An FROM R1,...,Rm WHERE P` is:
`Π_A1,...,An (σ_P (R1 × ... × Rm))`

## NULL and Three-Valued Logic

SQL uses **three truth values**: TRUE, FALSE, **UNKNOWN**

| Expression | Result |
|-----------|--------|
| `NULL = anything` | UNKNOWN |
| `NULL <> anything` | UNKNOWN |
| `TRUE AND UNKNOWN` | UNKNOWN |
| `FALSE AND UNKNOWN` | FALSE |
| `TRUE OR UNKNOWN` | TRUE |
| `FALSE OR UNKNOWN` | UNKNOWN |
| `NOT UNKNOWN` | UNKNOWN |

**Rule:** WHERE only passes rows where the condition evaluates to **TRUE** (not UNKNOWN or FALSE).

Test for NULL: `IS NULL` / `IS NOT NULL` (never use `= NULL`)

## LIKE Pattern Matching

| Symbol | Meaning |
|--------|---------|
| `%` | Any sequence of zero or more characters |
| `_` | Exactly one character |

Example: `name LIKE 'A%'` → starts with A; `name LIKE '_ohn'` → John, Cohn, etc.

## Aggregate Functions

| Function | Returns |
|---------|---------|
| `COUNT(*)` | Number of rows (including NULLs) |
| `COUNT(col)` | Number of non-NULL values |
| `SUM(col)` | Sum of non-NULL values |
| `AVG(col)` | Average of non-NULL values |
| `MIN(col)` | Minimum non-NULL value |
| `MAX(col)` | Maximum non-NULL value |

- Aggregates **ignore NULLs** (except `COUNT(*)`)
- `COUNT(DISTINCT col)` counts distinct non-NULL values

## GROUP BY / HAVING Rules

- Columns in SELECT must either appear in GROUP BY or be inside an aggregate
- **HAVING** filters *groups* (applied after grouping); **WHERE** filters *rows* (applied before grouping)
- Order of clauses: `SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY`

## ORDER BY

- `ORDER BY col ASC` (default) or `ORDER BY col DESC`
- Can order by multiple columns: `ORDER BY col1, col2 DESC`
