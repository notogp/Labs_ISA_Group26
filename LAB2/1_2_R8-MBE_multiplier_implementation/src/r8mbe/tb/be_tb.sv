module be_tb;
    reg [3:0] y;
    reg [3:0] ctrl;

    be uut (
        .Y_4bits(y),
        .control(ctrl)
    );

    initial begin

            #10;
            y = 4'b0000;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0001;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0010;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0011;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0100;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0101;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0110;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b0111;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b1000;
            $display("y = %b, ctrl = %b", y, ctrl);
            
            #10;
            y = 4'b1001;
            $display("y = %b, ctrl = %b", y, ctrl);
            
    end
    
endmodule