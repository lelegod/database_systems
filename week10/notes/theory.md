# Week 10 – Normalization (Theory)

## Why Normalize?

**Redundancy** = the same data stored in more than one place.
**Modification anomalies** occur when INSERT / UPDATE / DELETE leaves the database inconsistent because redundant data is not updated everywhere.

**Normalization** decomposes tables into smaller ones (by projection) without losing information, then links them via foreign keys.
- The decomposition is **lossless** (original table recoverable by joining)
- Goal: data consistency + avoid extensive searches

---

## Functional Dependencies (FDs)

**X → Y** ("X functionally determines Y") holds for relation schema R if:
> In every legal instance of R, whenever two rows have the same X value they also have the same Y value.

- **Trivial FD:** X → Y where Y ⊆ X (e.g., {A,B} → {A})
- **Non-trivial FD:** Y is not a subset of X — these are the interesting ones

**Determinant** = X (the left side); **Dependent** = Y (the right side)

**Canonical cover set F:** A minimal set of FDs from which all valid FDs can be derived.
**Closure set F+:** All FDs that can be logically derived from F.

---

## Armstrong's Axioms (sound & complete)

| Rule | Statement |
|------|-----------|
| **Reflexivity** | If Y ⊆ X, then X → Y |
| **Augmentation** | If X → Y, then XZ → YZ |
| **Transitivity** | If X → Y and Y → Z, then X → Z |

**Derived theorems:**

| Rule | Statement |
|------|-----------|
| Self-determination | X → X |
| Decomposition | If X → YZ, then X → Y and X → Z |
| Union | If X → Y and X → Z, then X → YZ |
| Composition | If X → Y and Z → V, then XZ → YV |
| General Unification | If X → Y and Z → V, then X ∪ (Z−Y) → YV |

---

## Keys via FDs

| Key | FD definition |
|-----|--------------|
| **Superkey** K | K → X holds for *every* attribute X of R |
| **Candidate key** K | K → A_R *and* no proper subset of K also determines A_R |
| **Primary key** | One candidate key selected by the DBA |

---

## Normal Form Hierarchy

```
1NF ⊃ 2NF ⊃ 3NF ⊃ BCNF ⊃ 4NF ⊃ 5NF ⊃ DKNF
```
If a schema is in BCNF it is also automatically in 3NF, 2NF, and 1NF.

---

## Normal Forms — Informal Mnemonics

| NF | Informal rule |
|----|--------------|
| **1NF** | All attributes depend on **the key** |
| **2NF** | All attributes depend on **the whole key** |
| **3NF** | All attributes depend on **nothing but the key** |

---

## Formal Definitions

### 1NF
Every attribute value must be **atomic** (single-valued, not multivalued or composite).

### 2NF (original definition — one candidate key = PK)
R is in 2NF if it is in 1NF and every non-key attribute is **fully functionally dependent** on the primary key (no partial dependency — no non-key attribute depends on only part of a composite PK).

### 3NF (original definition)
R is in 3NF if it is in 2NF and no non-key attribute is **transitively dependent** on the primary key (no non-key attribute depends on another non-key attribute).

### BCNF (Boyce-Codd Normal Form)
R is in BCNF if for every non-trivial FD X → Y, X is a **superkey** of R.
- Stronger than 3NF; eliminates all anomalies based on FDs
- Decomposition to BCNF may not always preserve all FDs

### 4NF
R is in 4NF if for every non-trivial **multivalued dependency** X →→ Y, X is a superkey.
- Handles redundancy caused by independent multivalued facts
- A schema in BCNF may still violate 4NF

---

## How to Identify FDs (exam skill)

For each non-key attribute, ask: *"What is the minimal set of attributes that logically determines this value?"*

**Example schema:** `ClientSales(ClientNo, SalesRepNo, CName, SName, Date)`

| FD | Reasoning |
|----|-----------|
| ClientNo → CName | A client number uniquely determines the client's name |
| SalesRepNo → SName | A sales rep number uniquely determines the rep's name |
| ClientNo, SalesRepNo → Date | The date of a sale is determined by which client + which rep |

- `CName` depends only on `ClientNo` — **partial dependency** → violates 2NF
- `SName` depends only on `SalesRepNo` — **partial dependency** → violates 2NF

---

## Attribute Closure (finding candidate keys)

The closure of a set X under FD set F, written X+, is all attributes determined by X.

**Algorithm:**
1. Start: result = X
2. For each FD A → B in F: if A ⊆ result, add B to result
3. Repeat step 2 until no change

**Example:** F = {A → B, B → C, A → D}, find {A}+
- Start: {A}
- A → B: {A, B}
- B → C: {A, B, C}
- A → D: {A, B, C, D}
- {A}+ = {A, B, C, D} → A is a superkey (and candidate key if no subset also covers all)

---

## BCNF — Worked Example

**Schema:** `Section(CourseID, SectionID, Semester, StudyYear, Building, Room, TimeSlotID)`

**FD:** `Building, Room → TimeSlotID` — left side is not a superkey → **BCNF violation**

**Decompose:**
```
RoomSlot(Building, Room, TimeSlotID)      -- Building,Room is the PK here
Section(CourseID, SectionID, Semester, StudyYear, Building, Room)
```

**BCNF check:** For every non-trivial FD X → Y, X must be a superkey. If not, decompose.

---

## Armstrong's Rules — Step-by-Step Application

Given FDs: `{A → B, B → C, A → D, D → E}`

```
1. A → B                (given)
2. B → C                (given)
3. A → C                (transitivity: 1 + 2)
4. A → D                (given)
5. D → E                (given)
6. A → E                (transitivity: 4 + 5)
7. A → BC               (union: 1 + 2, since A→B and A→C)
8. A → BCDE             (union of all derived: A→B, A→C, A→D, A→E)
   → A is a superkey if BCDE covers all attributes
```

---

## Normalization Process

1. Start with a "bad" (redundant) table
2. Identify the FDs
3. Check which normal form is violated
4. **Decompose** (project) the table into two or more smaller tables
5. Define FK relationships so decomposition is reversible (lossless join)
6. Repeat until desired NF is reached
