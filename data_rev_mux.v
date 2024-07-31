// this is a parametric verilog module for data reversal

module data_rev_mux 
#(
    parameter N=8
)(
    input left,
    input [N-1:0] A,
    output [N-1:0] A_hat
);

generate 
    for(genvar i=0; i<N; i=i+1) begin : REV_LOOP
        assign A_hat[i]= left ? A[N-i-1] : A[i]; // only reverse if left signal is high 
    end
endgenerate

endmodule