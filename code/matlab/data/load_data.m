%%
WTvsNOS11_cPRC_INNOS=importdata('data/211129_WTvsNOS11_cPRC_INNOS.csv');
WTvsNOS23_cPRC=importdata('data/211121_WTvsNOS23_cPRC.csv');
WTvsNOS23_cPRC_INRGWa=importdata('data/211209_WTvsNOS23_cPRC_INRGWa.csv');

d1=WTvsNOS11_cPRC_INNOS.data;
d2=WTvsNOS23_cPRC.data;
d3=WTvsNOS23_cPRC_INRGWa.data;

wt_cPRC.data=[d1(:,2:37) d2(:,2:9) d3(:,2:4)];

ko_cPRC.data=[d1(:,65:82) d2(:,10:24) d3(:,13:34)]; %1-18 NOS11 %19:55 NOS23

ko11_cPRC.data=ko_cPRC.data(:,1:18);
ko23_cPRC.data=ko_cPRC.data(:,19:55);

%%
WTvsNOS11_cPRC_INNOS=importdata('data/211129_WTvsNOS11_cPRC_INNOS.csv');

wt_INNOS.data=WTvsNOS11_cPRC_INNOS.data(:,38:64);
ko_INNOS.data=WTvsNOS11_cPRC_INNOS.data(:,83:103);

%%
WTvsNOS23_cPRC_INRGWa=importdata('data/211209_WTvsNOS23_cPRC_INRGWa.csv');

wt_INRGW.data=WTvsNOS23_cPRC_INRGWa.data(:,5:12);
ko_INRGW.data=WTvsNOS23_cPRC_INRGWa.data(:,35:56);

%%
mo_cPRC=importdata('data/220522_NIT2-MO1and2_cPRC.csv');
%1 time 
%2-22 mo1 
%23-54 mo2

mo1_cPRC.data=mo_cPRC.data(:,2:22);
mo2_cPRC.data=mo_cPRC.data(:,23:54);
mo_cPRC.data=mo_cPRC.data(:,2:54);
%%
mo_INRGW=importdata('data/220812_NIT2-MO1and2_INRGW.csv');

mo1_INRGW.data=mo_INRGW.data(:,2:14);
mo2_INRGW.data=mo_INRGW.data(:,15:26);
mo_INRGW.data=mo_INRGW.data(:,2:26);

%%
mo_INNOS=importdata('data/220812_NIT2-MO1and2_INNOS.csv');

mo1_INNOS.data=mo_INNOS.data(:,2:13);
mo2_INNOS.data=mo_INNOS.data(:,14:27);
mo_INNOS.data=mo_INNOS.data(:,2:27);


