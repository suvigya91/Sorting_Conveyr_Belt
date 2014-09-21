%vid = videoinput('winvideo',1,'YUY2_1024x768');
vid = videoinput('winvideo', 1, 'RGB24_640x480');
%display('Video object created \m/');
triggerconfig(vid,'manual');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat', Inf);
vid.ReturnedColorSpace='rgb';

start(vid);

 COM='COM66';
 s = serial(COM,'BaudRate',9600);
 fopen(s);
     %unfiltered ball

%for i=1:50
 %   trigger(vid);
 %   r=getdata(vid,1);
%end
display('Video object created \m/');
t=tic;
count=0;

while(1)
sflagr=0;
trigger(vid);
c=getdata(vid,1);

%for q=1:768
%    for w=1:768
%        c(q,w,1)=inpt(q,w,1);
%        c(q,w,3)=inpt(q,w,3);
%        c(q,w,2)=inpt(q,w,2);
%    end
%end
c_g=rgb2gray(c);
[m n z]=size(c_g);
rball1=zeros(m,n);
rball2=zeros(m,n);
rball3=zeros(m,n);
rball_f=zeros(m,n); 

rball1(find(c(:,:,1)>170))=1;
rball2(find(c(:,:,2)<120))=1;
rball3(find(c(:,:,3)<150))=1;
rball=rball1.*rball2.*rball3;
[x_b y_b]=find(rball);
s_x_b=size(x_b);

rrbot_f=medfilt2(rball,[3 3]);
rcc=bwconncomp(rrbot_f);
rprop=regionprops(rcc,'all');

ridx = find([rprop.Area] > 3000);
rf_i = ismember(labelmatrix(rcc), ridx);
rcount=length(ridx);

bball1=zeros(m,n);
bball2=zeros(m,n);
bball3=zeros(m,n);
bball_f=zeros(m,n); 

bball1(find(c(:,:,1)<120))=1;
bball2(find(c(:,:,2)<120))=1;
bball3(find(c(:,:,3)>120))=1;
bball=bball1.*bball2.*bball3;
[x_b y_b]=find(bball);
s_x_b=size(x_b);

brbot_f=medfilt2(bball,[3 3]);
bcc=bwconncomp(brbot_f);
bprop=regionprops(bcc,'all');

bidx = find([bprop.Area] > 3000);
bf_i = ismember(labelmatrix(bcc), bidx);
bcount=length(bidx);

if(rcount>=1)
    subplot(2,1,1),imshow(c);
    subplot(2,1,2),imshow(rball);
    subplot(3,1,3),imshow(rf_i); 
    %imshow(f_i);
    disp('red');
    disp(rcount);
    command=1;
    
elseif(bcount>=1)
    disp('blue');
    subplot(2,1,1),imshow(c);
    subplot(2,1,2),imshow(bball);
    subplot(3,1,3),imshow(bf_i); 
    command=2; 
    disp(bcount);
else
        command=0;

end
if(command~=0)
fwrite(s,command);
disp(command);
pause(5);
end

% sflagr=0;
% sflagr=fread(s);
% while(sflagr~=10)
%         sflagr=fread(s);    
% end

end
