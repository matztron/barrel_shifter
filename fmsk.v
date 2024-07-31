// The first mask that is computed is the F mask, 
// ...which contains B leading zeros and N-B trailing ones
module fmsk 
#(
    parameter N = 8 // width
)
(
    input [$clog2(N)-1:0] B,
    output [N-1:0] F
);

// thus if N=8 and B=3: F=0001_1111
assign F = { {(N){1'b1}} >> B};

endmodule