
module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule

module or2 (input wire i0, i1, output wire o);
  assign o = i0 | i1;
endmodule

module xor2 (input wire i0, i1, output wire o);
  assign o = i0 ^ i1;
endmodule
module singlesig(input wire A,B,output wire G,P); // for one byte only 
	xor2 Pi(A,B,P);
	and2 Gi(A,B,G);
endmodule

module sepsig(input wire[15:0]A,B,output wire[15:0]G,P); //instantiate for all 16 bits
	singlesig I0(A[0],B[0],G[0],P[0]);
	singlesig I1(A[1],B[1],G[1],P[1]);
	singlesig I2(A[2],B[2],G[2],P[2]);
	singlesig I3(A[3],B[3],G[3],P[3]);
	singlesig I4(A[4],B[4],G[4],P[4]);
	singlesig I5(A[5],B[5],G[5],P[5]);
	singlesig I6(A[6],B[6],G[6],P[6]);
	singlesig I7(A[7],B[7],G[7],P[7]);
	singlesig I8(A[8],B[8],G[8],P[8]);
	singlesig I9(A[9],B[9],G[9],P[9]);
	singlesig I10(A[10],B[10],G[10],P[10]);
	singlesig I11(A[11],B[11],G[11],P[11]);
	singlesig I12(A[12],B[12],G[12],P[12]);
	singlesig I13(A[13],B[13],G[13],P[13]);
	singlesig I14(A[14],B[14],G[14],P[14]);
	singlesig I15(A[15],B[15],G[15],P[15]);
//a=0110
//b=1010
//p=1100
//g=0010
endmodule

module blocksig(input wire gen1,gen2,prop1,prop2,output wire gbl,pbl);
	wire t;
	and2 Pij(prop1,prop2,pbl);
	and2 bl2(prop1,gen2,t);
	or2 Gij(gen1,t,gbl);
endmodule

module sumcalc(input wire P,cin, output wire S);
	xor2 sum(P,cin,S);
endmodule

module prefix(input wire[15:0]G,P,input wire cin,output wire[15:0]S,Gi,output wire cout);


	wire P0i,G0201,P0201,G0403,P0403,G0605,P0605,G0807,P0807,G1009,P1009,G1211,P1211,G1413,P1413,P01i,
	P02i,G0503,P0503,G0603,P0603,G0907,P0907,G1007,P1007,G1311,P1311,G1411,P1411,P03i,P04i,P05i,P06i,G1107,
	P1107,G1207,P1207,G1307,P1307,G1407,P1407,P07i,P08i,P09i,P10i,
	P11i,P12i,P13i,P14i,P15i;


	blocksig tree1(G[0],cin,P[0],1'b1,Gi[0],P0i);   //first byte of G and P;P0=p[0]
	blocksig tree2(G[2],G[1],P[2],P[1],G0201,P0201);   //P2:1 = P[2]*P[1]; G2:1= G[2] + G[1].P[2]
	blocksig tree3(G[4],G[3],P[4],P[3],G0403,P0403);  //P4:3=P[3]*P[4], G4:3=G[4]+G[3].P[4]
	blocksig tree4(G[6],G[5],P[6],P[5],G0605,P0605);  //P6:5=P[6]*P[5], G6:5=G[6]+G[5].P[6]
	blocksig tree5(G[8],G[7],P[8],P[7],G0807,P0807);  //P8:7=P[8]*P[7], G8:7=G[8]+G[7].P[8]
	blocksig tree6(G[10],G[9],P[10],P[9],G1009,P1009);  //P10:9=P[10]*P[9], G10:9=G[10]+G[9].P[10]
	blocksig tree7(G[12],G[11],P[12],P[11],G1211,P1211);  //P12:11=P[12]*P[11], G812:11=G[12]+G[11].P[12]
	blocksig tree8(G[14],G[13],P[14],P[13],G1413,P1413);  //P14:13=P[14]*P[13], G14:13=G[14]+G[13].P[14]
	blocksig tree9(G[1],Gi[0],P[1],P0i,Gi[1],P01i);  
	blocksig tree10(G0201,Gi[0],P0201,P0i,Gi[2],P02i);
	blocksig tree11(G[5],G0403,P[5],P0403,G0503,P0503);
	blocksig tree12(G0605,G0403,P0605,P0403,G0603,P0603);
	blocksig tree13(G[9],G0807,P[9],P0807,G0907,P0907);
	blocksig tree14(G1009,G0807,P1009,G0807,G1007,P1007);
	blocksig tree15(G[13],G1211,P[13],P1211,G1311,P1311);
	blocksig tree16(G1413,G1211,P1413,P1211,G1411,P1411);
	blocksig tree17(G[3],Gi[2],P[3],P02i,Gi[3],P03i);
	blocksig tree18(G0403,Gi[2],P0403,Gi[2],Gi[4],P04i);
	blocksig tree19(G0503,Gi[2],P0503,Gi[2],Gi[5],P05i);
	blocksig tree20(G0603,Gi[2],P0603,P02i,Gi[6],P06i);
	blocksig tree21(G[11],G1007,P[11],P1007,G1107,P1107);
	blocksig tree22(G1211,G1007,P1211,P1007,G1207,P1207);
	blocksig tree23(G1311,G1007,P1311,P1007,G1307,P1307);
	blocksig tree24(G1411,G1007,P1411,P1007,G1407,P1407);
	blocksig tree25(G[7],Gi[6],P[7],P06i,Gi[7],P07i);
	blocksig tree26(G0807,Gi[6],P0807,P06i,Gi[8],P08i);
	blocksig tree27(G0907,Gi[6],P0907,P06i,Gi[9],P09i);
	blocksig tree28(G1007,Gi[6],P1007,P06i,Gi[10],P10i);
	blocksig tree29(G1107,Gi[6],P1107,P06i,Gi[11],P11i);
	blocksig tree30(G1207,Gi[6],P1207,P06i,Gi[12],P12i);
	blocksig tree31(G1307,Gi[6],P1307,Gi[6],Gi[13],P13i);
	blocksig tree32(G1407,Gi[6],P1407,Gi[6],Gi[14],P14i);
	blocksig tree33(G[15],Gi[14],P[15],P14i,cout,P15i);
	sumcalc s0(P[0],cin,S[0]);
	sumcalc s1(P[1],Gi[0],S[1]);
	sumcalc s2(P[2],Gi[1],S[2]);
	sumcalc s3(P[3],Gi[2],S[3]);
	sumcalc s4(P[4],Gi[3],S[4]);
	sumcalc s5(P[5],Gi[4],S[5]);
	sumcalc s6(P[6],Gi[5],S[6]);
	sumcalc s7(P[7],Gi[6],S[7]);
	sumcalc s8(P[8],Gi[7],S[8]);
	sumcalc s9(P[9],Gi[8],S[9]);
	sumcalc s10(P[10],Gi[9],S[10]);
	sumcalc s11(P[11],Gi[10],S[11]);
	sumcalc s12(P[12],Gi[11],S[12]);
	sumcalc s13(P[13],Gi[12],S[13]);
	sumcalc s14(P[14],Gi[13],S[14]);
	sumcalc s15(P[15],Gi[14],S[15]);
endmodule




module testbench;
	reg [15:0]A,B;
	reg cin;
	wire [15:0]S,Gi;
	wire cout;
	prefix p(A,B,cin,S,Gi,cout);
	initial begin
		$dumpfile("miniproject.vcd");
		$dumpvars(0,testbench); end
	initial 
	begin
		A=16'b0000000000000010;
		B=16'b0000000000000010;
		cin=1'b0;
	end
	initial begin
		$monitor($time, "A=%b B=%b Cin=%b S=%b Cout=%b Gi=%b",A,B,cin,S,cout,Gi);
	end
endmodule
