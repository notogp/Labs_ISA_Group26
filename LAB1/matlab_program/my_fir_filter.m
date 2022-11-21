clear all
clc

fs=10000 %% sampling frequency
f1=500;  %% first sinewave freq (in band)
f2=3500; %% second sinnewave freq (out band)

p=1;
%%Names in alphabetic order: Zangeneh, Noto, Greto 
x=8;
y=4;

N=(2^p)*[mod(x,2)+1]+6*p %% filter order N=8
nb=mod(y,7)+8 %% number of bits nb=12



T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples

x1=sin(2*pi*f1*tt); %% first sinewave
x2=sin(2*pi*f2*tt); %% second sinewave

x=(x1+x2)/2; %% input signal

[bi, bq]=myfir_design(N, nb); %% filter design

y=filter(bq, 1, x); %% apply filter

%% plots
figure
plot(tt,x1,'--d');
hold on
plot(tt,x2,'r--s');
plot(tt,x, 'g--+');
plot(tt, y, 'c--o');

legend('x1', 'x2', 'x', 'y')

%% quantize input and output
xq=floor(x*2^(nb-1)); %x values are quantized and stored in xq
idx=find(xq==2^(nb-1)); % with find() we select the indexes where xq == 2^11
xq(idx)=2^(nb-1)-1; % we store in xq the max value -1

yq=floor(y*2^(nb-1));
idy=find(yq==2^(nb-1));
yq(idy)=2^(nb-1)-1;



%% save input and output
fp=fopen('samples.txt','w');
fprintf(fp,'%d\n', xq);
fclose(fp);

fp=fopen('results_m.txt', 'w');
fprintf(fp, '%d\n', yq);
fclose(fp);

figure
thd(yq)
%% THD
file_output = fopen('results_c.txt','r');
formatSpec = '%d';
zq = fscanf(file_output,formatSpec);
fclose(file_output);
figure
thd(zq)