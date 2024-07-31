module barrel_shifter_tb();

    localparam N = 8;

    reg [N-1:0] A_tb;
    reg [$clog2(N)-1:0] B_tb;
    reg [2:0] opcode_tb;

    wire [N-1:0] Y_tb;
    wire overflow_flag_tb;
    wire zero_flag_tb;

    //
    barrel_shifter 
    #(
        .N(N) // width of input (A) and output (B)
    )
    barrel_shifter_I
    (
        .A(A_tb),
        .B(B_tb),
        .opcode(opcode_tb),
        .Y(Y_tb),
        .overflow_flag(overflow_flag_tb),
        .zero_flag(zero_flag_tb)
    );

    initial begin
        $dumpfile("out/barrel_shifter.vcd");
        $dumpvars(0, barrel_shifter_tb);

        A_tb = 8'b0110_1000;
        B_tb = 3'b001;
        opcode_tb = 3'b100;

        #20;
    end

endmodule