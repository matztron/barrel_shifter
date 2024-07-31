module data_rev_mux_tb();

    localparam N = 8;

    wire [N-1:0] A_hat_tb;
    reg [N-1:0] A_tb;
    reg left_tb;

    //
    data_rev_mux #(
        .N(8) // width
    ) data_rev_mux_I
    (
        .left(left_tb),
        .A(A_tb),
        .A_hat(A_hat_tb)
    );

    initial begin
        $dumpfile("out/data_rev_mux.vcd");
        $dumpvars(0, data_rev_mux_tb);

        A_tb = 8'b0110_1000;
        left_tb = 1'b1;

        #10;

        left_tb = 1'b0;

        #10;

        A_tb = 8'b0010_1101;

        #10;

        left_tb = 1'b1;

        #20;
    end

endmodule