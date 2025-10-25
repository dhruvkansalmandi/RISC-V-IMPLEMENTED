module instructionMemory(
    input [31:0] addr,
    output [31:0] instruction
);

reg [31:0] memory [0:255];   // 256 x 32-bit memory
assign instruction = memory[addr[9:2]];  // word-addressable

integer i;  // iterator

initial begin
    // Initialize memory with NOP (optional)
    for (i = 0; i <= 255; i = i + 1)
        memory[i] = 32'h00000013;

    // Load instructions from external file
    $readmemh("instruction.txt", memory);
end

endmodule

