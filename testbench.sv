



module tb_SR_latch;

  // Testbench signals
  reg S, R, clk, rst;
  wire Qn, Qn1;

  // Instantiate the DUT (Device Under Test)
  SR_FF dut (
    .clk(clk),
    .rst(rst),
    .S(S),
    .R(R),
    .Qn(Qn),
    .Qn1(Qn1)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Initialize
    rst = 0;
    S = 0;
    R = 0;

    #10 rst = 1;      // Time 10ns: Apply async reset
    #5  rst = 0;      // Release reset before next posedge clk

    // Now proceed with SR inputs
    #5;               // Time 20ns
    S = 0; R = 1;

    #10;              // Time 30ns
    S = 0; R = 0;

    #10;              // Time 40ns
    S = 0; R = 1;

    #10;              // Time 50ns
    S = 1; R = 0;

    #10;              // Time 60ns
    S = 1; R = 1;      // Invalid condition

    #10;
    $finish;
  end

  // Waveform and monitoring
  initial begin
    $display("Time\tS R | Qn Qn1");
    $monitor("%0t\t%b %b | %b  %b", $time, S, R, Qn, Qn1);
    $dumpfile("SR_latch.vcd");
    $dumpvars(0, tb_SR_latch);
  end
endmodule
