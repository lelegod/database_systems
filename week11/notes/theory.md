# Week 11 – Indexing & Hashing (Theory)

## Why Indexes?

Without an index a SELECT scans the entire file sequentially (block by block).  
An index is a separate, smaller structure that lets the DBMS jump directly to the relevant block.

**Index evaluation metrics:** access time, insertion time, deletion time, space overhead.

---

## File Organization

| Type | Description |
|------|-------------|
| **Heap file** | Records placed anywhere there is space (unordered) |
| **Sequential file** | Records sorted on a *search key* |
| **Hash file** | Hash function on an attribute determines which block a record goes to |

---

## Index Concepts

| Term | Definition |
|------|-----------|
| **Search key** | The attribute(s) the index is built on |
| **Index file** | Small file of (search key, pointer) pairs |
| **Pointer** | Points to the block (or record) in the data file |

---

## Primary vs Secondary Index

| | Primary index | Secondary index |
|--|--------------|----------------|
| Data file order | Sorted on the same search key | Sorted on a *different* key |
| Also called | Clustering index | Non-clustering index |
| Per relation | At most **one** | Can have **many** |
| Sparse possible? | Yes | No (must be dense) |

---

## Dense vs Sparse Index

| | Dense | Sparse |
|--|-------|--------|
| Index entry per... | Every search key value in the data file | Only one value per *block* |
| Requires primary index? | No | Yes (data must be sorted on the search key) |
| Size | Larger | Smaller |

**Sparse index lookup:** find the largest key ≤ target in the index, follow pointer, then scan sequentially from there.

---

## Multilevel Indexes

- An index on top of an index (outer index = sparse index on inner index)
- Reduces the number of disk accesses for large index files
- **B+ tree** is the standard multilevel index in practice

---

## B+ Tree

- A balanced tree where all data records are in leaf nodes
- Internal nodes hold search keys and pointers to child nodes
- Leaf nodes hold (search key, record pointer) and are linked
- Height stays O(log n) even as data grows
- Supports both point queries and range queries efficiently
- Default index type in MariaDB/MySQL (InnoDB = B+ tree)

---

## Hashing

| Term | Definition |
|------|-----------|
| **Hash function** h(K) | Maps a search key K to a bucket (block) address |
| **Bucket** | A block in the hash file |
| **Collision** | Two keys map to the same bucket |

**Example:** h(K) = K % 3 + 1 → record with key 15151 goes to block 15151 % 3 + 1 = 2

**Advantages:** O(1) point lookups.  
**Disadvantages:** Range queries are inefficient; overflow handling needed.

**Static hashing:** fixed number of buckets — can cause overflow as data grows.  
**Dynamic / extendable hashing:** bucket count grows as needed.

---

## Summary Comparison

| Structure | Best for | Weakness |
|-----------|---------|---------|
| Sequential (ordered) index | Range queries, sorted output | Slow insertions (shift records) |
| B+ tree | Range + point queries, insertions, deletions | Space overhead |
| Hash | Exact-match (point) queries | Range queries; collision handling |
