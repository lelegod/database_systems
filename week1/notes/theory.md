# Week 1 – The Relational Model (Theory)

## Core Concepts

| Term | Definition |
|------|-----------|
| **Relation** | A table with rows and columns; a set of tuples |
| **Relation schema** | R(A1, A2, …, An) — the name + attribute list |
| **Relation instance** | The actual data (set of tuples) at a point in time |
| **Attribute** | A named column; each has a **domain** (allowed values) |
| **Tuple** | A single row; an ordered list of values |
| **Domain** | Set of allowed atomic values for an attribute |

## Keys

| Key Type | Definition |
|----------|-----------|
| **Superkey** | A set of attributes that uniquely identifies every tuple |
| **Candidate key** | A *minimal* superkey (no proper subset is also a superkey) |
| **Primary key** | One candidate key chosen by the DBA; underlined in schemas |

**Tip:** Every candidate key is a superkey, but not vice versa.

## Schema Notation

```
Instructor(InstID, InstName, DeptName, Salary)
           ------  ← primary key underlined
```

## Relational Model Properties

- All attribute values are **atomic** (single-valued)
- Ordering of rows does **not** matter (set semantics)
- Ordering of columns does **not** matter (attributes accessed by name)
- No duplicate tuples allowed

## Integrity Constraints

| Constraint | Meaning |
|-----------|---------|
| **Entity integrity** | Primary key attribute(s) cannot be NULL |
| **Referential integrity** | A FK value must match a PK value in the referenced relation, or be NULL |
| **Domain constraint** | Attribute values must be from the defined domain |

## Referential Integrity (Foreign Keys)

If relation R has a foreign key referencing relation S:
- Every non-NULL FK value in R must appear as a PK value in S
- Ensures no "dangling references"

## Relational Algebra Preview

SQL is built on the relational model; the formal operations map to:
- **Selection** σ → WHERE clause
- **Projection** Π → SELECT clause
- **Join** ⋈ → FROM + JOIN
