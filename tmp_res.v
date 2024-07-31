module tmp_res 
#(
    parameter N = 8;
)(
    input [N-1:0] Y_hat,
    input sla,
    input sra,
    input [N-1:0] A,
    input [N-1:0] P_msk,
    
    output [N-1:0] T
);

wire s;
assign s = sra & A[N-1];

// first element
T[0] = Y_hat[0] & ~sla | sla & A[N-1];

// other elements of T
genvar i;
generate
    for (i = 1; i < N; i = i + 1) begin : T_LOOP
        T[i] = Y_hat[i] & P_msk[i] | s & ~P_msk[i];
    end
endgenerate

endmodule