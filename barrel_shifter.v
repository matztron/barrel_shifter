// Barrel shifter design
// ---
// Date: 17.07.24
// Implemented by Matthias Musch 
// Following paper "Design alternatives for barrel shifters" from Matthew R. Pillmeier ()
// See: 
// -----------------------------------------


// presented implementations implement many operations using a lot of shared hardware:
// functions:
// - shift right logical
// - shift right arithmetic
// - rotate right
// - shift left logical
// - shift left arithmetic
// - rotate left

// Types of barrel shifters presented in paper
// - Mux-based data-reversal barrel shifters
// - Mask-based data-reversal barrel shifters <--------------- this one is quick and small! :)
// - Mask-based two's complement barrel shifters
// - Mask-based one's complement barrel shifters

// Optimization goals of designs
// - area
// - delay

// A: input operand (N-bit value; N is to the power of 2)
// B: shift/roate amount (log2(N) bits that represents values from 0 to N-1)
// Y: shifted/rotated result

// Opcode
// [left] [rotate] [arithmetic]  [Operation]
// 0      0        0             -> shift right logical
// 0      0        1             -> shift right arithmetic
// 0      1        X             -> rotate right
// 1      0        0             -> shift left logical
// 1      0        1             -> shift left arithmetic
// 1      1        X             -> rotate left
// Additional control signals, sra and sla, are set to one when performing 
// ...shift right arithmetic and shift left arithmetic operations, respectively.

// Overflow: Only occurs when performing a shift-left arithmetic operation and one or more of the shifted-out bits differ from the sign bit
// Zero flag: Is '1' when Y is zero

// - Mask based Data-Reversal Barrel Shifter -
module barrel_shifter 
#(
    parameter N = 8 // width of input (A) and output (B)
)
(
    input [N-1:0] A,
    input [$clog2(N)-1:0] B,
    input [2:0] opcode,
    output [N-1:0] Y,
    output overflow_flag,
    output zero_flag
);

wire left, rotate, arithmetic;

wire [N-1:0] P_msk;
wire [N-1:0] F_msk;
wire [N-1:0] Y_hat;
wire [N-1:0] T_msk;
wire [N-1:0] Z_msk;

wire [N-1:0] A_hat;

wire [N-1:0] Y_internal;

wire s;
wire sla, sra;

// left is opcode[2]
// rotate is opcode[1]
// arithmetic is opcode[0]
//assign [left, rotate, arithmetic] = opcode; 
assign left = opcode[2];
assign rotate = opcode[1];
assign arithmetic = opcode[0];

// set sla, slr
assign sla = left & arithmetic;
assign sra = ~left & arithmetic;

//------------------
//Calculate F mask
fmsk #(
    .N(N) // width
) fmsk_I
(
    .B(B),
    .F(F_msk)
);
//------------------

//------------------
// Calculate P mask
// To facilitate both rotating and shifting, each bit of the F mask is ored with the rotate signal to produce the P mask
// This sets P mask to all 1 for roations
assign P_msk = F_msk | rotate; // TODO: Bitwise OReach bit of fmask with rotate signal!!!
//------------------

//------------------
// Data reversal MUX
data_rev_mux #(
        .N(N) // width
    ) data_rev_mux_I1
    (
        .left(left),
        .A(A),
        .A_hat(A_hat)
    );
//------------------

//------------------
// Right rotator
right_rotator #(
        .N(N) // width
    ) right_rotator
    (
        .B(B),
        .A(A_hat),
        .Y(Y_hat)
    );
//------------------

//------------------
// Calculate T (temporary result)
assign T_msk[0] = (Y_hat[0] & ~sla) | (sla & A[N-1]);

generate 
    for(genvar i=1; i<N; i=i+1) begin : T_LOOP
        assign T_msk[i] = (Y_hat[i] & P_msk[i]) | (s & ~P_msk[i]);
    end
endgenerate
//...where s:
assign s = sra & A[N-1];
//------------------

//------------------
// Data reversal MUX
data_rev_mux #(
        .N(N) // width
    ) data_rev_mux_I2
    (
        .left(left),
        .A(T_msk),
        .A_hat(Y_internal)
    );
//------------------

//------------------
// Calculate Z mask
assign Z_msk[0] = P_msk[N-1] | sla;

generate 
    for(genvar i=1; i<N; i=i+1) begin : Z_LOOP
        assign Z_msk[i] = ~sla & P_msk[N-1-i] | sla & P_msk[N-1];
    end
endgenerate
//------------------

//------------------
// Calculate zero flag
assign zero_flag = ~|(Z_msk & A_hat);
//------------------

//------------------
// Calculate overflow flag
assign overflow_flag = |((A[N-1] ^ A[N-2:0]) & ~F_msk) & sla;
//------------------


// set output
assign Y = Y_internal;

endmodule