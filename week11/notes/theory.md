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

### B+ Tree Node Capacity (order n)

| Node type | Min keys | Max keys |
|-----------|---------|---------|
| Internal node | ⌈n/2⌉ − 1 | n − 1 |
| Leaf node | ⌈(n−1)/2⌉ | n − 1 |
| Root (special) | 1 | n − 1 |

*n = order = maximum number of pointers in an internal node*

**Example (n = 6):** internal nodes hold 3–5 keys; leaf nodes hold 3–5 keys.

### B+ Tree Search

**Point query** (find key K):
1. Start at root — find the child pointer range where K falls
2. Follow pointer down to next level; repeat
3. At leaf: follow record pointer to data file

**Range query** (find all keys between K1 and K2):
1. Point-search for K1 to reach the correct leaf
2. Follow the leaf-level linked list rightward until K > K2

---

## Hashing

| Term | Definition |
|------|-----------|
| **Hash function** h(K) | Maps a search key K to a bucket (block) address |
| **Bucket** | A block in the hash file |
| **Collision** | Two keys map to the same bucket |

**Example:** h(K) = K % 4 → StudID 70557 goes to bucket 70557 % 4 = 1

**Applying a hash function manually:**
```
h(K) = K % n_buckets       (or K % n_buckets + 1 if buckets are 1-indexed)

StudID  h(K) = K % 4    Bucket
10101   10101 % 4 = 1   bucket 1
12121   12121 % 4 = 1   bucket 1  ← collision
15151   15151 % 4 = 3   bucket 3
22222   22222 % 4 = 2   bucket 2
```

**Overflow buckets:** If a bucket is full and a new record hashes to it, the record goes in an overflow bucket chained to the original. This slows lookup.

**Hash file vs Hash index:**
- **Hash file (hashed data file):** The actual records are stored in buckets determined by the hash. No separate index file.
- **Hash index:** The index entries (search key + pointer) are hashed into index buckets; the data file is stored separately and is unordered.

**Advantages:** O(1) average point lookups.  
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
