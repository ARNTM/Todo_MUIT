module chromaProcessor(	
				input wire [9:0]	img_R,
				input wire [9:0]	img_G,
				input wire [9:0]	img_B,

				input wire [9:0] 	video_R,
				input wire [9:0] 	video_G,
				input wire [9:0] 	video_B,
				
				input wire videoEnable, imageEnable,
				
				input wire [9:0] thG,
				
				output [9:0] out_R, out_G, out_B
		);

					

wire canRemove;
wire [9:0] red, green, blue;

assign canRemove = (video_G > thG) & ((video_G - video_R) > (thG >> 2)) & ((video_G - video_B) > (thG >> 2));

//Imagen a mostrar en zona verde
assign red = img_R;
assign green = img_G;
assign blue = img_B;

//Sustitución
assign out_R = (videoEnable && imageEnable) ? (canRemove ? red : video_R) : (videoEnable) ? video_R : (imageEnable) ? red : 2;
assign out_G = (videoEnable && imageEnable) ? (canRemove ? green : video_G) : (videoEnable) ? video_G : (imageEnable) ? green : 2;
assign out_B = (videoEnable && imageEnable) ? (canRemove ? blue : video_B) : (videoEnable) ? video_B : (imageEnable) ? blue : 2;


endmodule 