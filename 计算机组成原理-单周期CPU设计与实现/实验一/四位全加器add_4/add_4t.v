module adder_4();
    wire[3:0] sum;
    wire cout;
    reg[3:0] a,b;
    reg cin;
    initial
        begin
            #0 a = 4'b0010; b = 4'b0000; cin = 1'b0;
            #5 a = 4'b0000; b = 4'b0000; cin = 1'b0;
            #5 a = 4'b0010; b = 4'b0000; cin = 1'b0;
            #5 a = 4'b0000; b = 4'b0000; cin = 1'b0;
            #5 a = 4'b0000; b = 4'b0001; cin = 1'b1;
            #5 a = 4'b0000; b = 4'b0000; cin = 1'b1;
            #5 a = 4'b0110; b = 4'b0001; cin = 1'b0;
            #5 a = 4'b0101; b = 4'b0000; cin = 1'b1;
	  #5 a = 4'b0011; b = 4'b0000; cin = 1'b1;
	  #5 a = 4'b0001; b = 4'b0000; cin = 1'b1;
            #5 $stop;
        end
    add_4 u1(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
endmodule

