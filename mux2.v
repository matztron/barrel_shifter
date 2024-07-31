module mux2 (
    input inp0,
    input inp1,
    input sel,
    output out
);

    // condition ? if true : if false
    assign out = sel ? inp1 : inp0;

endmodule