
module MMS_8num(result, select, number0, number1, number2, number3, number4, number5, number6, number7);

input        select;
input  [7:0] number0;
input  [7:0] number1;
input  [7:0] number2;
input  [7:0] number3;
input  [7:0] number4;
input  [7:0] number5;
input  [7:0] number6;
input  [7:0] number7;
output [7:0] result; 

wire [7:0] result1, result2;
reg [7:0] result3;
reg cmp;

/*
	Write Your Design Here ~
*/

MMS_4num MMS_4num_1(result1, select, number0, number1, number2, number3);
MMS_4num MMS_4num_2(result2, select, number4, number5, number6, number7);

always @(*)begin
	if(result1 > result2)
		cmp = 0;
	else
		cmp = 1;
	case({select, cmp})
		2'b00 : result3 = result1;
		2'b01 : result3 = result2;
		2'b10 : result3 = result2;
		2'b11 : result3 = result1;
	endcase
end

assign result = result3;

endmodule