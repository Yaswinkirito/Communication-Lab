clc;
clear all;
close all;
x=randi([0,1],[1,10000]);
t=0:0.01:0.49;
polar=[];
bpsk=[];
BER_pr=[];
BER_t=[];
SNR_dB=[];
SER=[];
for i=1:10000
    if x(i)==1
        x1=ones(1,50);
    elseif x(i)==0
       x1=-1*ones(1,50); 
    end
    polar=[polar x1];
end
t=0:0.01:0.49;
f=10;
f1=sin(2*pi*f*t);
f2=f1./sqrt(sum(f1.*f1));
for i=1:10000
    if x(i)==1
        t1=f2;
    else
        t1=-f2;
    end
    bpsk=[bpsk t1];
end
subplot(3,1,1);
plot(polar);
xlabel('time');
ylabel('amplitude');
title('Polar Waveform')
axis([0,500,-2,2]);
subplot(3,1,2);
plot(f2);
xlabel('time');
ylabel('amplitude');
title('Carrier waveform');

subplot(3,1,3);
plot(bpsk);
xlabel('time');
ylabel('amplitude');
title('BPSK signal');
axis([0,500,-2,2]);
L=length(bpsk);
for j=0:0.01:0.9;
    n=sqrt(j).*randn(1,500000);
    r=bpsk+n;
    z=reshape(r,50,10000);
    h=f2*z;
    if j==0
       scatterplot(h);
       title(['Constellation diagram for noise varience=',num2str(j)]);
    elseif j==0.01
       scatterplot(h);
       title(['Constellation diagram for noise varience=',num2str(j)]);
    elseif j==0.02
       scatterplot(h);
       title(['Constellation diagram for noise varience=',num2str(j)]);
    elseif j==0.5
       scatterplot(h);
       title(['Constellation diagram for noise varience=',num2str(j)]);
    end
end
for j=0:0.1:0.9
    n=sqrt(j).*randn(1,500000);
    r=bpsk+n;
    z=reshape(r,50,10000);
    h=f2*z;
    b=[];
    for i=1:10000
        if h(i)>0
            a=1;
        else
            a=0;
        end
        b=[b a];
    end
    ber=(sum(xor(x,b)))/10000;
    BER_pr=[BER_pr ber];
    SNR=1/(2*j);
    ber_t=0.5*erfc(sqrt(SNR));
    BER_t=[BER_t,ber_t];
    ser=0.5*erfc(sqrt(SNR));
    SER=[SER ser];
    SNR1 =10*log10(SNR);
    SNR_dB=[SNR_dB,SNR1];
end
figure;
semilogy(SNR_dB,BER_pr);
xlabel('SNR');
ylabel('BER');
title('BER vs SNR');
figure
semilogy(SNR_dB,BER_t,'*',SNR_dB,BER_pr,'r');
legend("Theorectical and Practical");
figure;
semilogy(SNR_dB,SER);
xlabel('SNR');
ylabel('SER');
title('SER vs SNR');



