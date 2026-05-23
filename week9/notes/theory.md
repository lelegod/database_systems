# Week 9 – Formal Query Languages (Theory)

## Two Formal Languages

| Language | Style | Basis |
|---------|-------|-------|
| **Relational Algebra** (RA) | Procedural — *how* to compute | Set theory + Algebra |
| **Domain Calculus** (DC) | Declarative — *what* to compute | Predicate Calculus / Logic |

Both are equivalent in expressive power (restricted to safe expressions).

---

## Relational Algebra: Basic Operations

Let R, S be relations. R has attributes A1,…,An.

| Operation | Notation | SQL equivalent |
|-----------|---------|----------------|
| **Selection** | σ_P(R) | `SELECT * FROM R WHERE P` |
| **Projection** | Π_Ai,…,Aj(R) | `SELECT Ai,…,Aj FROM R` |
| **Set Union** | R ∪ S | `(SELECT * FROM R) UNION (SELECT * FROM S)` |
| **Set Difference** | R − S | `(SELECT * FROM R) EXCEPT (SELECT * FROM S)` |
| **Cartesian Product** | R × S | `SELECT * FROM R, S` or `FROM R JOIN S` |
| **Rename** | ρ_S(R) | `SELECT * FROM R AS S` |

- **Compatible** (for ∪ and −): R and S must have the same number of attributes with matching domains.
- Selection σ corresponds to SQL's **WHERE** (not SELECT).

## Relational Algebra: Derived Operations

| Operation | Notation | SQL equivalent |
|-----------|---------|----------------|
| **Natural Join** | R ⋈ S | `SELECT * FROM R NATURAL JOIN S` |
| **Left Outer Join** | R ⟕ S | `SELECT * FROM R NATURAL LEFT OUTER JOIN S` |
| **Right Outer Join** | R ⟖ S | `SELECT * FROM R NATURAL RIGHT OUTER JOIN S` |
| **Full Outer Join** | R ⟗ S | `SELECT * FROM R NATURAL FULL OUTER JOIN S` |
| **Theta Join** | R ⋈_θ S | `SELECT * FROM R JOIN S ON θ` |
| **Set Intersection** | R ∩ S | `(SELECT * FROM R) INTERSECT (SELECT * FROM S)` |
| **Assignment** | S ← R | `CREATE TABLE S SELECT * FROM R` |

**Derived from basics:**
- R ⋈ S ≡ Π_A,B,C,D,E (σ_{R.B=S.B ∧ R.D=S.D} (R × S))
- R ∩ S ≡ R − (R − S)

## Relational Algebra: Extended Operations

| Operation | RA notation | SQL equivalent |
|-----------|------------|----------------|
| **Generalized Projection** | Π_E1,…,En(R) | `SELECT E1,…,En FROM R` (E_i can be arithmetic) |
| **Aggregate Operation** | G_{F1(A1),…}(R) | `SELECT F1(A1),… FROM R` |
| **Grouping + Aggregate** | Ax G_{F1(A1),…}(R) | `SELECT Ax, F1(A1),… FROM R GROUP BY Ax` |

Aggregate functions: AVG, MIN, MAX, SUM, COUNT, COUNT-DISTINCT, …

**SQL semantics:** `SELECT A1,…,An FROM R1,…,Rm WHERE P` ≡ Π_{A1,…,An}(σ_P(R1 × … × Rm))

---

## Domain Calculus

- A **declarative** (non-procedural) query language
- Mathematical basis for **QBE** (Query-By-Example)

**Query form:** `{ <x1, x2, …, xn> | P(x1, x2, …, xn) }`

- x1,…,xn = **domain variables** representing attribute values
- P = a **Predicate Calculus formula** (the condition tuples must satisfy)

**Predicate formula building blocks:**

| Form | Meaning |
|------|---------|
| `<v1,…,vn> ∈ R` | Tuple is in relation R |
| `xi op xj` or `xi op c` | Comparison (op: <, ≤, =, ≠, >, ≥) |
| `f1 ∧ f2` | AND |
| `f1 ∨ f2` | OR |
| `¬f1` | NOT |
| `∃x(P(x))` | There exists an x for which P(x) is true |
| `∀x(P(x))` | For all x, P(x) is true |

**Free vs bound variables:**
- A variable is **bound** if quantified by ∃ or ∀
- A variable is **free** if not bound
- In `{<x1,…,xn> | P}`, only x1,…,xn are allowed to be free in P

**Example:** SQL `SELECT B, A FROM R WHERE D>100` in Domain Calculus:
`{ <b, a> | ∃c,d(<a,b,c,d> ∈ R ∧ d>100) }`
