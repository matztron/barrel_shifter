module right_rotator_tb();

    localparam N = 8;

    reg [N-1:0] A_tb;
    reg [2:0] B_tb;
    wire [N-1:0] Y_tb;

    //
    right_rotator #(
        .N(8) // width
    ) right_rotator
    (
        .B(B_tb),
        .A(A_tb),
        .Y(Y_tb)
    );

    initial begin
        $dumpfile("out/right_rotator.vcd");
        $dumpvars(0, right_rotator_tb);

        A_tb = 8'b0000_1100;

        B_tb = 3'b000;

        #10;

        B_tb = 3'b001;

        #10;

        B_tb = 3'b010;

        #10;

        B_tb = 3'b011;

        #10;

        B_tb = 3'b100;

        #10;

        B_tb = 3'b101;

        #10;

        B_tb = 3'b110;

        #10;

        B_tb = 3'b111;

        #20;
    end

endmodule