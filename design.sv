

module SR_latch (
  input S, R,
  output Qn, Qn1
);
  assign Qn1 = ~(R | Qn);
  assign Qn  = ~(S | Qn1);
endmodule

module SR_FF (
  input clk, rst,
  input S, R,
  output reg Qn, Qn1
);

  wire q_temp, qn_temp;

  SR_latch latch_inst (
    .S(S),
    .R(R),
    .Qn(q_temp),
    .Qn1(qn_temp)
  );
	
  // using the clock at asynchornous reset
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      Qn  <= 0;
      Qn1 <= 1;
    end else begin
      Qn  <= q_temp;
      Qn1 <= qn_temp;
    end
  end

endmodule
