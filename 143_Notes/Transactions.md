## Transactions

Collections of operations that form a single logical unit of work are called transactions. 

### Transaction Concept

​	A transaction is a unit of program execution that accesses and possibly updates various data items. The transaction consists of all operations executed between the **begin transaction** and **end transaction**. 

​	A set of logically related operations is known as transaction. The main operations of a transaction are:

- **Read(A):** Read operations Read(A) or R(A) reads the value of A from the database and stores it in a buffer in main memory.

- **Write (A):** Write operation Write(A) or W(A) writes the value back to the database from buffer.

- **Commit:** After all instructions of a transaction are successfully executed, the changes made by transaction are made permanent in the database.
- **Rollback:** If a transaction is not able to execute all operations successfully, all the changes made by transaction are undone.

​	We require that the database system maintain the following properties of the transactions:

1. **Atomicity**. Either all operations of the transaction are reflected properly in the database, or none are.
2. **Consistency**. Execution of a transaction in isolation (that is, with no other transaction executing concurrently) preserves the consistency of the database.
3. **Isolation**. Each transaction is unaware of other transactions executing concurrently in the system. In other words, result of a transaction should not be visible to others before transaction is committed.
4. **Durability**. After transaction completes successfully, the changes it has made to the database persist, even if there are system failures.

**What is a Schedule?**

A schedule is a series of operations from one or more transactions. A schedule can be of two types:

- **Serial Schedule:** When one transaction completely executes before starting another transaction, the schedule is called serial schedule. <u>A serial schedule is always consistent</u>. e.g.; If a schedule S has debit transaction T~1~ and credit transaction T~2~, possible serial schedules are T~1~ followed by T~2~ (T~1~->T~2~) or T~2~ followed by T~1~ ((T~1~->T~2~). A serial schedule has low throughput and less resource utilization.
- **Concurrent Schedule:** When operations of a transaction are interleaved with operations of other transactions of a schedule, the schedule is called Concurrent schedule. e.g.; Schedule of debit and credit transaction shown in Table 1 is concurrent in nature. But <u>concurrency can lead to inconsistency in the database</u>.



## Concurrency Control

### Lock-Based Protocols

​	A lock is a variable associated with a data item that describes a status of data item with respect to possible operation that can be applied to it. They synchronize the access by concurrent transactions to the database items. It is required in this protocol that all the data items **must be accessed in a mutually exclusive manner**,  that is while one transaction is accessing a data item, no other transaction can modify that data item.

#### 1. Locks 

- **Shared (S)**. If a transaction T~i~ has obtained a shared-mode lock (denoted by S) on item Q, then T~i~ **can read, but cannot write**, Q.
- **Exclusive (X)**. If a transaction T~i~ has obtained an exclusive-mode lock (denoted by X) on item Q, then T~i~ can both read and write Q.

**Lock Compatibility Matrix –**

<center><img src="https://media.geeksforgeeks.org/wp-content/cdn-uploads/1-28.png" alt="1" style="zoom:70%;" /></center>

- A transaction may be granted a lock on an item if the requested lock is compatible with locks already held on the item by other transactions.
- Any number of transactions can hold shared locks on an item, but if any transaction holds an exclusive(X) on the item no other transaction may hold any lock on the item.
- If a lock cannot be granted, the requesting transaction is made to wait till all  incompatible locks held by other transactions have been released. Then the lock is granted.

**Upgrade / Downgrade locks :** A transaction that holds a lock on an item **A** is allowed under certain condition to change the lock state from one state to another.

- **Upgrade**: A S(A) can be upgraded to X(A) <u>if T~i~ is the only transaction holding the S-lock on element A</u>.
- **Downgrade**: We may downgrade X(A) to S(A) when we feel that we no longer want to write on data-item A. As we were holding X-lock on A, we need not check any conditions.

- Consider the Partial Schedule:

- |      |  **T1**   |  **T2**   |
  | :--: | :-------: | :-------: |
  |  1   | lock-X(B) |           |
  |  2   |  read(B)  |           |
  |  3   |  B:=B-50  |           |
  |  4   | write(B)  |           |
  |  5   |           | lock-S(A) |
  |  6   |           |  read(A)  |
  |  7   |           | lock-S(B) |
  |  8   | lock-X(A) |           |
  |  9   |    ……     |    ……     |

- **Deadlock –** consider the above execution phase. Now, **T~1~** holds an Exclusive lock over B, and **T~2~** holds a Shared lock over A. Consider Statement 7, **T~2~** requests for lock on B, while in Statement 8 **T~1~** requests lock on A. This as you may notice imposes a **Deadlock** as none can proceed with their execution.

- **Starvation –** is also possible if concurrency control manager is badly designed. For example: A transaction may be waiting for an X-lock on an item, while a sequence of other transactions request and are granted an S-lock on the same item. This may be avoided if the concurrency control manager is properly designed.

#### 2. Granting of Locks

We can avoid starvation of transactions by granting locks in the following manner: When a transaction T~i~ requests a lock on a data item Q in a particular mode M, the concurrency-control manager grants the lock provided that:

1. There is no other transaction holding a lock on Q in a mode that conflicts with M. 
2. There is no other transaction that is waiting for a lock on Q and that made its lock request before T~i~ .

#### 3. The Two-Phase Locking Protocol

This protocol ensures serializability, which requires that each transaction issue lock and unlock requests in two phases:

1. Growing phase. A transaction may obtain locks, but may not release any lock.
2. Shrinking phase. A transaction may release locks, but may not obtain any new locks.

Initially, a transaction is in the growing phase. The transaction acquires locks as needed. Once the transaction releases a lock, it enters the shrinking phase, and it can issue no more lock requests.

**Note –** If lock conversion is allowed, then upgrading of lock( from S(a) to X(a) ) is allowed in Growing Phase and downgrading of lock (from X(a) to S(a)) must be done in shrinking phase.

**Lock Point**

- The Point at which the growing phase ends, i.e., when transaction takes the final lock it needs to carry on its work. 

|  T1  |    T2     |           |
| :--: | :-------: | :-------: |
|  1   | LOCK-S(A) |           |
|  2   |           | LOCK-S(A) |
|  3   | LOCK-X(B) |           |
|  4   |    …….    |    ……     |
|  5   | UNLOCK(A) |           |
|  6   |           | LOCK-X(C) |
|  7   | UNLOCK(B) |           |
|  8   |           | UNLOCK(A) |
|  9   |           | UNLOCK(C) |
|  10  |    …….    |    ……     |

- **Transaction T~1~**:
  - Growing Phase is from steps 1-3.
  - Shrinking Phase is from steps 5-7.
  - Lock Point at 3

- **Transaction T~2~**:
  - Growing Phase is from steps 2-6.
  - Shrinking Phase is from steps 8-9.
  - Lock Point at 6

**Deadlock in 2-PL is possible**

```
Schedule:   Lock-X1(A)   Lock-X2(B)  Lock-X1(B)  Lock-X2(A)
```

#### 4. Implementation of Locking - Lock Table

For each data item that is currently locked, it maintains a linked list of records, one for each request, in the order in which the requests arrived. It uses a hash table, indexed on the name of a data item, to find the linked list (if any) for a data item; this table is called the lock table.

<img src="https://media.geeksforgeeks.org/wp-content/uploads/Slide1-4.jpg" alt="Image result for lock table" style="zoom:67%;" />

#### 5. Graph-Based Protocols

​	*Tree Based Protocols is a simple implementation of Graph Based Protocol*.

​	A prerequisite of this protocol is that we know the order to access a Database Item. For this we implement a **Partial Ordering** on a set of the **Database Items (D) *{d~1~, d~2~, d~3~, ….., d~n~}*** . The protocol following the implementation of Partial Ordering is stated as

- If ***d~i~–> d~j~*** then any transaction accessing both d~i~ and d~j~ must access d~i~ before accessing d~j~.
- Implies that the set **D** may now be viewed as a directed acyclic graph (DAG), called a *database graph*.

**Tree Based Protocol –**

- Partial Order on Database items determines a tree like structure.
- Only Exclusive Locks are allowed.
- The first lock by Ti may be on any data item. Subsequently, a data Q can be locked by Ti only if the parent of Q is currently locked by Ti.
- Data items can be unlocked at any time.

Following the Tree based Protocol ensures **Conflict Serializablity and Deadlock Free** schedule. We need not wait for unlocking a Data item as we did in 2-PL protocol, thus increasing the concurrency.



![222](https://media.geeksforgeeks.org/wp-content/cdn-uploads/222-1.png)

