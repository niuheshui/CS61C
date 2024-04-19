.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s
.import classify.s

.globl main

# run
# java -jar tools/venus.jar src/main.s -ms -1 tests/inputs/mnist/bin/m0.bin tests/inputs/mnist/bin/m1.bin tests/inputs/mnist/bin/inputs/mnist_input1.bin  tests/outputs/test_mnist_main/student_mnist_outputs.bin
# This is a dummy main function which imports and calls the classify function.
# While it just exits right after, it could always call classify again.
main:
    jal classify
    jal exit
