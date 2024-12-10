# rocksdb-segfault

First run, with fresh db, should fail:

```
zig build run -Doptimize=ReleaseSafe -DfreshDb=true
...
...
Wrote random data
Wrote random data
Wrote random data
run
└─ run rocksdb_segfault failure
error: the following command terminated unexpectedly:
/home/ubuntu/dadepo/rocksdb-segfault/zig-out/bin/rocksdb_segfault 
Build Summary: 8/10 steps succeeded; 1 failed (disable with --summary none)
run transitive failure
└─ run rocksdb_segfault failure
error: the following build command failed with exit code 1:
/home/ubuntu/dadepo/rocksdb-segfault/.zig-cache/o/e7346d8c5c8b0b92f65085f1566af3aa/build /home/ubuntu/zig-linux-x86_64-0.13.0/zig /home/ubuntu/dadepo/rocksdb-segfault /home/ubuntu/dadepo/rocksdb-segfault/.zig-cache /home/ubuntu/.cache/zig --seed 0xdac62fd0 -Zec503a3c25f22dd5 run -Doptimize=ReleaseSafe -DfreshDb=true
```

Second run, without fresh db, should fail:

```
zig build run -Doptimize=ReleaseSafe
Segmentation fault at address 0x8
/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/util/core_local.h:74:55: 0x13ab2dd in AccessElementAndIndex (/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/db/memtable.cc)
    core_idx = static_cast<size_t>(BottomNBits(cpuid, size_shift_));
                                                      ^
/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/util/core_local.h:63:10: 0x139e092 in NewRangeTombstoneIteratorInternal (/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/db/memtable.cc)
  return AccessElementAndIndex().first;
         ^
/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/db/db_impl/db_impl_open.cc:1711:16: 0x127aa10 in WriteLevel0TableForRecovery (/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/db/db_impl/db_impl_open.cc)
          mem->NewRangeTombstoneIterator(ro, kMaxSequenceNumber,
               ^
/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/db/db_impl/db_impl_open.cc:1501:20: 0x1277cba in RecoverLogFiles (/home/ubuntu/.cache/zig/p/122043e5b3e4e5bc544774453dce561b03fb12ed6516bbb637d4bdabd9880273b296/db/db_impl/db_impl_open.cc)
          status = WriteLevel0TableForRecovery(job_id, cfd, cfd->mem(), edit);
                   ^
Unwind error at address `:0x1277cba` (error.UnimplementedUserOpcode), trace may be incomplete

???:?:?: 0x0 in ??? (???)
run
└─ run rocksdb_segfault failure
error: the following command terminated unexpectedly:
/home/ubuntu/dadepo/rocksdb-segfault/zig-out/bin/rocksdb_segfault 
Build Summary: 8/10 steps succeeded; 1 failed (disable with --summary none)
run transitive failure
└─ run rocksdb_segfault failure
error: the following build command failed with exit code 1:
/home/ubuntu/dadepo/rocksdb-segfault/.zig-cache/o/e7346d8c5c8b0b92f65085f1566af3aa/build /home/ubuntu/zig-linux-x86_64-0.13.0/zig /home/ubuntu/dadepo/rocksdb-segfault /home/ubuntu/dadepo/rocksdb-segfault/.zig-cache /home/ubuntu/.cache/zig --seed 0xff008a8c -Z7bd8ada55bbcc289 run -Doptimize=ReleaseSafe
```