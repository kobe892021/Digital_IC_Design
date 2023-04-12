module rails(clk, reset, data, valid, result);

input        clk;
input        reset;
input  [3:0] data;
output       valid;
output       result;

reg valid, result;

reg [3:0] answer = 0;
reg [3:0] count = 0;
reg [3:0] digit = 1;
reg [3:0] ptr1 = 0;
reg [3:0] top1 = 0;
reg [3:0] ptr2 = 0;

reg [3:0] stack [9:0];
reg [3:0] order [9:0];
reg [1:0] state;

parameter IDLE = 2'b00;
parameter PUSH = 2'b01;
parameter POP = 2'b10;
parameter OUTPUT = 2'b11;

always @(posedge clk) begin
    if(reset)begin
        state = IDLE;
        answer = 0;
        count = 0;
        digit = 1;
        ptr1 = 0;
        top1 = 0;
        ptr2 = 0;
        valid = 0;
        stack[0] = 4'b0000;
        stack[1] = 4'b0000;
        stack[2] = 4'b0000;
        stack[3] = 4'b0000;
        stack[4] = 4'b0000;
        stack[5] = 4'b0000;
        stack[6] = 4'b0000;
        stack[7] = 4'b0000;
        stack[8] = 4'b0000;
        stack[9] = 4'b0000;
        order[0] = 4'b0000;
        order[1] = 4'b0000;
        order[2] = 4'b0000;
        order[3] = 4'b0000;
        order[4] = 4'b0000;
        order[5] = 4'b0000;
        order[6] = 4'b0000;
        order[7] = 4'b0000;
        order[8] = 4'b0000;
        order[9] = 4'b0000;
    end else begin
        if(data)begin
            if(answer == 0)begin
                answer = data;
            end else begin
                order[top1] = data;
                top1 = top1 + 1;
            end
        end else begin
            answer=answer;        
        end
    end
end

always @(posedge clk && answer) begin
    case (state)
        IDLE:begin
     valid = 0;
            state = PUSH;
 end
        PUSH:
            if(ptr2 > answer - 1)begin
                state = OUTPUT;
            end else begin
                stack[ptr2] = digit;
                digit = digit + 1;

                state = POP; 
            end
        POP:
            if(count == answer)begin
                state = OUTPUT;
            end else begin
                if(ptr2 < 0)begin
                    state = IDLE;
                end else begin
                    if(stack[ptr2] == order[ptr1])begin
                        count = count + 1;
                        ptr2 = ptr2 - 1;
                        ptr1 = ptr1 + 1;

                        state = POP;
                    end else begin
                        ptr2 = ptr2+1;

                        state = PUSH;
                    end
                end
            end

        OUTPUT:begin
            if(count == answer)begin
                result = 1;
            end else begin
                result = 0;
            end
            valid = 1;
            state = IDLE;
            answer = 0;
            count = 0;
            digit = 1;
            ptr1 = 0;
            top1 = 0;
            ptr2 = 0;
            stack[0] = 4'b0000;
            stack[1] = 4'b0000;
            stack[2] = 4'b0000;
            stack[3] = 4'b0000;
            stack[4] = 4'b0000;
            stack[5] = 4'b0000;
            stack[6] = 4'b0000;
            stack[7] = 4'b0000;
            stack[8] = 4'b0000;
            stack[9] = 4'b0000;
            order[0] = 4'b0000;
            order[1] = 4'b0000;
            order[2] = 4'b0000;
            order[3] = 4'b0000;
            order[4] = 4'b0000;
            order[5] = 4'b0000;
            order[6] = 4'b0000;
            order[7] = 4'b0000;
            order[8] = 4'b0000;
            order[9] = 4'b0000;
        end
    endcase
end

endmodule