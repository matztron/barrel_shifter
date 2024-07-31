module fmsk_tb();

    localparam N = 8;

    wire [N-1:0] F_tb;
    reg [2:0] B_tb;

    //
    fmsk #(
        .N(8) // width
    ) fmsk_I
    (
        .B(B_tb),
        .F(F_tb)
    );

    initial begin
        $dumpfile("out/fmsk.vcd");
        $dumpvars(0, fmsk_tb);

        B_tb = 3'b000;

        #10;

        B_tb = 3'b010;

        #10;

        B_tb = 3'b111;

        #20;
    end

endmodule