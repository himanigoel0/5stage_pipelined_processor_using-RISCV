# Verification of Cache Miss Penalty Logic using Dummy Cache

## Objective

The objective of this experiment is to model and verify cache miss penalty behavior using a dummy cache module.

Since a complete cache hierarchy was not implemented, a simplified cache model was created to emulate cache miss behavior and observe its effect on processor execution. The focus of this experiment is to verify that a cache miss introduces additional latency and stalls processor execution for a fixed number of clock cycles.

---

# Background

Modern processors use cache memory to reduce memory access latency.

When the requested data is present in the cache, the access is called a:

```text
Cache Hit
```

and the data can be returned immediately.

When the requested data is not present in the cache, the access is called a:

```text
Cache Miss
```

and the processor must wait while the data is fetched from a lower memory level.

The additional waiting time caused by a cache miss is known as:

```text
Cache Miss Penalty
```

---

# Dummy Cache Concept

Instead of implementing a real cache with:

* Tag memory
* Valid bits
* Hit/Miss comparison logic
* Cache replacement policies

a simplified dummy cache was created.

The dummy cache performs the following operations:

1. Detects the first memory read request (`memread`).
2. Generates a cache miss.
3. Stalls execution for a fixed number of cycles.
4. Releases the stall after the penalty period expires.

This allows verification of cache miss penalty behavior without implementing a complete cache subsystem.

---

# Dummy Cache Architecture

## Inputs

| Signal  | Description                          |
| ------- | ------------------------------------ |
| clk     | System clock                         |
| rst     | Reset signal                         |
| memread | Memory read request (LW instruction) |

---

## Outputs

| Signal      | Description                                    |
| ----------- | ---------------------------------------------- |
| cache_miss  | Indicates a cache miss condition               |
| cache_stall | Requests processor stall during miss servicing |

---

## Internal Signals

### miss_counter

A countdown counter used to model memory access latency.

```text
3 → 2 → 1 → 0
```

The counter value represents the number of remaining miss penalty cycles.

---

### miss_serviced

A flag used to ensure that the same memory request does not repeatedly generate cache misses.

Without this signal, every clock cycle during a memory read would continuously regenerate cache misses.

---

# Cache Miss Penalty Logic

When the first load request is detected:

```verilog
if(memread && !miss_serviced && !cache_stall)
```

the following actions occur:

```text
cache_miss  = 1
cache_stall = 1
miss_counter = 3
miss_serviced = 1
```

This indicates:

* Cache miss detected
* Processor must wait
* Miss penalty initialized to 3 cycles

---

# Counter Operation

The miss counter operates as:

```text
3
↓
2
↓
1
↓
0
```

During each countdown cycle:

```text
cache_stall = 1
```

and processor execution remains stalled.

When the counter reaches zero:

```text
cache_stall = 0
cache_miss  = 0
```

Execution resumes.

---

# Testbench

The testbench generates a single memory read request.

```verilog
memread = 1;
```

which represents a load instruction requesting data from memory.

The objective is to verify:

1. Cache miss generation
2. Stall generation
3. Miss penalty duration
4. Processor resume operation

---

# Waveform Analysis

## Reset Phase

Initially:

```text
rst = 1
```

All internal registers are cleared.

Observed:

```text
cache_miss  = 0
cache_stall = 0
miss_counter = 0
```

---

## Memory Read Request

At approximately:

```text
20 ns
```

the testbench asserts:

```text
memread = 1
```

representing a load request.

---

## Cache Miss Generation

At the next positive clock edge:

```text
cache_miss = 1
cache_stall = 1
miss_counter = 3
```

This indicates that the requested data is not available in the cache and a miss has occurred.

---

## Miss Penalty Cycles

The waveform shows:

```text
miss_counter

3
↓
2
↓
1
```

while:

```text
cache_stall = 1
```

remains asserted.

This demonstrates that processor execution is suspended while the missing data is assumed to be fetched from lower memory.

---

## Miss Completion

When the counter reaches:

```text
0
```

the waveform shows:

```text
cache_miss = 0
cache_stall = 0
```

indicating that the miss has been serviced and execution may continue.

---

# Verification of Miss Penalty

Observed counter sequence:

```text
3 → 2 → 1 → 0
```

Observed stall sequence:

```text
1 → 1 → 1 → 0
```

Therefore:

```text
Cache Miss Penalty = 3 Clock Cycles
```

The processor remains stalled for exactly three cycles before resuming operation.

---

# Results

| Parameter                 | Observed Value |
| ------------------------- | -------------- |
| Cache Miss Generated      | Yes            |
| Processor Stall Generated | Yes            |
| Miss Counter Operation    | Correct        |
| Stall Duration            | 3 Cycles       |
| Processor Resume          | Successful     |

---

# Conclusion

A dummy cache module was successfully implemented to emulate cache miss behavior.

The waveform confirms that:

* A memory read request generates a cache miss.
* The processor is stalled during miss servicing.
* The miss counter correctly models memory access latency.
* The processor remains stalled for exactly three clock cycles.
* Execution resumes correctly after the miss penalty expires.

Thus, the cache miss penalty logic was successfully verified using waveform analysis.
