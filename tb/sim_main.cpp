#include <stdlib.h>
#include <stdint.h>
#include "Vtb_top.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char* argv[])
{
  uint64_t cycles;

  if (argc < 2) {
    printf("usage: %s [cycles]\n", argv[0]);
    exit(-1);
  }

  cycles = atol(argv[1]);

  printf("starting sim...\n");

  VerilatedContext* contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);

  Vtb_top* tb = new Vtb_top{contextp};

  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  tb->trace(tfp, 24);
  tfp->open("sim.vcd");

  // sim loop
  for (uint64_t i = 0; (i >> 1) < cycles; i++) {
    tfp->dump(i);
    if (i >= 2) {
      tb->clk = !tb->clk;
    } else if (i == 0) {
      tb->rst_n = 0;
      tb->clk = 0;
    } else if (i == 1) {
      tb->rst_n = 1;
    }
    tb->eval();
  }

  delete tfp;
  delete tb;
  delete contextp;
  return 0;
}
