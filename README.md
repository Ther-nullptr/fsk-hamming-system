# chisel-empty

## usage

generate:
    
```bash
$ make
```

simulate:

```bash
$ make test
```

generate the verilog code into a certain directory:

```scala
// xx.scala
object AddMain extends App {
  println("Generating the adder hardware")
  emitVerilog(new Add(), Array("--target-dir", "generated"))
}
```

simple test (w/o print):

```scala
  "Add" should "work" in {
    test(new Add) { dut =>
      for (a <- 0 to 2) {
        for (b <- 0 to 3) {
          val result = a + b
          dut.io.a.poke(a.U)
          dut.io.b.poke(b.U)
          dut.clock.step(1)
          println(s"expect: $a + $b = $result")
          println(s"result: ${dut.io.c.peek()}")
          dut.io.c.expect(result.U)
        }
      }
    }
  }
```

simple test (w print):

```scala
// ...
println(s"expect: $a + $b = $result") // use scala
println(s"result: ${dut.io.c.peek()}") // extract from chisel
// ... 
```

test with .vcd output:

```scala
test(new Add).withAnnotations(Seq(WriteVcdAnnotation))
// ...
```

then the vcd file can be viewed in `test_run_dir`:

![vcd.png](https://s2.loli.net/2023/10/04/FPHwRb3uUNirkvj.png)
