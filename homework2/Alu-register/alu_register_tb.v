`timescale 1ns/1ps

module alu_register_tb();

    parameter WIDTH = 8;

    reg clk;
    reg arstn;
    reg [WIDTH-1:0] first;
    reg [WIDTH-1:0] second;
    reg [2:0] opcode;
    wire [WIDTH-1:0] result;

    alu_register #(.WIDTH(WIDTH)) dut (
        .clk_i(clk),
        .arstn_i(arstn),
        .first_i(first),
        .second_i(second),
        .opcode_i(opcode),
        .result_o(result)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_register_tb);

        clk = 0;
        arstn = 0;
        first = 0;
        second = 0;
        opcode = 0;


        #15;
        arstn = 1;


        @(posedge clk);

        // -------------------------------------------------------------
        // NOR (000)
        // -------------------------------------------------------------
        first = 8'hAA;
        second = 8'h55;
        opcode = 3'b000;
        @(posedge clk);

        // -------------------------------------------------------------
        // AND (001)
        // -------------------------------------------------------------
        opcode = 3'b001;
        @(posedge clk);

        // -------------------------------------------------------------
        // Signed add (010)
        // -------------------------------------------------------------
        first = 8'h02;
        second = 8'hFE;
        opcode = 3'b010;
        @(posedge clk);

        // -------------------------------------------------------------
        // Unsigned add (011)
        // -------------------------------------------------------------
        first = 8'h02;
        second = 8'h03;
        opcode = 3'b011;
        @(posedge clk);

        // -------------------------------------------------------------
        // NOT second (100)
        // -------------------------------------------------------------
        first = 8'h00;
        second = 8'h55;
        opcode = 3'b100;
        @(posedge clk);

        // -------------------------------------------------------------
        // XNOR (101)
        // -------------------------------------------------------------
        first = 8'hCC;
        second = 8'hAA;
        opcode = 3'b101;
        @(posedge clk);

        // -------------------------------------------------------------
        // Compare (110)
        // -------------------------------------------------------------
        first = 8'hAA;
        second = 8'hAA;
        opcode = 3'b110;
        @(posedge clk);

        // -------------------------------------------------------------
        // Shift right (111)
        // -------------------------------------------------------------
        first = 8'h80;
        second = 8'h03;
        opcode = 3'b111;
        @(posedge clk);

        #20;
        $finish;
    end

endmodule
