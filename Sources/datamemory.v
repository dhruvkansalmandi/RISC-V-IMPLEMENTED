`timescale 1ns/1ps

module dataMemory(
    input clk,
    input MemWrite, MemRead,
    input [31:0] addr, writeData,
    output [31:0] readData
);

reg [31:0] memory [0:63];
wire [7:0] mem_index = addr[9:2];
integer i;

always @(posedge clk) begin
    if (MemWrite) begin
        if (mem_index < 64) begin
            memory[mem_index] <= writeData;
        end else begin
            $display("Write out-of-bounds: addr=%x0h", addr);
        end
    end
end

assign readData = (MemRead && mem_index < 64) ? memory[mem_index] : 32'b0;

initial begin
    for (i = 0; i < 64; i = i + 1) begin
        memory[i] = 32'd0;
    end
end

always @(*) begin
    if (MemRead && mem_index < 64)
        $display("MemRead: Mem[0x%0h] => %0d", addr, memory[mem_index]);
end

endmodule
