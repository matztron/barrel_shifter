module right_rotator 
#(
    parameter N=8
)(
    input [$clog2(N)-1:0] B,
    input [N-1:0] A,
    output [N-1:0] Y
);

// This probably yields better synthesizing result but the code below 'behaves' the same ;)
/*localparam ROWS = $clog2(N);
localparam COLS = N;

wire [(ROWS*COLS)-1:0] A_out;

// at 8 bit we have to shift 4 2 1
// at 4 bits we have to shift 2 1

// 0th row
generate 
        for(genvar j=0; j<COLS; j++) begin : ROW_LOOP
            mux2 mux_I (
                .inp0(A[j]),
                .inp1(1'b0),
                .sel(B[ROWS-1]),
                .out(A_out_first_row[j])
            );
        end 
endgenerate

// other rows
generate 
    for(genvar i=1; i<ROWS; i++) begin : COL_LOOP
        for(genvar j=0; j<COLS; j++) begin : ROW_LOOP
            mux2 mux_I (
                .inp0(A_out[N*(i-1)]),
                .inp1(),
                .sel(),
                .out()
            );
        end 
    end
endgenerate*/

// Right rotator
// TODO: if this does not work change to other answer in:
// https://electronics.stackexchange.com/questions/588602/how-to-rotate-bits-in-verilog
assign Y = (A >> B) | (A << (N-B));

endmodule