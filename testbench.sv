
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
  
  initial
    begin
      clk = 0;
      forever #5 clk = ~clk;
    end
  
    initial begin
      // Initial values
     #10
      rst = 1;
      
    S = 0; R = 0;
    #10;
    
    // Set: S = 1, R = 0
    S = 1; R = 0;
    #10;

    // Hold: S = 0, R = 0
    S = 0; R = 0;
    #10;

    // Reset: S = 0, R = 1
    S = 0; R = 1;
    #10;

    // Hold again: S = 0, R = 0
    S = 0; R = 0;
    #10;

    // Invalid state: S = 1, R = 1 (both high)
    S = 1; R = 1;
    #10;

    // End simulation
    $finish;
  end
  initial begin
    $display("Time\tS R | Qn Qn1");
    $monitor("%0t\t%b %b | %b  %b", $time, S, R, Qn, Qn1);
    $dumpfile("SR_latch.vcd");
    $dumpvars(0, tb_SR_latch);
  end
endmodule
