module MMS_4num(result, select, number0, number1, number2, number3);

input        select;
input  [7:0] number0;
input  [7:0] number1;
input  [7:0] number2;
input  [7:0] number3;
output [7:0] result; 

reg [7:0] result1, result2, result3;
reg cmp;

/*
	Write Your Design Here ~
*/

always @(*)begin
	if(number0 > number1)
		cmp = 0;
	else
		cmp = 1;
	case({select, cmp})
		2'b00 : result1 = number0;
		2'b01 : result1 = number1;
		2'b10 : result1 = number1;
		2'b11 : result1 = number0;
	endcase

	if(number2 > number3)
		cmp = 0;
	else
		cmp = 1;
	case({select, cmp})
		2'b00 : result2 = number2;
		2'b01 : result2 = number3;
		2'b10 : result2 = number3;
		2'b11 : result2 = number2;
	endcase

	if(result1 > result2)
		cmp = 0;
	else
		cmp = 1;
	case({select, cmp})
		2'b00 :  result3 = result1;
		2'b01 :  result3 = result2;
		2'b10 :  result3 = result2;
		2'b11 :  result3 = result1;
	endcase				
end

assign result = result3;

endmodule