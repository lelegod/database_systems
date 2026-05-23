# Week 6 – Entity-Relationship Diagrams (Theory)

## Three Design Phases

| Phase | Output |
|-------|--------|
| **Conceptual design** | ER diagram (implementation-independent) |
| **Logical design** | Relational schema (tables, columns, keys) |
| **Physical design** | Storage, indexes, performance tuning |

## ER Diagram Elements

| Symbol | Represents |
|--------|-----------|
| Rectangle | Entity set |
| Double rectangle | Weak entity set |
| Diamond | Relationship set |
| Double diamond | Identifying relationship (for weak entity) |
| Ellipse | Attribute |
| Dashed ellipse | Derived attribute |
| Double ellipse | Multivalued attribute |
| Underline | Primary key attribute |
| Dashed underline (discriminator) | Partial key of a weak entity |
| Line | Connects entity to relationship |

## Attribute Types

| Type | Notation | Example |
|------|---------|---------|
| Simple / Atomic | Plain ellipse | `name` |
| Composite | Ellipse with sub-ellipses | `address` → `street`, `city` |
| Multivalued | Double ellipse | `{phone_numbers}` |
| Derived | Dashed ellipse | `(age)` derived from `birth_date` |

## Cardinality (crow's foot / arrow notation)

| Arrow | Meaning |
|-------|---------|
| → (arrow) | "one" side |
| — (no arrow) | "many" side |

| Cardinality | Notation |
|------------|---------|
| One-to-one | →Rel→ |
| One-to-many | →Rel— |
| Many-to-one | —Rel→ |
| Many-to-many | —Rel— |

## Participation Constraints

| Line | Meaning |
|------|---------|
| Single line | **Partial** participation (entity may not participate) |
| Double line | **Total** participation (every entity must participate) |

## Strong vs Weak Entity Sets

| | Strong | Weak |
|--|--------|------|
| Has own PK? | Yes | No |
| Depends on? | Independent | Identifying entity (via identifying relationship) |
| Symbol | Rectangle | Double rectangle |
| Key | Primary key | **Discriminator** (partial key) — unique only within owner |

A weak entity's full key = identifying entity's PK + discriminator.

## Ternary Relationships

- A relationship set involving 3 entity sets
- **At most one arrow** allowed in a ternary relationship (if an arrow points to entity E, then knowing the other two entities determines at most one E)

## Converting ER to Relational Tables

| ER construct | Relational table |
|-------------|-----------------|
| Entity set E with PK k | Table E with all attributes; PK = k |
| Many-to-many relationship R | New table with PKs of both entities + any relationship attributes |
| Many-to-one relationship | Add FK to the "many" side entity table (no separate table needed) |
| One-to-one relationship | Add FK to either side (or merge tables) |
| Multivalued attribute A of entity E | New table (E.pk, A) with composite PK |
| Weak entity W with owner E | Table W includes E's PK as FK; PK = (E.pk, discriminator) |
